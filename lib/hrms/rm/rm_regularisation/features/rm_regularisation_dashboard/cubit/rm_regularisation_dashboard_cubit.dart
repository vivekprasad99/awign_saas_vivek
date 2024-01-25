import 'package:awign_saas/core/exception/exception.dart';
import 'package:awign_saas/core/extension/common_extension.dart';
import 'package:awign_saas/core/utils/app_log.dart';
import 'package:awign_saas/core/utils/date_time_helper/date_time_helper.dart';
import 'package:awign_saas/hrms/attendance/data/model/billing_cycle.dart';
import 'package:awign_saas/hrms/regularisation/data/model/regularisation_status_response.dart';
import 'package:awign_saas/hrms/rm/rm_regularisation/data/network/repository/rm_regularisation_remote_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:get/get.dart';

import '../../../../../../core/data/model/ui_state.dart';
import '../../../../../attendance/data/model/date_range_request.dart';
import '../../../data/model/regularize_search_response.dart';
import 'rm_regularisation_dashboard_state.dart';

class RMRegularisationDashboardCubit
    extends Cubit<RMRegularisationDashboardState> {
  final RMRegularisationRemoteRepository _rMRegularisationRemoteRepository;

  RMRegularisationDashboardCubit(this._rMRegularisationRemoteRepository)
      : super(const RMRegularisationDashboardState(currentTabIndex: 0));

  void updateCurrentTabIndex(int currentTabIndex) {
    emit(state.copyWith(currentTabIndex: currentTabIndex));
  }

  void updateSelectedBillingCycle(BillingCycle? selectedBillingCycle) {
    emit(state.copyWith(selectedBillingCycle: selectedBillingCycle));
    getRegularisationStatusByDateRange();
  }

  void getRegularisationStatusByDateRange() async {
    try {
      if (state.selectedBillingCycle == null) {
        return;
      }
      emit(state.copyWith(isLoading: true));
      String strStartDate = DateTimeHelper.getFormattedDateTime(
          DateTimeHelper.dateFormatYMD,
          inputDateTime: state.selectedBillingCycle!.startDate);
      String strEndDate = DateTimeHelper.getFormattedDateTime(
          DateTimeHelper.dateFormatYMD,
          inputDateTime: state.selectedBillingCycle!.endDate);
      DateTime now = DateTime.now();
      if (state.selectedBillingCycle!.endDate!.isAfter(now)) {
        strEndDate = DateTimeHelper.getFormattedDateTime(
            DateTimeHelper.dateFormatYMD,
            inputDateTime: DateTime(now.year, now.month, now.day - 1));
      }
      DateRangeRequest dateRangeRequest =
          DateRangeRequest(startDate: strStartDate, endDate: strEndDate);
      List<RmRegularizeSearchResponse>? regularizeSearchResponseList =
          await _rMRegularisationRemoteRepository
              .searchRegularise(dateRangeRequest);
      emit(state.copyWith(
          isLoading: false,
          pendingList: getPendingRegulariseList(regularizeSearchResponseList),
          approvedList: getApprovedRegulariseList(regularizeSearchResponseList),
          rejectedList: getRejectedRegulariseList(regularizeSearchResponseList),
          allList: getAllRegulariseList(regularizeSearchResponseList)));
    } on ServerException catch (e) {
      emit(state.copyWith(
          isLoading: false,
          pendingList: null,
          approvedList: null,
          rejectedList: null,
          allList: null,
          uiState: UIState(
              event: Event.failed, failedWithoutAlertMessage: e.message!)));
    } on FailureException catch (e) {
      emit(state.copyWith(
          isLoading: false,
          pendingList: null,
          approvedList: null,
          rejectedList: null,
          allList: null,
          uiState: UIState(
              event: Event.failed, failedWithoutAlertMessage: e.message!)));
    } catch (e, st) {
      AppLog.e(
          'getRegularisationStatusByDateRange : ${e.toString()} \n${st.toString()}');
      emit(state.copyWith(
          isLoading: false,
          pendingList: null,
          approvedList: null,
          rejectedList: null,
          allList: null,
          uiState: UIState(
              event: Event.failed,
              failedWithoutAlertMessage: 'we_regret_the_technical_error'.tr)));
    }
  }

  List<Regularization>? getPendingRegulariseList(
      List<RmRegularizeSearchResponse>? regularizeSearchResponseList) {
    List<Regularization>? pendingList = [];
    for (RmRegularizeSearchResponse rmRegularizeSearchResponse
        in regularizeSearchResponseList!) {
      if (rmRegularizeSearchResponse.regularization != null) {
        for (Regularization regularization
            in rmRegularizeSearchResponse.regularization!) {
          if (regularization.status == RegularisationStatus.pending) {
            pendingList.add(regularization);
          }
        }
      }
    }
    return pendingList;
  }

  List<Regularization>? getApprovedRegulariseList(
      List<RmRegularizeSearchResponse>? regularizeSearchResponseList) {
    List<Regularization>? approvedList = [];
    for (RmRegularizeSearchResponse rmRegularizeSearchResponse
        in regularizeSearchResponseList!) {
      if (rmRegularizeSearchResponse.regularization != null) {
        for (Regularization regularization
            in rmRegularizeSearchResponse.regularization!) {
          if (regularization.status == RegularisationStatus.approved) {
            approvedList.add(regularization);
          }
        }
      }
    }
    return approvedList;
  }

  List<Regularization>? getRejectedRegulariseList(
      List<RmRegularizeSearchResponse>? regularizeSearchResponseList) {
    List<Regularization>? rejectedList = [];
    for (RmRegularizeSearchResponse rmRegularizeSearchResponse
        in regularizeSearchResponseList!) {
      if (rmRegularizeSearchResponse.regularization != null) {
        for (Regularization regularization
            in rmRegularizeSearchResponse.regularization!) {
          if (regularization.status == RegularisationStatus.rejected) {
            rejectedList.add(regularization);
          }
        }
      }
    }
    return rejectedList;
  }

  List<Regularization>? getAllRegulariseList(
      List<RmRegularizeSearchResponse>? regularizeSearchResponseList) {
    List<Regularization>? allList = [];
    for (RmRegularizeSearchResponse rmRegularizeSearchResponse
        in regularizeSearchResponseList!) {
      if (rmRegularizeSearchResponse.regularization != null) {
        for (Regularization regularization
            in rmRegularizeSearchResponse.regularization!) {
          allList.add(regularization);
        }
      }
    }
    return allList;
  }
}
