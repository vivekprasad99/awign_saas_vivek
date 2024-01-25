import 'package:awign_saas/core/data/local/database/user_preferences/user_preferences.dart';
import 'package:awign_saas/core/data/model/button_state.dart';
import 'package:bloc/bloc.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../../../../core/data/model/ui_state.dart';
import '../../../../../core/exception/exception.dart';
import '../../../../../core/utils/app_log.dart';
import '../../../../holidays/data/network/repository/holiday_remote_repository.dart';
import '../../../data/model/leave.dart';
import '../../../data/network/repository/leaves_remote_repository.dart';
import 'leave_details_state.dart';

class LeaveDetailsCubit extends Cubit<LeaveDetailsState> {
  final LeavesRemoteRepository _leavesRemoteRepository;
  final HolidayRemoteRepository _holidayRemoteRepository;
  LeaveDetailsCubit(this._leavesRemoteRepository, this._holidayRemoteRepository) : super(const LeaveDetailsState());

  void getLeaveDetails(int leaveID) async {
    try {
      emit(state.copyWith(uiState: UIState(isOnScreenLoading: true)));
      Leave leave = await _leavesRemoteRepository.getLeaveDetails(leaveID, UserPreferences.getInstance().getCurrentUser()?.tenant?.organization ?? '');
      emit(state.copyWith(leave: leave,
          uiState: UIState(isOnScreenLoading: false, event: Event.reloadWidget)));
    } on ServerException catch (e) {
      emit(state.copyWith(uiState: UIState(isOnScreenLoading: false,
          event: Event.failed, failedWithoutAlertMessage: e.message!)));
    } on FailureException catch (e) {
      emit(state.copyWith(uiState: UIState(isOnScreenLoading: false,
          event: Event.failed, failedWithoutAlertMessage: e.message!)));
    } catch (e, st) {
      AppLog.e('getLeaveDetails : ${e.toString()} \n${st.toString()}');
      emit(state.copyWith(uiState: UIState(isOnScreenLoading: false,
          event: Event.failed, failedWithoutAlertMessage: 'we_regret_the_technical_error'.tr)));
    }
  }

  void withdrawLeave(int leaveID) async {
    try {
      emit(state.copyWith(buttonState: ButtonState(isLoading: true, message: 'please_wait'.tr)));
      await _leavesRemoteRepository.withdrawLeave(leaveID);
      emit(state.copyWith(buttonState: const ButtonState(isLoading: false, isSuccess: true)));
      await Future.delayed(const Duration(milliseconds: 500));
      emit(state.copyWith(uiState: UIState(event: Event.success)));
    } on ServerException catch (e) {
      emit(state.copyWith(buttonState: const ButtonState(isLoading: false, isEnable: true),
          uiState: UIState(event: Event.failed, failedWithoutAlertMessage: e.message!)));
    } on FailureException catch (e) {
      emit(state.copyWith(buttonState: const ButtonState(isLoading: false, isEnable: true),
          uiState: UIState(isOnScreenLoading: false, event: Event.failed, failedWithoutAlertMessage: e.message!)));
    } catch (e, st) {
      AppLog.e('withdrawLeave : ${e.toString()} \n${st.toString()}');
      emit(state.copyWith(buttonState: const ButtonState(isLoading: false, isEnable: true),
          uiState: UIState(isOnScreenLoading: false, event: Event.failed, failedWithoutAlertMessage: 'we_regret_the_technical_error'.tr)));
    }
  }

  void withdrawHolidayLeave(int holidayLeaveID) async {
    try {
      emit(state.copyWith(buttonState: ButtonState(isLoading: true, message: 'please_wait'.tr)));
      await _holidayRemoteRepository.withdrawHolidayLeave(holidayLeaveID);
      emit(state.copyWith(buttonState: const ButtonState(isLoading: false, isSuccess: true)));
      await Future.delayed(const Duration(milliseconds: 500));
      emit(state.copyWith(uiState: UIState(event: Event.success)));
    } on ServerException catch (e) {
      emit(state.copyWith(buttonState: const ButtonState(isLoading: false, isEnable: true),
          uiState: UIState(event: Event.failed, failedWithoutAlertMessage: e.message!)));
    } on FailureException catch (e) {
      emit(state.copyWith(buttonState: const ButtonState(isLoading: false, isEnable: true),
          uiState: UIState(isOnScreenLoading: false, event: Event.failed, failedWithoutAlertMessage: e.message!)));
    } catch (e, st) {
      AppLog.e('withdrawHolidayLeave : ${e.toString()} \n${st.toString()}');
      emit(state.copyWith(buttonState: const ButtonState(isLoading: false, isEnable: true),
          uiState: UIState(isOnScreenLoading: false, event: Event.failed, failedWithoutAlertMessage: 'we_regret_the_technical_error'.tr)));
    }
  }
}
