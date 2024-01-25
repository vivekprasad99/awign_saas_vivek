import 'package:awign_saas/hrms/comp_off/data/model/employee_comp_off_response.dart';
import 'package:awign_saas/hrms/comp_off/data/network/repository/comp_off_remote_repository.dart';
import 'package:awign_saas/hrms/leaves/data/network/repository/leaves_remote_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import '../../../../../core/data/model/advance_search/advance_search_request.dart';
import '../../../../../core/data/model/advance_search/operator.dart';
import '../../../../../core/data/model/ui_state.dart';
import '../../../../../core/exception/exception.dart';
import '../../../../../core/utils/app_log.dart';
import '../../../../../core/utils/date_time_helper/date_time_helper.dart';
import '../../../../attendance/data/model/billing_cycle.dart';
import '../../../../leaves/data/model/leave_balance_response.dart';
import 'comp_off_listing_state.dart';

class CompOffListingCubit extends Cubit<CompOffListingState> {
  final CompOffRemoteRepository _compOffRemoteRepository;
  final LeavesRemoteRepository _leavesRemoteRepository;
  CompOffListingCubit(this._compOffRemoteRepository, this._leavesRemoteRepository) : super(const CompOffListingState(currentTabIndex: 0));

  void updateSelectedBillingCycle(BillingCycle? selectedBillingCycle) {
    emit(state.copyWith(selectedBillingCycle: selectedBillingCycle));
    getEmployeeCompOffList();
  }

  void updateCurrentTabIndex(int currentTabIndex) {
    emit(state.copyWith(currentTabIndex: currentTabIndex));
  }

  void getEmployeeCompOffList() async {
    try {
      emit(state.copyWith(isLoading: true));
      AdvanceSearchRequestBuilder advancedSearchRequest = AdvanceSearchRequestBuilder();
      if(state.selectedBillingCycle != null) {
        String strStartDate = DateTimeHelper.getFormattedDateTime(DateTimeHelper.dateFormatYMD, inputDateTime: state.selectedBillingCycle!.startDate);
        String strEndDate = DateTimeHelper.getFormattedDateTime(DateTimeHelper.dateFormatYMD, inputDateTime: state.selectedBillingCycle!.endDate);
        advancedSearchRequest
            .putPropertyToCondition(AdvancedSearchRequest.createdAt, Operator.between, [strStartDate, strEndDate]);
      }
      EmployeeCompOffResponse employeeCompOffResponse = await _compOffRemoteRepository.getEmployeeCompOffList(advancedSearchRequest.build());
      emit(state.copyWith(isLoading: false, pendingList: employeeCompOffResponse.data?[0].getPendingCompOffList(), approvedList:
      employeeCompOffResponse.data?[0].getApproveCompOffList(), rejectedList: employeeCompOffResponse.data?[0].getRejectedCompOffList(),
          cancelledList: employeeCompOffResponse.data?[0].getWithdrawnCompOffList()));
    } on ServerException catch (e) {
      emit(state.copyWith(isLoading: false, pendingList: null, approvedList: null, rejectedList: null, cancelledList: null,
          uiState: UIState(failedWithoutAlertMessage: e.message!)));
    } on FailureException catch (e) {
      emit(state.copyWith(isLoading: false, pendingList: null, approvedList: null, rejectedList: null, cancelledList: null,
          uiState: UIState(failedWithoutAlertMessage: e.message!)));
    } catch (e, st) {
      AppLog.e('getEmployeeCompOffList : ${e.toString()} \n${st.toString()}');
      emit(state.copyWith(isLoading: false, pendingList: null, approvedList: null, rejectedList: null, cancelledList: null,
          uiState: UIState(failedWithoutAlertMessage: 'we_regret_the_technical_error'.tr)));
    }
  }

  void getLeaveBalance() async {
    try {
      emit(state.copyWith(isCompOffBalanceLoading: true));
      LeaveBalanceResponse leaveBalanceResponse = await _leavesRemoteRepository.getLeaveBalance();
      emit(state.copyWith(isCompOffBalanceLoading: false, compOffBalance: leaveBalanceResponse.getCompOffBalance()));
    } on ServerException catch (e) {
      emit(state.copyWith(isCompOffBalanceLoading: false, compOffBalance: null, uiState: UIState(failedWithoutAlertMessage: e.message!)));
    } on FailureException catch (e) {
      emit(state.copyWith(isCompOffBalanceLoading: false, compOffBalance: null, uiState: UIState(failedWithoutAlertMessage: e.message!)));
    } catch (e, st) {
      AppLog.e('getLeaveBalance : ${e.toString()} \n${st.toString()}');
      emit(state.copyWith(isCompOffBalanceLoading: false, compOffBalance: null, uiState: UIState(failedWithoutAlertMessage: 'we_regret_the_technical_error'.tr)));
    }
  }
}
