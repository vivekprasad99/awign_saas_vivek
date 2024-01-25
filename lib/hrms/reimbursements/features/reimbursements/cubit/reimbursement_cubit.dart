import 'package:awign_saas/core/data/model/ui_state.dart';
import 'package:awign_saas/core/exception/exception.dart';
import 'package:awign_saas/core/utils/app_log.dart';
import 'package:awign_saas/core/utils/date_time_helper/date_time_helper.dart';
import 'package:awign_saas/hrms/attendance/data/model/billing_cycle.dart';
import 'package:awign_saas/hrms/reimbursements/data/model/reimbursement_response.dart';
import 'package:awign_saas/hrms/reimbursements/data/network/repository/reimbursement_remote_repository.dart';
import 'package:awign_saas/hrms/reimbursements/features/reimbursements/cubit/reimbursement_state.dart';
import 'package:bloc/bloc.dart';
import 'package:get/get.dart';

class ReimbursementCubit extends Cubit<ReimbursementState> {
  final ReimbursementRemoteRepository _reimbursementRemoteRepository;

  ReimbursementCubit(this._reimbursementRemoteRepository)
      : super(const ReimbursementState());

  void updateSelectedBillingCycle(BillingCycle? selectedBillingCycle) {
    emit(state.copyWith(selectedBillingCycle: selectedBillingCycle));
    getAllReimbursement(state.currentTabIndex ?? 0);
  }

  void updateCurrentTabIndex(int currentTabIndex) {
    emit(state.copyWith(currentTabIndex: currentTabIndex));
    getAllReimbursement(state.currentTabIndex ?? 0);
  }

  void getAllReimbursement(int index) async {
    try {
      emit(state.copyWith(isSearchReimbursementLoading: true));
      ReimbursementStatus reimbursementStatus = switch (index) {
        0 => ReimbursementStatus.pending,
        1 => ReimbursementStatus.approved,
        2 => ReimbursementStatus.rejected,
        3 => ReimbursementStatus.all,
        _ => ReimbursementStatus.all,
      };
      ReimbursementResponse reimbursementResponse =
          await _reimbursementRemoteRepository.getAllReimbursement(
              reimbursementStatus.value == 'ALL'
                  ? ''
                  : reimbursementStatus.value,
              DateTimeHelper.getFormattedDateTime(DateTimeHelper.dateFormatYMD,
                  inputDateTime: state.selectedBillingCycle?.startDate),
              DateTimeHelper.getFormattedDateTime(DateTimeHelper.dateFormatYMD,
                  inputDateTime: state.selectedBillingCycle?.endDate));
      emit(state.copyWith(
          isSearchReimbursementLoading: false,
          reimbursementResponse: reimbursementResponse));
    } on ServerException catch (e) {
      emit(state.copyWith(
          isSearchReimbursementLoading: false,
          reimbursementResponse: null,
          uiState: UIState(failedWithoutAlertMessage: e.message!)));
    } on FailureException catch (e) {
      emit(state.copyWith(
          isSearchReimbursementLoading: false,
          reimbursementResponse: null,
          uiState: UIState(failedWithoutAlertMessage: e.message!)));
    } catch (e, st) {
      AppLog.e('getAllReimbursement : ${e.toString()} \n${st.toString()}');
      emit(state.copyWith(
          isSearchReimbursementLoading: false,
          reimbursementResponse: null,
          uiState: UIState(
              failedWithoutAlertMessage: 'we_regret_the_technical_error'.tr)));
    }
  }
}
