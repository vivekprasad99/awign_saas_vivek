import 'package:awign_saas/hrms/attendance/data/model/today_attendance_status.dart';
import 'package:camera/camera.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import '../../../../../core/data/model/button_state.dart';
import '../../../../../core/data/model/ui_state.dart';
import '../../../data/model/punch_request.dart';

part 'selfie_camera_state.g.dart';

@CopyWith()
class SelfieCameraState extends Equatable {
  final UIState? uiState;
  final bool? isLoading;
  final bool? isCameraPermissionGranted;
  final ButtonState? clickPictureBtnState;
  final ButtonState? submitBtnState;
  final XFile? rawImage;
  final bool? isShowImagePreview;
  final List<Placemark>? placeMarkList;
  final bool? isPlaceMarksLoading;
  final String? compressedImageFilePath;
  final String? s3ImageURL;
  final PunchType? punchType;
  final Position? position;
  final AttendanceType? attendanceType;
  final String? workLocationErrorMessage;

  const SelfieCameraState({this.uiState, this.isLoading, this.isCameraPermissionGranted,
    this.clickPictureBtnState, this.rawImage, this.isShowImagePreview, this.submitBtnState, this.placeMarkList, this.isPlaceMarksLoading,
    this.compressedImageFilePath, this.s3ImageURL, this.punchType, this.position,
    this.attendanceType, this.workLocationErrorMessage});

  @override
  List<Object?> get props => [uiState, isLoading, isCameraPermissionGranted,
    clickPictureBtnState, rawImage, isShowImagePreview, submitBtnState, placeMarkList, isPlaceMarksLoading,
      compressedImageFilePath, s3ImageURL, punchType, position, attendanceType, workLocationErrorMessage];
}
