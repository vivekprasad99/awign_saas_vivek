import 'package:awign_saas/core/data/local/database/user_preferences/user_preferences.dart';
import 'package:awign_saas/core/data/model/ui_state.dart';
import 'package:awign_saas/core/utils/constants.dart';
import 'package:awign_saas/hrms/holidays/data/model/holiday_search_response.dart';
import 'package:awign_saas/hrms/leaves/data/model/apply_leave_request.dart';
import 'package:awign_saas/hrms/regularisation/data/model/regularisation_status_response.dart';
import 'package:bloc/bloc.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import '../../../../../core/data/model/button_state.dart';
import '../../../../../core/exception/exception.dart';
import '../../../../../core/utils/app_log.dart';
import '../../../../../core/utils/date_time_helper/date_time_helper.dart';
import '../../../../../core/utils/validator.dart';
import '../../../../attendance/data/model/attendance_response.dart';
import '../../../data/model/apply_leave_response.dart';
import '../../../data/model/leave_balance_response.dart';
import '../../../data/model/leave_types_response.dart';
import '../../../data/network/repository/leaves_remote_repository.dart';
import 'apply_leave_state.dart';

class ApplyLeaveCubit extends Cubit<ApplyLeaveState> {
  final LeavesRemoteRepository _leavesRemoteRepository;
  ApplyLeaveCubit(this._leavesRemoteRepository) : super(const ApplyLeaveState(buttonState: ButtonState(), selectedShiftType: ShiftType.fullDay));

  void updateReason(String? reason) {
    if (Validator.checkReason(reason) == null) {
      emit(state.copyWith(reasonError: null, reason: reason,
          buttonState: ButtonState(isEnable: checkFormValidation())));
    } else {
      emit(state.copyWith(reasonError: Validator.checkReason(reason),
          buttonState: const ButtonState(isEnable: false)));
    }
  }

  void updateSelectedLeaveType(LeaveTypeEntity? selectedLeaveType) {
    String leaveBalanceMessage = '${selectedLeaveType?.name} ${'balance'.tr} - ${state.leavesBalance?[selectedLeaveType?.name] ?? 0}';
    emit(state.copyWith(selectedLeaveTypeEntity: selectedLeaveType, leavesBalanceMessage: leaveBalanceMessage,
        buttonState: ButtonState(isEnable: checkFormValidation())));
  }

  void updateFromDate(DateTime fromDate) {
    String? fromDateError;
    if(state.toDate != null && fromDate.isAfter(state.toDate!)) {
      fromDateError = 'from_date_must_be_less_then_to_date'.tr;
    }
    String? toDateError;
    if(state.toDate != null && state.toDate!.isBefore(fromDate)) {
      toDateError = 'to_date_must_be_greater_then_from_date'.tr;
    }
    emit(state.copyWith(fromDate: fromDate,
        buttonState: ButtonState(isEnable: (fromDateError == null && toDateError == null) ? checkFormValidation() : false),
        fromDateError: fromDateError, toDateError: toDateError));
  }

  void updateToDate(DateTime toDate) {
    String? toDateError;
    if(state.fromDate != null && toDate.isBefore(state.fromDate!)) {
      toDateError = 'to_date_must_be_greater_then_from_date'.tr;
    }
    String? fromDateError;
    if(state.fromDate != null && state.fromDate!.isAfter(toDate)) {
      fromDateError = 'from_date_must_be_less_then_to_date'.tr;
    }
    emit(state.copyWith(toDate: toDate,
        buttonState: ButtonState(isEnable: (fromDateError == null && toDateError == null) ? checkFormValidation() : false),
        fromDateError: fromDateError, toDateError: toDateError));
  }

  bool checkFormValidation() {
    bool isValid = true;
    if(state.selectedLeaveTypeEntity == null) {
      isValid = false;
    } else if(state.fromDate == null) {
      isValid = false;
    } else if(state.toDate == null && state.attendanceDetails == null && state.regularisation == null) {
      isValid = false;
    } else if(Validator.checkReason(state.reason) != null) {
      isValid = false;
    }
    return isValid;
  }

  updateSelectedShift(ShiftType selectedShift) {
    emit(state.copyWith(selectedShiftType: selectedShift));
  }

  updateAttendanceDetails(AttendanceDetails attendance, AttendanceStatusEntity? attendanceStatusEntity) {
    emit(state.copyWith(attendanceDetails: attendance, fromDate: DateTime.parse(attendance.date!),
    toDate: attendanceStatusEntity != null ? DateTime.parse(attendance.date!) : null, attendanceStatusEntity: attendanceStatusEntity,
    selectedShiftType: ShiftType.getShiftByIndex(attendanceStatusEntity?.section)));
    updateButtonStatus();
  }

  updateRegularisation(Regularisation regularisation) {
    emit(state.copyWith(regularisation: regularisation, fromDate: DateTime.parse(regularisation.date!)));
    updateButtonStatus();
  }

  updateButtonStatus() {
    emit(state.copyWith(buttonState: ButtonState(isEnable: checkFormValidation())));
  }

  void getLeaveTypes() async {
    try {
      emit(state.copyWith(uiState: UIState(isOnScreenLoading: true)));
      LeaveTypesResponse leaveTypesResponse = await _leavesRemoteRepository.getLeaveTypes(LeaveType.regular.value);
      LeaveTypeEntity? selectedLeaveTypeEntity;
      if(leaveTypesResponse.leaves?.length == 1) {
        selectedLeaveTypeEntity = leaveTypesResponse.leaves![0];
        updateSelectedLeaveType(selectedLeaveTypeEntity);
      }
      updateLeaveTypesAccordingToCompOffLeave();
      emit(state.copyWith(leaves: leaveTypesResponse.leaves,
          uiState: UIState(isOnScreenLoading: false, event: Event.reloadWidget)));
    } on ServerException catch (e) {
      emit(state.copyWith(uiState: UIState(isOnScreenLoading: false,
          event: Event.failed, failedWithoutAlertMessage: e.message!)));
    } on FailureException catch (e) {
      emit(state.copyWith(uiState: UIState(isOnScreenLoading: false,
          event: Event.failed, failedWithoutAlertMessage: e.message!)));
    } catch (e, st) {
      AppLog.e('getLeaveTypes : ${e.toString()} \n${st.toString()}');
      emit(state.copyWith(uiState: UIState(isOnScreenLoading: false,
          event: Event.failed, failedWithoutAlertMessage: 'we_regret_the_technical_error'.tr)));
    }
  }

  void getLeaveBalance() async {
    try {
      emit(state.copyWith(isLeaveBalanceLoading: true));
      LeaveBalanceResponse leaveBalanceResponse = await _leavesRemoteRepository.getLeaveBalance();
      emit(state.copyWith(isLeaveBalanceLoading: false, leavesBalance: leaveBalanceResponse.leaves));
      if(state.selectedLeaveTypeEntity != null) {
        updateSelectedLeaveType(state.selectedLeaveTypeEntity);
      }
      updateLeaveTypesAccordingToCompOffLeave();
    } on ServerException catch (e) {
      emit(state.copyWith(isLeaveBalanceLoading: false, leavesBalance: null, uiState: UIState(failedWithoutAlertMessage: e.message!)));
    } on FailureException catch (e) {
      emit(state.copyWith(isLeaveBalanceLoading: false, leavesBalance: null, uiState: UIState(failedWithoutAlertMessage: e.message!)));
    } catch (e, st) {
      AppLog.e('searchLeaves : ${e.toString()} \n${st.toString()}');
      emit(state.copyWith(isLeaveBalanceLoading: false, leavesBalance: null, uiState: UIState(failedWithoutAlertMessage: 'we_regret_the_technical_error'.tr)));
    }
  }

  updateLeaveTypesAccordingToCompOffLeave() {
    if(!(state.leavesBalance?.containsKey(Keys.compOff) ?? false) && state.leaves != null) {
      List<LeaveTypeEntity> tempLeaveTypeList = [];
      tempLeaveTypeList.addAll(state.leaves!);
      tempLeaveTypeList.removeWhere((item) => (item.name != null && item.name!.toLowerCase().replaceFirst('-', ' ').contains(Keys.compOff.toLowerCase().replaceFirst('-', ' '))));
      emit(state.copyWith(leaves: tempLeaveTypeList));
    }
  }

  void applyLeave() async {
    try {
      emit(state.copyWith(buttonState: ButtonState(isLoading: true, message: 'please_wait'.tr)));
      String strFromDate = DateTimeHelper.getFormattedDateTime(DateTimeHelper.dateFormatYMD, inputDateTime: state.fromDate);
      String? strToDate = DateTimeHelper.getFormattedDateTime(DateTimeHelper.dateFormatYMD, inputDateTime: state.toDate);
      String? shiftType;
      bool startDateHalfDayAllowed = false;
      if(state.fromDate != null && state.toDate != null && state.fromDate!.isAtSameMomentAs(state.toDate!)) {
        if(state.selectedShiftType == ShiftType.firstHalf || state.selectedShiftType == ShiftType.secondHalf
            || state.selectedShiftType == ShiftType.fullDay) {
          strToDate = null;
          shiftType = state.selectedShiftType?.value;
          startDateHalfDayAllowed = true;
          if(state.selectedShiftType == ShiftType.fullDay) {
            startDateHalfDayAllowed = false;
            shiftType = null;
          }
        }
      }
      int? leaveID = state.selectedLeaveTypeEntity?.id;
      if(state.attendanceDetails != null || state.regularisation != null) {
        strToDate = null;
      }
      ApplyLeaveRequest applyLeaveRequest = ApplyLeaveRequest(leaveId: leaveID,
          startDate: strFromDate, endDate: strToDate, reason: state.reason, startDateHalfDayAllowed: startDateHalfDayAllowed,
          shift: shiftType);
      ApplyLeaveResponse applyLeaveResponse = await _leavesRemoteRepository.applyLeave(applyLeaveRequest,
          UserPreferences.getInstance().getCurrentUser()?.tenant?.organization ?? '');
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
      AppLog.e('applyLeave : ${e.toString()} \n${st.toString()}');
      emit(state.copyWith(buttonState: const ButtonState(isEnable: true),
          uiState: UIState(event: Event.failed, failedWithoutAlertMessage: 'we_regret_the_technical_error'.tr)));
    }
  }
}
