import 'dart:io';

import 'package:awign_saas/core/data/model/button_state.dart';
import 'package:awign_saas/core/data/model/ui_state.dart';
import 'package:awign_saas/core/exception/exception.dart';
import 'package:awign_saas/core/extension/common_extension.dart';
import 'package:awign_saas/core/utils/app_log.dart';
import 'package:awign_saas/core/utils/file_picker_helper.dart';
import 'package:awign_saas/core/utils/file_utils.dart';
import 'package:awign_saas/core/utils/string_utils.dart';
import 'package:awign_saas/core/utils/validator.dart';
import 'package:awign_saas/hrms/file_storage_remote/repository/upload_remote_storage/remote_storage_repository.dart';
import 'package:awign_saas/hrms/reimbursements/data/model/appy_reimbursement_data.dart';
import 'package:awign_saas/hrms/reimbursements/data/model/category_response.dart';
import 'package:awign_saas/hrms/reimbursements/data/model/manager_response.dart';
import 'package:awign_saas/hrms/reimbursements/data/model/reimbursement_type_response.dart';
import 'package:awign_saas/hrms/reimbursements/data/network/repository/reimbursement_remote_repository.dart';
import 'package:awign_saas/hrms/reimbursements/features/reimbursements_form/cubit/reimbursement_form_state.dart';
import 'package:bloc/bloc.dart';
import 'package:get/get.dart';

import '../../../../../core/config/cubit/flavor_cubit.dart';
import '../../../../file_storage_remote/model/aws_upload_result.dart';

class ReimbursementFormCubit extends Cubit<ReimbursementFormState> {
  final ReimbursementRemoteRepository _reimbursementRemoteRepository;

  ReimbursementFormCubit(this._reimbursementRemoteRepository)
      : super(const ReimbursementFormState());

  void updateSelectedReimbursementType(ReimbursementType? reimbursementType) {
    List<ReimbursementSubType>? reimbursementSubTypes;
    ReimbursementSubType? selectedReimbursementSubType;
    if(reimbursementType?.reimbursementSubTypes?.length == 1) {
      selectedReimbursementSubType = reimbursementType?.reimbursementSubTypes![0];
    }
    ReimbursementCategory? selectedReimbursementCategory = getReimbursementCategoryByReimbursementSubType(selectedReimbursementSubType);
    reimbursementSubTypes = reimbursementType?.reimbursementSubTypes;
    emit(state.copyWith(
        selectedReimbursementType: reimbursementType,
        reimbursementSubTypes: reimbursementSubTypes, selectedReimbursementSubType: selectedReimbursementSubType,
        selectedReimbursementCategory: selectedReimbursementCategory,
        buttonState: ButtonState(isEnable: checkFormValidation())));
  }

  void updateSelectedReimbursementSubType(ReimbursementSubType? reimbursementSubType) {
    ReimbursementCategory? selectedReimbursementCategory = getReimbursementCategoryByReimbursementSubType(reimbursementSubType);
    emit(state.copyWith(
        selectedReimbursementSubType: reimbursementSubType,
        selectedReimbursementCategory: selectedReimbursementCategory,
        buttonState: ButtonState(isEnable: checkFormValidation())));
  }

  void updateVendorName(String? vendorName) {
    emit(state.copyWith(vendorName: vendorName));
  }

  void updateStayDate(String? stayDate) {
    emit(state.copyWith(stayDate: stayDate));
  }

  void updateFromDestination(String? fromDestination) {
    emit(state.copyWith(fromDestination: fromDestination));
  }

  void updateStayLocation(String? stayLocation) {
    emit(state.copyWith(stayLocation: stayLocation));
  }

  void updateToDestination(String? toDestination) {
    emit(state.copyWith(toDestination: toDestination));
  }

  void updateDateOfTravel(String? dateOfTravel) {
    emit(state.copyWith(dateOfTravel: dateOfTravel));
  }

  void updateDistanceTravelled(String? distanceTravelled) {
    emit(state.copyWith(distanceTravelled: distanceTravelled));
  }

  void selectManager(Manager? value) {
    emit(state.copyWith(
        manager: value,
        buttonState: ButtonState(isEnable: checkFormValidation())));
  }

  void selectDate(DateTime? date, String dateType) {
    if (dateType == 'from') {
      emit(state.copyWith(
          fromSelectedDate: date,
          buttonState: ButtonState(isEnable: checkFormValidation())));
    } else {
      emit(state.copyWith(
          toSelectedDate: date,
          buttonState: ButtonState(isEnable: checkFormValidation())));
    }
  }

  bool checkFormValidation() {
    bool isValid = true;
    if (state.reimbursementTypes != null && state.selectedReimbursementType == null) {
      isValid = false;
    } else if (state.selectedReimbursementSubType == null) {
      isValid = false;
    } else if (state.fromSelectedDate == null) {
      isValid = false;
    } else if (state.toSelectedDate == null
        && state.selectedReimbursementCategory?.reimbursementSubType == 'telecom') {
      isValid = false;
    } else if (state.amount == null) {
      isValid = false;
    } else if (state.manager == null) {
      isValid = false;
    }
    return isValid;
  }

  void updateAmount(String? amount) {
    if (Validator.checkNumber(amount) == null) {
      emit(state.copyWith(
          amountError: null,
          amount: amount,
          buttonState:  ButtonState(isEnable: checkFormValidation())));
    } else {
      emit(state.copyWith(
          amountError: Validator.checkNumber(amount),
          buttonState: ButtonState(isEnable: checkFormValidation())));
    }
  }

  void updateRemark(String? remark) {
    emit(state.copyWith(
        remarkError: null,
        remark: remark,
        buttonState: ButtonState(isEnable: checkFormValidation())));
  }

  void updateReceipt(String? receiptNo) {
    emit(state.copyWith(
        receiptNoError: null,
        receiptNo: receiptNo));
  }

  void onApplyTap() async {
    try {
      if(state.fileName != null && (state.uploadPercentValue ?? 0) < 100) {
        emit(state.copyWith(uiState: UIState(failedWithoutAlertMessage: 'file_uploading_is_in_progress_please_wait'.tr)));
        return;
      }
      emit(state.copyWith(buttonState: ButtonState(isLoading: true, message: 'please_wait'.tr)));
      ApplyReimbursementData applyReimbursementData = ApplyReimbursementData(
          name: state.remark,
          startDate: StringUtils.parseDateTimeToDate(state.fromSelectedDate!, dateFormat: StringUtils.dateFormatYMD),
          endDate: StringUtils.parseDateTimeToDate(state.toSelectedDate == null ? state.fromSelectedDate! : state.toSelectedDate!, dateFormat: StringUtils.dateFormatYMD),
          description: state.remark,
          reimbursement: [
            Reimbursement(
              reimbursementCategoryId: state.selectedReimbursementCategory?.id,
              attachmentUrl: state.uploadedFileURL,
              amount: double.parse(state.amount!),
              comments: state.remark,
              invoiceNumber: state.receiptNo,
              invoiceDate: null,
              approverId: state.manager?.uuid,
              metadata: (state.selectedReimbursementSubType?.metadata?.isMetadataFieldsAvailable() ?? false) ?
              getMetadataRequestPayload(state.selectedReimbursementSubType?.metadata, state.vendorName,
              state.stayDate, state.fromDestination, state.stayLocation, state.toDestination, state.dateOfTravel, state.distanceTravelled)
              : null,
            )
          ]);
      var data = await _reimbursementRemoteRepository.createReimbursement(applyReimbursementData);
      emit(state.copyWith(buttonState: const ButtonState(isEnable: true, isSuccess: true)));
      await Future.delayed(const Duration(milliseconds: 500));
      emit(state.copyWith(uiState: UIState(event: Event.success, successWithAlertMessage: '')));
    } on ServerException catch (e) {
      emit(state.copyWith(buttonState: const ButtonState(isEnable: true), uiState: UIState(
              event: Event.failed, failedWithoutAlertMessage: e.message!)));
    } on FailureException catch (e) {
      emit(state.copyWith(buttonState: const ButtonState(isEnable: true), uiState: UIState(
              event: Event.failed, failedWithoutAlertMessage: e.message!)));
    } catch (e, st) {
      AppLog.e('onApplyTap : ${e.toString()} \n${st.toString()}');
      emit(state.copyWith(buttonState: const ButtonState(isEnable: true), uiState: UIState(
              event: Event.failed, failedWithoutAlertMessage: 'we_regret_the_technical_error'.tr)));
    }
  }

  Metadata getMetadataRequestPayload(Metadata? metadata, String? vendorName, String? stayDate,
      String? fromDestination, String? stayLocation, String? toDestination, String? dateOfTravel, String? distanceTravelled) {
    return Metadata(vendorName: metadata?.vendorName != null ? vendorName : null,
      stayDate: metadata?.stayDate != null ? stayDate : null,
      fromDestination: metadata?.fromDestination != null ? fromDestination : null,
      stayLocation: metadata?.stayLocation != null ? stayLocation : null,
      toDestination: metadata?.toDestination != null ? toDestination : null,
      dateOfTravel: metadata?.dateOfTravel != null ? dateOfTravel : null,
      distanceTravelled: metadata?.distanceTravelled != null ? distanceTravelled : null,
    );
  }

  ReimbursementCategory? getReimbursementCategoryByReimbursementSubType(ReimbursementSubType? reimbursementSubType) {
    if(reimbursementSubType != null && !state.reimbursementCategories.isNullOrEmpty) {
      return state.reimbursementCategories!.where((element) => element.reimbursementSubTypeId == reimbursementSubType.id).firstOrNull;
    }
    return null;
  }

  void getReimbursementCategories() async {
    try {
      ReimbursementCategoryResponse reimbursementCategoryResponse = await _reimbursementRemoteRepository.getReimbursementCategory();
      emit(state.copyWith(reimbursementCategories: reimbursementCategoryResponse.categories));
    } on ServerException catch (e) {
      emit(state.copyWith(uiState: UIState(failedWithoutAlertMessage: e.message!)));
    } on FailureException catch (e) {
      emit(state.copyWith(uiState: UIState(failedWithoutAlertMessage: e.message!)));
    } catch (e, st) {
      AppLog.e('getReimbursementCategory : ${e.toString()} \n${st.toString()}');
      emit(state.copyWith(uiState: UIState(failedWithoutAlertMessage: 'we_regret_the_technical_error'.tr)));
    }
  }

  void getReimbursementTypes() async {
    try {
      emit(state.copyWith(isReimbursementTypesLoading: true));
      ReimbursementTypeResponse reimbursementTypeResponse =
      await _reimbursementRemoteRepository.getReimbursementTypes();
      List<ReimbursementType>? reimbursementTypes;
      List<ReimbursementSubType>? reimbursementSubTypes;
      ReimbursementType? selectedReimbursementType;
      ReimbursementSubType? selectedReimbursementSubType;
      if(reimbursementTypeResponse.reimbursementTypes?.length == 1) {
        if(reimbursementTypeResponse.reimbursementTypes![0].type != null) {
          reimbursementTypes = reimbursementTypeResponse.reimbursementTypes;
        }
        selectedReimbursementType = reimbursementTypeResponse.reimbursementTypes![0];
        if(selectedReimbursementType.reimbursementSubTypes?.length == 1) {
          selectedReimbursementSubType = selectedReimbursementType.reimbursementSubTypes![0];
        }
        reimbursementSubTypes = selectedReimbursementType.reimbursementSubTypes;
      } else if ((reimbursementTypeResponse.reimbursementTypes?.length ?? 0) > 1) {
        reimbursementTypes = reimbursementTypeResponse.reimbursementTypes;
      }
      emit(state.copyWith(reimbursementTypes: reimbursementTypes,
        reimbursementSubTypes: reimbursementSubTypes, selectedReimbursementType: selectedReimbursementType,
        selectedReimbursementSubType: selectedReimbursementSubType, isReimbursementTypesLoading: false));
    } on ServerException catch (e) {
      emit(state.copyWith(reimbursementTypes: null,
          reimbursementSubTypes: null, selectedReimbursementType: null,
          selectedReimbursementSubType: null, isReimbursementTypesLoading: false,
          uiState: UIState(failedWithoutAlertMessage: e.message!)));
    } on FailureException catch (e) {
      emit(state.copyWith(reimbursementTypes: null,
          reimbursementSubTypes: null, selectedReimbursementType: null,
          selectedReimbursementSubType: null, isReimbursementTypesLoading: false,
          uiState: UIState(failedWithoutAlertMessage: e.message!)));
    } catch (e, st) {
      AppLog.e('getReimbursementTypes : ${e.toString()} \n${st.toString()}');
      emit(state.copyWith(reimbursementTypes: null,
          reimbursementSubTypes: null, selectedReimbursementType: null,
          selectedReimbursementSubType: null, isReimbursementTypesLoading: false,
          uiState: UIState(failedWithoutAlertMessage: 'we_regret_the_technical_error'.tr)));
    }
  }

  void onSelectPDFTap(FlavorCubit flavorCubit) {
    final RemoteStorageRepository remoteStorageRepository = RemoteStorageRepository();
    remoteStorageRepository.getUploadPercentageStream().listen((progress) {
      int percentValue = progress ?? 0;
      double value = 0.0;
      if(progress != null) {
        value = (progress as int).toDouble() / 100;
      }
      emit(state.copyWith(uploadPercentValue: percentValue, uploadProgressValue: value));
    });
    FilePickerHelper.pickMedia((result) async {
      File file = File(result.files.single.path ?? '');
      AppLog.i('File : ${file.path}');
      AppLog.i('Name : ${result.names[0]}');
      String? updatedFileName;
      updatedFileName = file.name!.split('/').last;
      emit(state.copyWith(fileName: updatedFileName, uploadPercentValue: 0, uploadProgressValue: 0));
      int totalFileSize = await FileUtils.getFileSizeInBytes(file.path, 2);
      emit(state.copyWith(totalFileSize: totalFileSize));
      AWSUploadResult? awsUploadResult = await remoteStorageRepository.uploadFile(
          file, updatedFileName, flavorCubit.flavorConfig.s3bucketName,
          flavorCubit.flavorConfig.s3FolderPath);
      // emit(state.copyWith(uploadedFileURL: awsUploadResult?.url));
      emit(state.copyWith(uploadedFileURL: 'https://awign-staging.s3.ap-south-1.amazonaws.com/hrms/$updatedFileName'));
    });
  }

  void getManager(String id) async {
    try {
      ManagerResponse managerResponse =
          await _reimbursementRemoteRepository.getManager(id);
      Manager? selectedManager;
      if(managerResponse.manager?.length == 1) {
        selectedManager = managerResponse.manager![0];
      }
      emit(state.copyWith(managerResponse: managerResponse, manager: selectedManager));
    } on ServerException catch (e) {
      emit(state.copyWith(
          uiState: UIState(failedWithoutAlertMessage: e.message!)));
    } on FailureException catch (e) {
      emit(state.copyWith(
          uiState: UIState(failedWithoutAlertMessage: e.message!)));
    } catch (e, st) {
      AppLog.e('getReimbursement : ${e.toString()} \n${st.toString()}');
      emit(state.copyWith(
          uiState: UIState(
              failedWithoutAlertMessage: 'we_regret_the_technical_error'.tr)));
    }
  }
}
