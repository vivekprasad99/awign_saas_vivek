import 'package:awign_saas/core/data/model/ui_state.dart';
import 'package:awign_saas/hrms/comp_off/data/model/apply_comp_off_request.dart';
import 'package:awign_saas/hrms/comp_off/data/model/apply_comp_off_response.dart';
import 'package:awign_saas/hrms/comp_off/data/network/repository/comp_off_remote_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import '../../../../../core/data/model/button_state.dart';
import '../../../../../core/exception/exception.dart';
import '../../../../../core/utils/app_log.dart';
import '../../../../../core/utils/date_time_helper/date_time_helper.dart';
import '../../../../../core/utils/validator.dart';
import 'apply_comp_off_state.dart';

class ApplyCompOffCubit extends Cubit<ApplyCompOffState> {
  final CompOffRemoteRepository _compOffRemoteRepository;
  ApplyCompOffCubit(this._compOffRemoteRepository) : super(const ApplyCompOffState(buttonState: ButtonState()));

  void updateReason(String? reason) {
    if (Validator.checkReason(reason) == null) {
      emit(state.copyWith(reasonError: null, reason: reason,
          buttonState: ButtonState(isEnable: checkFormValidation())));
    } else {
      emit(state.copyWith(reasonError: Validator.checkReason(reason),
          buttonState: const ButtonState(isEnable: false)));
    }
  }

  void updateDate(DateTime dateTime) {
    emit(state.copyWith(date: dateTime, buttonState: ButtonState(isEnable: checkFormValidation())));
  }

  bool checkFormValidation() {
    bool isValid = true;
    if(state.date == null) {
      isValid = false;
    } else if(Validator.checkReason(state.reason) != null) {
      isValid = false;
    }
    return isValid;
  }

  updateButtonStatus() {
    emit(state.copyWith(buttonState: ButtonState(isEnable: checkFormValidation())));
  }

  void applyCompOff() async {
    try {
      emit(state.copyWith(buttonState: ButtonState(isLoading: true, message: 'please_wait'.tr)));
      String strDate = DateTimeHelper.getFormattedDateTime(DateTimeHelper.dateFormatYMD, inputDateTime: state.date);
      ApplyCompOffRequest applyCompOffRequest = ApplyCompOffRequest(workDate: strDate, employeeRemark: state.reason);
      ApplyCompOffResponse applyLeaveResponse = await _compOffRemoteRepository.applyCompOff(applyCompOffRequest);
      emit(state.copyWith(buttonState: ButtonState(isEnable: true, isSuccess: true, message: applyLeaveResponse.message ?? '')));
      await Future.delayed(const Duration(milliseconds: 500));
      emit(state.copyWith(uiState: UIState(event: Event.success, successWithoutAlertMessage: applyLeaveResponse.message ?? '')));
    } on ServerException catch (e) {
      emit(state.copyWith(buttonState: const ButtonState(isEnable: true),
          uiState: UIState(event: Event.failed, failedWithoutAlertMessage: e.message!)));
    } on FailureException catch (e) {
      emit(state.copyWith(buttonState: const ButtonState(isEnable: true),
          uiState: UIState(event: Event.failed, failedWithoutAlertMessage: e.message!)));
    } catch (e, st) {
      AppLog.e('applyCompOff : ${e.toString()} \n${st.toString()}');
      emit(state.copyWith(buttonState: const ButtonState(isEnable: true),
          uiState: UIState(event: Event.failed, failedWithoutAlertMessage: 'we_regret_the_technical_error'.tr)));
    }
  }
}
