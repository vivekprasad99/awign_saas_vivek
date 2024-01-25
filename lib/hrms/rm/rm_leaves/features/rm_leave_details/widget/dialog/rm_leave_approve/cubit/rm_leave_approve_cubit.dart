import 'package:awign_saas/hrms/rm/rm_leaves/data/model/update_leave_request.dart';
import 'package:bloc/bloc.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../../../../../../../../core/data/model/button_state.dart';
import '../../../../../../../../../core/data/model/ui_state.dart';
import '../../../../../../../../../core/exception/exception.dart';
import '../../../../../../../../../core/utils/app_log.dart';
import '../../../../../../../../leaves/data/model/leave.dart';
import '../../../../../../data/network/repository/rm_leaves_remote_repository.dart';
import 'rm_leave_approve_state.dart';

class RMLeaveApproveCubit extends Cubit<RMLeaveApproveState> {
  final RMLeavesRemoteRepository _rmLeavesRemoteRepository;
  RMLeaveApproveCubit(this._rmLeavesRemoteRepository) : super(const RMLeaveApproveState());

  updateLeave(Leave leave) {
    emit(state.copyWith(leave: leave));
  }

  void updateRemarks(String? remarks) {
    emit(state.copyWith(remarks: remarks));
  }

  void approveOrDeclineLeave(LeaveStatus leaveStatus) async {
    try {
      emit(state.copyWith(buttonState: ButtonState(isLoading: true, message: 'please_wait'.tr)));
      UpdateLeaveRequest updateLeaveRequest = UpdateLeaveRequest(status: leaveStatus.value,
        leaveTransactionId: state.leave!.id, remarks: state.remarks);
      Leave leave = await _rmLeavesRemoteRepository.approveOrDeclineLeave(updateLeaveRequest);
      String message = '';
      if(leaveStatus == LeaveStatus.approved) {
        message = 'leave_approved'.tr;
      } else {
        message = 'leave_rejected'.tr;
      }
      emit(state.copyWith(buttonState: ButtonState(isEnable: true, isSuccess: true, message: message)));
      await Future.delayed(const Duration(milliseconds: 500));
      emit(state.copyWith(uiState: UIState(event: Event.success)));
    } on ServerException catch (e) {
      emit(state.copyWith(buttonState: const ButtonState(isEnable: true),
          uiState: UIState(event: Event.failed, failedWithoutAlertMessage: e.message!)));
    } on FailureException catch (e) {
      emit(state.copyWith(buttonState: const ButtonState(isEnable: true),
          uiState: UIState(event: Event.failed, failedWithoutAlertMessage: e.message!)));
    } catch (e, st) {
      AppLog.e('approveOrDeclineLeave : ${e.toString()} \n${st.toString()}');
      emit(state.copyWith(buttonState: const ButtonState(isEnable: true),
          uiState: UIState(event: Event.failed, failedWithoutAlertMessage: 'we_regret_the_technical_error'.tr)));
    }
  }

  void approveHolidayLeave(int holidayLeaveID) async {
    try {
      emit(state.copyWith(buttonState: ButtonState(isLoading: true, message: 'please_wait'.tr)));
      Leave leave = await _rmLeavesRemoteRepository.approveHolidayLeave(holidayLeaveID);
      emit(state.copyWith(buttonState: ButtonState(isEnable: true, isSuccess: true, message: 'leave_approved'.tr)));
      await Future.delayed(const Duration(milliseconds: 500));
      emit(state.copyWith(uiState: UIState(event: Event.success)));
    } on ServerException catch (e) {
      emit(state.copyWith(buttonState: const ButtonState(isEnable: true),
          uiState: UIState(event: Event.failed, failedWithoutAlertMessage: e.message!)));
    } on FailureException catch (e) {
      emit(state.copyWith(buttonState: const ButtonState(isEnable: true),
          uiState: UIState(event: Event.failed, failedWithoutAlertMessage: e.message!)));
    } catch (e, st) {
      AppLog.e('approveHolidayLeave : ${e.toString()} \n${st.toString()}');
      emit(state.copyWith(buttonState: const ButtonState(isEnable: true),
          uiState: UIState(event: Event.failed, failedWithoutAlertMessage: 'we_regret_the_technical_error'.tr)));
    }
  }

  void rejectHolidayLeave(int holidayLeaveID) async {
    try {
      emit(state.copyWith(buttonState: ButtonState(isLoading: true, message: 'please_wait'.tr)));
      Leave leave = await _rmLeavesRemoteRepository.rejectHolidayLeave(holidayLeaveID);
      emit(state.copyWith(buttonState: ButtonState(isEnable: true, isSuccess: true, message: 'leave_rejected'.tr)));
      await Future.delayed(const Duration(milliseconds: 500));
      emit(state.copyWith(uiState: UIState(event: Event.success)));
    } on ServerException catch (e) {
      emit(state.copyWith(buttonState: const ButtonState(isEnable: true),
          uiState: UIState(event: Event.failed, failedWithoutAlertMessage: e.message!)));
    } on FailureException catch (e) {
      emit(state.copyWith(buttonState: const ButtonState(isEnable: true),
          uiState: UIState(event: Event.failed, failedWithoutAlertMessage: e.message!)));
    } catch (e, st) {
      AppLog.e('rejectHolidayLeave : ${e.toString()} \n${st.toString()}');
      emit(state.copyWith(buttonState: const ButtonState(isEnable: true),
          uiState: UIState(event: Event.failed, failedWithoutAlertMessage: 'we_regret_the_technical_error'.tr)));
    }
  }
}
