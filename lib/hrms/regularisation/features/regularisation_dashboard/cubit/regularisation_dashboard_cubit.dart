import 'package:awign_saas/hrms/regularisation/data/network/repository/regularisation_remote_repository.dart';
import 'package:awign_saas/hrms/regularisation/features/regularisation_dashboard/cubit/regularisation_dashboard_state.dart';
import 'package:bloc/bloc.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../../../../core/data/model/ui_state.dart';
import '../../../../../core/exception/exception.dart';
import '../../../../../core/utils/app_log.dart';
import '../../../../../core/utils/date_time_helper/date_time_helper.dart';
import '../../../../attendance/data/model/billing_cycle.dart';
import '../../../../attendance/data/model/date_range_request.dart';
import '../../../data/model/regularisation_status_response.dart';


class RegularisationDashboardCubit extends Cubit<RegularisationDashboardState> {
  final RegularisationRemoteRepository _regularisationRemoteRepository;
  RegularisationDashboardCubit(this._regularisationRemoteRepository) : super(const RegularisationDashboardState());

  void updateSelectedBillingCycle(BillingCycle? selectedBillingCycle) {
    emit(state.copyWith(selectedBillingCycle: selectedBillingCycle));
    getRegularisationList(state.currentTabIndex ?? 0);
  }

  void getRegularisationList(int? index) async {
    try {
      if(state.selectedBillingCycle == null) {
        return;
      }
      index ??= state.currentTabIndex ?? 0;
      emit(state.copyWith(isLoading: true, currentTabIndex: index ?? state.currentTabIndex ?? 0));
      RegularisationStatus regularisationStatus =
      switch (index) {
        0 => RegularisationStatus.pending,
        1 => RegularisationStatus.approved,
        2 => RegularisationStatus.rejected,
        3 => RegularisationStatus.all,
        _ => RegularisationStatus.all,
      };
      DateRangeRequest dateRangeRequest = DateRangeRequest(
          startDate: DateTimeHelper.getFormattedDateTime(DateTimeHelper.dateFormatYMD, inputDateTime: state.selectedBillingCycle!.startDate),
          endDate: DateTimeHelper.getFormattedDateTime(DateTimeHelper.dateFormatYMD, inputDateTime: state.selectedBillingCycle!.endDate),
          status: regularisationStatus.value);
      List<Regularisation>? regularisationList = await _regularisationRemoteRepository.getRegularisationStatus(dateRangeRequest);
      emit(state.copyWith(isLoading: false, regularisationList: regularisationList));
    } on ServerException catch (e) {
      if(!isClosed) {
        emit(state.copyWith(isLoading: false, regularisationList: null, uiState: UIState(event: Event.failed, failedWithoutAlertMessage: e.message!)));
      }
    } on FailureException catch (e) {
      if(!isClosed) {
        emit(state.copyWith(isLoading: false, regularisationList: null, uiState: UIState(event: Event.failed, failedWithoutAlertMessage: e.message!)));
      }
    } catch (e, st) {
      if(!isClosed) {
        AppLog.e('getRegularisationList : ${e.toString()} \n${st.toString()}');
        emit(state.copyWith(isLoading: false, regularisationList: null, uiState: UIState(event: Event.failed, failedWithoutAlertMessage: 'we_regret_the_technical_error'.tr)));
      }
    }
  }
}
