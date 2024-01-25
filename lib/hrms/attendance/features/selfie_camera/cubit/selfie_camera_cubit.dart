import 'dart:io';
import 'package:awign_saas/core/data/model/button_state.dart';
import 'package:awign_saas/core/extension/common_extension.dart';
import 'package:awign_saas/hrms/attendance/data/model/today_attendance_status.dart';
import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import '../../../../../core/config/cubit/flavor_cubit.dart';
import '../../../../../core/data/local/database/model/current_user/work_location.dart';
import '../../../../../core/data/local/database/user_preferences/user_preferences.dart';
import '../../../../../core/data/model/ui_state.dart';
import '../../../../../core/exception/exception.dart';
import '../../../../../core/location/location_helper.dart';
import '../../../../../core/utils/app_log.dart';
import '../../../../../core/utils/file_utils.dart';
import '../../../../file_storage_remote/model/aws_upload_result.dart';
import '../../../../file_storage_remote/repository/upload_remote_storage/remote_storage_repository.dart';
import '../../../data/model/punch_request.dart';
import '../../../data/model/punch_response.dart';
import '../../../data/network/repository/attendance_remote_repository.dart';
import 'selfie_camera_state.dart';


class SelfieCameraCubit extends Cubit<SelfieCameraState> {
  final AttendanceRemoteRepository _attendanceRemoteRepository;
  SelfieCameraCubit(this._attendanceRemoteRepository) : super(const SelfieCameraState());

  updateArguments(PunchType? punchType, AttendanceType attendanceType) {
    emit(state.copyWith(punchType: punchType, attendanceType: attendanceType));
  }

  updateClickPictureButtonState(bool isLoading) {
    emit(state.copyWith(clickPictureBtnState: ButtonState(isEnable: true, isLoading: isLoading, message: isLoading ? 'please_wait'.tr : null)));
  }

  updateRawImage(XFile? rawImage) {
    emit(state.copyWith(rawImage: rawImage, isShowImagePreview: true, clickPictureBtnState: const ButtonState(isLoading: false, isEnable: true),
      submitBtnState: const ButtonState(isEnable: true)));
  }

  getLocationAndAddress(WorkLocation? workLocation) async {
    try {
        switch(state.attendanceType) {
          case AttendanceType.geo:
          case AttendanceType.selfieAndGeo:
          emit(state.copyWith(isPlaceMarksLoading: true, submitBtnState: const ButtonState(isEnable: false)));
          try {
            Position position = await LocationHelper.getCurrentLocation();
            List<Placemark> placeMarks = await placemarkFromCoordinates(position.latitude, position.longitude);
            emit(state.copyWith(position: position, placeMarkList: placeMarks, isPlaceMarksLoading: false));
            if(workLocation?.punchRadius != null && workLocation?.latitude != null && workLocation?.longitude != null) {
              double distance = Geolocator.distanceBetween(workLocation!.latitude!, workLocation.longitude!,
                  position.latitude, position.longitude);
              if(distance > workLocation.punchRadius!.toDouble()) {
                emit(state.copyWith(submitBtnState: const ButtonState(isEnable: false),
                    uiState: UIState(event: Event.failed, failedWithoutAlertMessage: 'you_are_not_in_your_work_location'.tr),
                    workLocationErrorMessage: 'please_move_to_your_work_location_to_mark_attendance'.tr));
                return;
              }
            }
            emit(state.copyWith(isPlaceMarksLoading: false, workLocationErrorMessage: null, submitBtnState: const ButtonState(isEnable: true)));
          } catch (e, st) {
            AppLog.e('getLocationAndAddress : ${e.toString()} \n${st.toString()}');
            emit(state.copyWith(submitBtnState: const ButtonState(isEnable: false), uiState: UIState(event: Event.locationSetting)));
          }
            break;
          default:
        }
    } catch (e, st) {
      AppLog.e('getAddressFromLatLong : ${e.toString()} \n${st.toString()}');
    }
  }

  showCamera() {
    emit(state.copyWith(isShowImagePreview: false));
  }

  void compressUploadImageAndDoPunch(FlavorCubit flavorCubit) async {
    emit(state.copyWith(submitBtnState: ButtonState(isLoading: true, message: 'compressing_image'.tr)));
    try {
      String? targetPath = await FileUtils.getImageFilePath(Get.context!);
      if(targetPath != null) {
        var result = await FlutterImageCompress.compressAndGetFile(
          state.rawImage!.path,
          targetPath,
          quality: 50,
        );
        uploadImage(targetPath, flavorCubit);
      }
    } catch (e, stacktrace) {
      AppLog.e('compressImage : ${e.toString()} \n${stacktrace.toString()}');
    }
  }

  void uploadImage(String filePath, FlavorCubit flavorCubit) async {
    try {
      emit(state.copyWith(compressedImageFilePath: filePath, submitBtnState: ButtonState(isLoading: true, message: 'uploading'.tr)));
      Geolocation? geolocation;
      if(state.attendanceType != null) {
        switch(state.attendanceType!) {
          case AttendanceType.normal:
            break;
          case AttendanceType.geo:
          case AttendanceType.selfieAndGeo:
            geolocation = Geolocation(latitude: state.position?.latitude, longitude: state.position?.longitude);
            break;
          case AttendanceType.selfie:
            break;
        }
      }
      File file = File(filePath);
      RemoteStorageRepository remoteStorageRepository = RemoteStorageRepository();
      remoteStorageRepository.getUploadPercentageStream().listen((progress) {
        int percentValue = progress ?? 0;
        double value = 0.0;
        if(progress != null) {
          value = (progress as int).toDouble() / 100;
        }
        emit(state.copyWith(submitBtnState: ButtonState(isLoading: true, message: '$percentValue% ${'uploading'.tr}',
            percentValue: percentValue, progressValue: value)));
      });
      String? updatedFileName;
      updatedFileName = file.name!.split('/').last;
      AWSUploadResult? aWSUploadResult = await remoteStorageRepository.uploadFile(
          file, updatedFileName, flavorCubit.flavorConfig.s3bucketName, flavorCubit.flavorConfig.s3FolderPath);
      doPunchInPunchOut(aWSUploadResult?.url ?? '', geolocation);
    } catch(e) {
      emit(state.copyWith(submitBtnState: const ButtonState(isEnable: true)));
    }
  }

  void doPunchInPunchOut(String url, Geolocation? geolocation) async {
    try {
      emit(state.copyWith(s3ImageURL: url, submitBtnState: ButtonState(isLoading: true, message: 'submitting'.tr)));
      PunchRequest punchRequest = PunchRequest(punchType: state.punchType?.value, geolocation: geolocation, selfieUrl: url);
      PunchResponse punchResponse = await _attendanceRemoteRepository.doPunchInPunchOut(punchRequest);
      emit(state.copyWith(uiState: UIState(event: Event.updated, successWithAlertMessage: punchResponse.message ?? '')));
    } on ServerException catch (e) {
      emit(state.copyWith(submitBtnState: const ButtonState(isEnable: true), uiState: UIState(event: Event.failed, failedWithoutAlertMessage: e.message!)));
    } on FailureException catch (e) {
      emit(state.copyWith(submitBtnState: const ButtonState(isEnable: true), uiState: UIState(event: Event.failed, failedWithoutAlertMessage: e.message!)));
    } catch (e, st) {
      AppLog.e('doPunchInPunchOut : ${e.toString()} \n${st.toString()}');
      emit(state.copyWith(submitBtnState: const ButtonState(isEnable: true), uiState: UIState(event: Event.failed, failedWithoutAlertMessage: 'we_regret_the_technical_error'.tr)));
    }
  }
}
