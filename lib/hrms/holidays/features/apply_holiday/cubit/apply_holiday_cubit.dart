import 'package:awign_saas/core/data/local/database/user_preferences/user_preferences.dart';
import 'package:awign_saas/core/data/model/ui_state.dart';
import 'package:awign_saas/hrms/holidays/data/model/holiday_search_response.dart';
import 'package:awign_saas/hrms/holidays/data/network/repository/holiday_remote_repository.dart';
import 'package:awign_saas/hrms/reimbursements/data/model/manager_response.dart';
import 'package:awign_saas/hrms/reimbursements/data/network/repository/reimbursement_remote_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import '../../../../../core/data/model/button_state.dart';
import '../../../../../core/exception/exception.dart';
import '../../../../../core/utils/app_log.dart';
import '../../../../../core/utils/validator.dart';
import '../../../../leaves/data/model/apply_leave_response.dart';
import '../../../data/model/apply_holiday_request.dart';
import 'apply_holiday_state.dart';

class ApplyHolidayCubit extends Cubit<ApplyHolidayState> {
  final HolidayRemoteRepository _holidayRemoteRepository;
  final ReimbursementRemoteRepository _reimbursementRemoteRepository;
  ApplyHolidayCubit(this._holidayRemoteRepository, this._reimbursementRemoteRepository) : super(const ApplyHolidayState(buttonState: ButtonState()));

  void updateHoliday(Holiday holiday) {
    try {
      emit(state.copyWith(holiday: holiday, date: DateTime.parse(holiday.date!)));
    } catch (e, st) {
      AppLog.e('updateHoliday : ${e.toString()} \n${st.toString()}');
    }
  }

  void updateReason(String? reason) {
    if (Validator.checkReason(reason) == null) {
      emit(state.copyWith(reasonError: null, reason: reason,
          buttonState: ButtonState(isEnable: checkFormValidation())));
    } else {
      emit(state.copyWith(reasonError: Validator.checkReason(reason),
          buttonState: const ButtonState(isEnable: false)));
    }
  }

  void updateSelectedManager(Manager manager) {
    emit(state.copyWith(selectedManager: manager, buttonState: ButtonState(isEnable: checkFormValidation())));
  }

  bool checkFormValidation() {
    bool isValid = true;
    if(state.date == null) {
      isValid = false;
    } else if(state.selectedManager == null) {
      isValid = false;
    } else if(Validator.checkReason(state.reason) != null) {
      isValid = false;
    }
    return isValid;
  }

  updateButtonStatus() {
    emit(state.copyWith(buttonState: ButtonState(isEnable: checkFormValidation())));
  }

  void getManagerList() async {
    try {
      emit(state.copyWith(uiState: UIState(isOnScreenLoading: true)));
      ManagerResponse managerResponse =
      await _reimbursementRemoteRepository.getManager(UserPreferences.getInstance().getCurrentUser()?.tenant?.userId ?? '');
      Manager? selectedManager;
      if(managerResponse.manager?.length == 1) {
        selectedManager = managerResponse.manager![0];
      }
      emit(state.copyWith(managerList: managerResponse.manager, selectedManager: selectedManager,
          uiState: UIState(isOnScreenLoading: false, event: Event.reloadWidget)));
    } on ServerException catch (e) {
      emit(state.copyWith(
          uiState: UIState(isOnScreenLoading: false, failedWithoutAlertMessage: e.message!)));
    } on FailureException catch (e) {
      emit(state.copyWith(
          uiState: UIState(isOnScreenLoading: false, failedWithoutAlertMessage: e.message!)));
    } catch (e, st) {
      AppLog.e('getReimbursement : ${e.toString()} \n${st.toString()}');
      emit(state.copyWith(uiState: UIState(isOnScreenLoading: false,
              failedWithoutAlertMessage: 'we_regret_the_technical_error'.tr)));
    }
  }

  void applyHolidayLeave() async {
    try {
      emit(state.copyWith(buttonState: ButtonState(isLoading: true, message: 'please_wait'.tr)));
      ApplyHolidayRequest applyHolidayRequest = ApplyHolidayRequest(holidayID: state.holiday?.id ?? -1,
        reason: state.reason, managerUUID: state.selectedManager?.uuid ?? '');
      ApplyLeaveResponse applyLeaveResponse = await _holidayRemoteRepository.applyHolidayLeave(applyHolidayRequest);
      emit(state.copyWith(buttonState: const ButtonState(isEnable: true, isSuccess: true)));
      await Future.delayed(const Duration(milliseconds: 500));
      emit(state.copyWith(uiState: UIState(event: Event.success, successWithoutAlertMessage: 'holiday_leave_applied_successfully'.tr)));
    } on ServerException catch (e) {
      emit(state.copyWith(buttonState: const ButtonState(isEnable: true),
          uiState: UIState(event: Event.failed, failedWithoutAlertMessage: e.message!)));
    } on FailureException catch (e) {
      emit(state.copyWith(buttonState: const ButtonState(isEnable: true),
          uiState: UIState(event: Event.failed, failedWithoutAlertMessage: e.message!)));
    } catch (e, st) {
      AppLog.e('applyHolidayLeave : ${e.toString()} \n${st.toString()}');
      emit(state.copyWith(buttonState: const ButtonState(isEnable: true),
          uiState: UIState(event: Event.failed, failedWithoutAlertMessage: 'we_regret_the_technical_error'.tr)));
    }
  }
}
