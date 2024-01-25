import 'package:awign_saas/core/exception/exception.dart';
import 'package:awign_saas/core/utils/app_log.dart';
import 'package:awign_saas/core/utils/date_time_helper/date_time_helper.dart';
import 'package:awign_saas/hrms/attendance/data/model/billing_cycle.dart';
import 'package:awign_saas/hrms/rm/rm_comp_off/data/model/rm_comp_off_search_response.dart';
import 'package:awign_saas/hrms/rm/rm_comp_off/data/network/repository/rm_comp_off_remote_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:get/get.dart';

import '../../../../../../core/data/model/advance_search/advance_search_request.dart';
import '../../../../../../core/data/model/advance_search/operator.dart';
import '../../../../../../core/data/model/ui_state.dart';
import 'rm_comp_off_listing_state.dart';

class RMCompOffListingCubit extends Cubit<RMCompOffListingState> {
  final RMCompOffRemoteRepository _rmCompOffRemoteRepository;

  RMCompOffListingCubit(this._rmCompOffRemoteRepository)
      : super(const RMCompOffListingState(currentTabIndex: 0));

  void updateCurrentTabIndex(int currentTabIndex) {
    emit(state.copyWith(currentTabIndex: currentTabIndex));
  }

  void updateSelectedBillingCycle(BillingCycle? selectedBillingCycle) {
    emit(state.copyWith(selectedBillingCycle: selectedBillingCycle));
    getCompOffListByDateRange();
  }

  void getCompOffListByDateRange() async {
    try {
      if (state.selectedBillingCycle == null) {
        return;
      }
      emit(state.copyWith(isLoading: true));
      AdvanceSearchRequestBuilder advancedSearchRequest = AdvanceSearchRequestBuilder();
      if(state.selectedBillingCycle != null) {
        String strStartDate = DateTimeHelper.getFormattedDateTime(DateTimeHelper.dateFormatYMD, inputDateTime: state.selectedBillingCycle!.startDate);
        String strEndDate = DateTimeHelper.getFormattedDateTime(DateTimeHelper.dateFormatYMD, inputDateTime: state.selectedBillingCycle!.endDate);
        advancedSearchRequest
            .putPropertyToCondition(AdvancedSearchRequest.createdAt, Operator.between, [strStartDate, strEndDate]);
      }
      RMCompOffSearchResponse rmCompOffSearchResponse = await _rmCompOffRemoteRepository.searchCompOff(advancedSearchRequest.build());
      emit(state.copyWith(isLoading: false, pendingList: rmCompOffSearchResponse.data?[0].getPendingCompOffList(),
          approvedList: rmCompOffSearchResponse.data?[0].getApprovedCompOffList(),
          rejectedList: rmCompOffSearchResponse.data?[0].getRejectedCompOffList(),
          allList: rmCompOffSearchResponse.data?[0].compOffs));
    } on ServerException catch (e) {
      emit(state.copyWith(isLoading: false, pendingList: null, approvedList: null, rejectedList: null, allList: null,
          uiState: UIState(event: Event.failed, failedWithoutAlertMessage: e.message!)));
    } on FailureException catch (e) {
      emit(state.copyWith(isLoading: false, pendingList: null, approvedList: null, rejectedList: null, allList: null,
          uiState: UIState(event: Event.failed, failedWithoutAlertMessage: e.message!)));
    } catch (e, st) {
      AppLog.e('getCompOffListByDateRange : ${e.toString()} \n${st.toString()}');
      emit(state.copyWith(isLoading: false, pendingList: null, approvedList: null, rejectedList: null, allList: null,
          uiState: UIState(event: Event.failed, failedWithoutAlertMessage: 'we_regret_the_technical_error'.tr)));
    }
  }
}
