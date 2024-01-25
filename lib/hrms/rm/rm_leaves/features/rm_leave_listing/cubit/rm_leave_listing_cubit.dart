import 'package:bloc/bloc.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../../../../../core/data/local/database/user_preferences/user_preferences.dart';
import '../../../../../../core/data/model/advance_search/advance_search_request.dart';
import '../../../../../../core/data/model/advance_search/operator.dart';
import '../../../../../../core/data/model/ui_state.dart';
import '../../../../../../core/exception/exception.dart';
import '../../../../../../core/utils/app_log.dart';
import '../../../../../../core/utils/date_time_helper/date_time_helper.dart';
import '../../../../../attendance/data/model/billing_cycle.dart';
import '../../../../../leaves/data/model/leave.dart';
import '../../../../../leaves/data/model/leave_balance_response.dart';
import '../../../../../leaves/data/model/search_leave_response.dart';
import '../../../../../leaves/data/network/repository/leaves_remote_repository.dart';
import '../../../data/network/repository/rm_leaves_remote_repository.dart';
import 'rm_leave_listing_state.dart';

class RMLeaveListingCubit extends Cubit<RMLeaveListingState> {
  final RMLeavesRemoteRepository _rmLeavesRemoteRepository;
  RMLeaveListingCubit(this._rmLeavesRemoteRepository) : super(const RMLeaveListingState());

  void updateSelectedBillingCycle(BillingCycle? selectedBillingCycle) {
    emit(state.copyWith(selectedBillingCycle: selectedBillingCycle));
    searchLeaves(state.currentTabIndex ?? 0);
  }

  void searchLeaves(int? index) async {
    try {
      index ??= state.currentTabIndex ?? 0;
      emit(state.copyWith(isSearchLeavesLoading: true, currentTabIndex: index));
      LeaveStatus leaveStatus =
      switch (index) {
        0 => LeaveStatus.pending,
        1 => LeaveStatus.approved,
        2 => LeaveStatus.rejected,
        3 => LeaveStatus.all,
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
      SearchLeaveResponse searchLeaveResponse = await _rmLeavesRemoteRepository.searchLeaves(advancedSearchRequest.build());
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
}
