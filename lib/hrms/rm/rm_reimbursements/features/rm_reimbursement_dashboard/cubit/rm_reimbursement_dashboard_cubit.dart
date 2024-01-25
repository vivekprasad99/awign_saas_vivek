import 'package:awign_saas/core/data/model/advance_search/advance_search_request.dart';
import 'package:awign_saas/core/data/model/advance_search/operator.dart';
import 'package:awign_saas/core/data/model/ui_state.dart';
import 'package:awign_saas/core/exception/exception.dart';
import 'package:awign_saas/core/utils/app_log.dart';
import 'package:awign_saas/core/utils/date_time_helper/date_time_helper.dart';
import 'package:awign_saas/hrms/attendance/data/model/billing_cycle.dart';
import 'package:awign_saas/hrms/reimbursements/data/model/reimbursement_response.dart';
import 'package:awign_saas/hrms/rm/rm_reimbursements/data/model/employee_search_response.dart';
import 'package:awign_saas/hrms/rm/rm_reimbursements/data/model/rm_reimbursement_search_response.dart';
import 'package:awign_saas/hrms/rm/rm_reimbursements/data/network/repository/rm_reimbursement_remote_repository.dart';
import 'package:awign_saas/hrms/rm/rm_reimbursements/features/rm_reimbursement_dashboard/cubit/rm_reimbursement_dashboard_state.dart';
import 'package:bloc/bloc.dart';
import 'package:get/get.dart';

class RmReimbursementDashboardCubit
    extends Cubit<RmReimbursementDashboardState> {
  final RMReimbursementRemoteRepository _rmReimbursementRemoteRepository;

  RmReimbursementDashboardCubit(this._rmReimbursementRemoteRepository)
      : super(const RmReimbursementDashboardState(currentTabIndex: 0));

  void updateSelectedBillingCycle(BillingCycle? selectedBillingCycle) {
    emit(state.copyWith(selectedBillingCycle: selectedBillingCycle));
    searchReimbursement();
  }

  void updateCurrentTabIndex(int currentTabIndex) {
    emit(state.copyWith(currentTabIndex: currentTabIndex));
  }

  void searchReimbursement() async {
    try {
      if (state.selectedBillingCycle == null) {
        return;
      }
      emit(state.copyWith(isLoading: true));
      var advancedSearchRequest = AdvanceSearchRequestBuilder();
      if (state.selectedBillingCycle != null) {
        String strStartDate = DateTimeHelper.getFormattedDateTime(
            DateTimeHelper.dateFormatYMD,
            inputDateTime: state.selectedBillingCycle!.startDate);
        String strEndDate = DateTimeHelper.getFormattedDateTime(
            DateTimeHelper.dateFormatYMD,
            inputDateTime: state.selectedBillingCycle!.endDate);
        advancedSearchRequest
            .putPropertyToCondition(AdvancedSearchRequest.createdAt,
                Operator.between, [strStartDate, strEndDate])
            .setLimit(100)
            .setPage(1)
            .setAnalyze(true);
      }
      RmReimbursementSearchResponse rmReimbursementSearchResponse =
          await _rmReimbursementRemoteRepository.searchReimbursement(
        advancedSearchRequest.build(),
      );
      emit(state.copyWith(
          isLoading: false,
          pendingList: getPendingReimbursementList(rmReimbursementSearchResponse
              .rmReimbursementSearch!.reimbursements),
          approvedList: getApprovedReimbursementList(
              rmReimbursementSearchResponse
                  .rmReimbursementSearch!.reimbursements),
          rejectedList: getRejectedReimbursementList(
              rmReimbursementSearchResponse
                  .rmReimbursementSearch!.reimbursements),
          allList: rmReimbursementSearchResponse
              .rmReimbursementSearch!.reimbursements));
    } on ServerException catch (e) {
      emit(state.copyWith(
          isLoading: false,
          pendingList: null,
          approvedList: null,
          rejectedList: null,
          allList: null,
          uiState: UIState(failedWithoutAlertMessage: e.message!)));
    } on FailureException catch (e) {
      emit(state.copyWith(
          isLoading: false,
          allList: null,
          pendingList: null,
          approvedList: null,
          rejectedList: null,
          uiState: UIState(failedWithoutAlertMessage: e.message!)));
    } catch (e, st) {
      AppLog.e('getReimbursementStatus : ${e.toString()} \n${st.toString()}');
      emit(state.copyWith(
          isLoading: false,
          pendingList: null,
          approvedList: null,
          rejectedList: null,
          allList: null,
          uiState: UIState(
              failedWithoutAlertMessage: 'we_regret_the_technical_error'.tr)));
    }
  }

  List<Reimbursements>? getPendingReimbursementList(
      List<Reimbursements>? allList) {
    return allList?.where((element) {
      return element.status == 'PENDING';
    }).toList();
  }

  List<Reimbursements>? getApprovedReimbursementList(
      List<Reimbursements>? allList) {
    return allList?.where((element) {
      return element.status == 'APPROVED';
    }).toList();
  }

  List<Reimbursements>? getRejectedReimbursementList(
      List<Reimbursements>? allList) {
    return allList?.where((element) => element.status == 'REJECTED').toList();
  }
}
