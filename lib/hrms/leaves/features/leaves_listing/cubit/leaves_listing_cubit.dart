import 'package:awign_saas/core/data/local/database/user_preferences/user_preferences.dart';
import 'package:awign_saas/hrms/leaves/data/model/leave_balance_response.dart';
import 'package:awign_saas/hrms/leaves/data/model/search_leave_response.dart';
import 'package:bloc/bloc.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../../../../core/data/model/advance_search/advance_search_request.dart';
import '../../../../../core/data/model/advance_search/operator.dart';
import '../../../../../core/data/model/ui_state.dart';
import '../../../../../core/exception/exception.dart';
import '../../../../../core/utils/app_log.dart';
import '../../../../../core/utils/date_time_helper/date_time_helper.dart';
import '../../../../attendance/data/model/billing_cycle.dart';
import '../../../data/model/leave.dart';
import '../../../data/network/repository/leaves_remote_repository.dart';
import 'leaves_listing_state.dart';

class LeavesListingCubit extends Cubit<LeavesListingState> {
  final LeavesRemoteRepository _leavesRemoteRepository;
  LeavesListingCubit(this._leavesRemoteRepository) : super(const LeavesListingState());

  void updateSelectedBillingCycle(BillingCycle? selectedBillingCycle) {
    emit(state.copyWith(selectedBillingCycle: selectedBillingCycle));
    searchLeaves(state.currentTabIndex ?? 0);
  }

  void searchLeaves(int? index) async {
    try {
      index ??= state.currentTabIndex ?? 0;
      emit(state.copyWith(isSearchLeavesLoading: true, currentTabIndex: index ?? state.currentTabIndex ?? 0));
      LeaveStatus leaveStatus =
          switch (index) {
            0 => LeaveStatus.pending,
            1 => LeaveStatus.approved,
            2 => LeaveStatus.rejected,
            3 => LeaveStatus.withdrawn,
            4 => LeaveStatus.all,
            _ => LeaveStatus.all,
          };
      var advancedSearchRequest = AdvanceSearchRequestBuilder();
      if(leaveStatus != LeaveStatus.all) {
        advancedSearchRequest
            .putPropertyToCondition(AdvancedSearchRequest.status, Operator.equal, leaveStatus.value);
      }
      if(state.selectedBillingCycle != null) {
        String strStartDate = DateTimeHelper.getFormattedDateTime(DateTimeHelper.dateFormatYMD, inputDateTime: state.selectedBillingCycle!.startDate);
        String strEndDate = DateTimeHelper.getFormattedDateTime(DateTimeHelper.dateFormatYMD, inputDateTime: state.selectedBillingCycle!.endDate);
        advancedSearchRequest
            .putPropertyToCondition(AdvancedSearchRequest.startDate, Operator.between, [strStartDate, strEndDate]);
      }
      SearchLeaveResponse searchLeaveResponse = await _leavesRemoteRepository.searchLeave(advancedSearchRequest.build(),
          UserPreferences.getInstance().getCurrentUser()?.tenant?.organization ?? '');
      emit(state.copyWith(isSearchLeavesLoading: false, leaves: searchLeaveResponse.leaveTransactions));
    } on ServerException catch (e) {
      emit(state.copyWith(isSearchLeavesLoading: false, leaves: null, uiState: UIState(failedWithoutAlertMessage: e.message!)));
    } on FailureException catch (e) {
      emit(state.copyWith(isSearchLeavesLoading: false, leaves: null, uiState: UIState(failedWithoutAlertMessage: e.message!)));
    } catch (e, st) {
      AppLog.e('searchLeaves : ${e.toString()} \n${st.toString()}');
      emit(state.copyWith(isSearchLeavesLoading: false, leaves: null, uiState: UIState(failedWithoutAlertMessage: 'we_regret_the_technical_error'.tr)));
    }
  }

  void getLeaveBalance() async {
    try {
      emit(state.copyWith(isLeaveBalanceLoading: true));
      LeaveBalanceResponse leaveBalanceResponse = await _leavesRemoteRepository.getLeaveBalance();
      emit(state.copyWith(isLeaveBalanceLoading: false, leaveBalanceResponse: leaveBalanceResponse));
    } on ServerException catch (e) {
      emit(state.copyWith(isLeaveBalanceLoading: false, leaveBalanceResponse: null, uiState: UIState(failedWithoutAlertMessage: e.message!)));
    } on FailureException catch (e) {
      emit(state.copyWith(isLeaveBalanceLoading: false, leaveBalanceResponse: null, uiState: UIState(failedWithoutAlertMessage: e.message!)));
    } catch (e, st) {
      AppLog.e('getLeaveBalance : ${e.toString()} \n${st.toString()}');
      emit(state.copyWith(isLeaveBalanceLoading: false, leaveBalanceResponse: null, uiState: UIState(failedWithoutAlertMessage: 'we_regret_the_technical_error'.tr)));
    }
  }
}
