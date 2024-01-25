import 'package:awign_saas/core/extension/common_extension.dart';
import 'package:awign_saas/hrms/attendance/data/model/attendance_response.dart';
import 'package:awign_saas/hrms/attendance/data/model/punch_request.dart';
import 'package:awign_saas/hrms/regularisation/data/model/regularisation_request.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:intl/intl.dart';

import '../../../../../core/data/local/database/user_preferences/user_preferences.dart';
import '../../../../../core/data/model/button_state.dart';
import '../../../../../core/data/model/ui_state.dart';
import '../../../../../core/exception/exception.dart';
import '../../../../../core/utils/app_log.dart';
import '../../../../../core/utils/date_time_helper/date_time_helper.dart';
import '../../../../../core/utils/validator.dart';
import '../../../../reimbursements/data/model/manager_response.dart';
import '../../../../reimbursements/data/network/repository/reimbursement_remote_repository.dart';
import '../../../data/model/regularisation_status_response.dart';
import '../../../data/model/request_regularize_widget_argument.dart';
import '../../../data/network/repository/regularisation_remote_repository.dart';
import 'request_regularise_state.dart';


class RequestRegulariseCubit extends Cubit<RequestRegulariseState> {
  final ReimbursementRemoteRepository _reimbursementRemoteRepository;
  final RegularisationRemoteRepository _regularisationRemoteRepository;
  RequestRegulariseCubit(this._reimbursementRemoteRepository, this._regularisationRemoteRepository) : super(const RequestRegulariseState());

  void updateReason(String? reason) {
    if (Validator.checkReason(reason) == null) {
      emit(state.copyWith(reasonError: null, reason: reason,
          buttonState: ButtonState(isEnable: checkFormValidation())));
    } else {
      emit(state.copyWith(reasonError: Validator.checkReason(reason),
          buttonState: const ButtonState(isEnable: false)));
    }
  }

  void updateRequestRegularizeWidgetArgument(RequestRegularizeWidgetArgument requestRegularizeWidgetArgument) {
    if(requestRegularizeWidgetArgument.attendanceDetails?.date != null) {
      emit(state.copyWith(date: DateTime.parse(requestRegularizeWidgetArgument.attendanceDetails!.date!),
          buttonState: ButtonState(isEnable: checkFormValidation()),
          attendanceDetails: requestRegularizeWidgetArgument.attendanceDetails, attendanceStatusEntity: requestRegularizeWidgetArgument.attendanceStatusEntity));
      if(requestRegularizeWidgetArgument.attendanceDetails?.getPunchInTime() != null) {
        updatePunchInTimeOfDate(TimeOfDay.fromDateTime(DateFormat(DateTimeHelper.timeFormatHMS).parse(requestRegularizeWidgetArgument.attendanceDetails!.getPunchInTime()!)));
      }
    }
  }

  void updatePunchInTimeOfDate(TimeOfDay punchInTimeOfDay) {
    String? punchInTimeError;
    if(state.punchOutTimeOfDay != null && punchInTimeOfDay.compareTo(state.punchOutTimeOfDay!) != -1) {
      punchInTimeError = 'punch_in_time_must_be_less_then_punch_out_time'.tr;
    }
    String? punchOutTimeError;
    if(state.punchOutTimeOfDay != null && state.punchOutTimeOfDay?.compareTo(punchInTimeOfDay) != 1) {
      punchOutTimeError = 'punch_out_time_must_be_greater_then_punch_in_time'.tr;
    }
    emit(state.copyWith(punchInTimeOfDay: punchInTimeOfDay, punchInTimeError: punchInTimeError, punchOutTimeError: punchOutTimeError,
        buttonState: ButtonState(isEnable: (punchInTimeError == null && punchOutTimeError == null) ? checkFormValidation() : false)));
  }

  void updatePunchOutTimeOfDate(TimeOfDay punchOutTimeOfDay) {
    String? punchOutTimeError;
    if(state.punchInTimeOfDay != null && punchOutTimeOfDay.compareTo(state.punchInTimeOfDay!) != 1) {
      punchOutTimeError = 'punch_out_time_must_be_greater_then_punch_in_time'.tr;
    }
    String? punchInTimeError;
    if(state.punchInTimeOfDay != null && state.punchInTimeOfDay?.compareTo(punchOutTimeOfDay) != -1) {
      punchInTimeError = 'punch_in_time_must_be_less_then_punch_out_time'.tr;
    }
    emit(state.copyWith(punchOutTimeOfDay: punchOutTimeOfDay, punchInTimeError: punchInTimeError, punchOutTimeError: punchOutTimeError,
        buttonState: ButtonState(isEnable: (punchInTimeError == null && punchOutTimeError == null) ? checkFormValidation() : false)));
  }

  void updateSelectedManager(Manager? selectedManager) {
    emit(state.copyWith(selectedManager: selectedManager,
        buttonState: ButtonState(isEnable: checkFormValidation())));
  }

  bool checkFormValidation() {
    bool isValid = true;
    if(state.punchInTimeOfDay == null) {
      isValid = false;
    } else if(state.punchOutTimeOfDay == null) {
      isValid = false;
    } else if(Validator.checkReason(state.reason) != null) {
      isValid = false;
    }
    return isValid;
  }

  void getManagers() async {
    try {
      emit(state.copyWith(uiState: UIState(isOnScreenLoading: true)));
      ManagerResponse managerResponse = await _reimbursementRemoteRepository.getManager(UserPreferences.getInstance()
          .getCurrentUser()?.tenant?.userId ?? '');
      Manager? selectedManager;
      if(!managerResponse.manager.isNullOrEmpty && managerResponse.manager?.length == 1) {
        selectedManager = managerResponse.manager![0];
      }
      emit(state.copyWith(managers: managerResponse.manager, selectedManager: selectedManager,
          uiState: UIState(isOnScreenLoading: false, event: Event.reloadWidget)));
    } on ServerException catch (e) {
      emit(state.copyWith(uiState: UIState(isOnScreenLoading: false,
          event: Event.failed, failedWithoutAlertMessage: e.message!)));
    } on FailureException catch (e) {
      emit(state.copyWith(uiState: UIState(isOnScreenLoading: false,
          event: Event.failed, failedWithoutAlertMessage: e.message!)));
    } catch (e, st) {
      AppLog.e('getManagerList : ${e.toString()} \n${st.toString()}');
      emit(state.copyWith(uiState: UIState(isOnScreenLoading: false,
          event: Event.failed, failedWithoutAlertMessage: 'we_regret_the_technical_error'.tr)));
    }
  }

  void requestRegularisation(BuildContext context) async {
    try {
      emit(state.copyWith(buttonState: ButtonState(isLoading: true, message: 'please_wait'.tr)));
      List<PunchData>? punches = [];
      PunchData punchInData = PunchData(punchTime: '${MaterialLocalizations.of(context).formatTimeOfDay(state.punchInTimeOfDay!, alwaysUse24HourFormat: true)}:00', punchType: PunchType.punchIn.value);
      punches.add(punchInData);
      PunchData punchOutData = PunchData(punchTime: '${MaterialLocalizations.of(context).formatTimeOfDay(state.punchOutTimeOfDay!, alwaysUse24HourFormat: true)}:00', punchType: PunchType.punchOut.value);
      punches.add(punchOutData);
      Approval approval = Approval(managerUUID: state.selectedManager!.uuid);
      String strDate = DateTimeHelper.getFormattedDateTime(DateTimeHelper.dateFormatYMD, inputDateTime: state.date);
      RegularisationRequest regularisationRequest = RegularisationRequest(date: strDate, punches: punches,
          approval: approval, reasonComment: state.reason, totalSections: state.attendanceDetails?.status?.length, section: state.attendanceStatusEntity?.section);
      Regularisation regularisation = await _regularisationRemoteRepository.requestRegularisation(regularisationRequest);
      emit(state.copyWith(buttonState: const ButtonState(isEnable: true, isSuccess: true)));
      await Future.delayed(const Duration(milliseconds: 500));
      emit(state.copyWith(uiState: UIState(event: Event.success)));
    } on ServerException catch (e) {
      emit(state.copyWith(buttonState: const ButtonState(isEnable: true),
          uiState: UIState(event: Event.failed, failedWithoutAlertMessage: e.message!)));
    } on FailureException catch (e) {
      emit(state.copyWith(buttonState: const ButtonState(isEnable: true),
          uiState: UIState(event: Event.failed, failedWithoutAlertMessage: e.message!)));
    } catch (e, st) {
      AppLog.e('requestRegularisation : ${e.toString()} \n${st.toString()}');
      emit(state.copyWith(buttonState: const ButtonState(isEnable: true),
          uiState: UIState(event: Event.failed, failedWithoutAlertMessage: 'we_regret_the_technical_error'.tr)));
    }
  }
}
