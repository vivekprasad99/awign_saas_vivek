import 'package:awign_saas/core/data/model/ui_state.dart';
import 'package:awign_saas/core/exception/exception.dart';
import 'package:awign_saas/core/utils/app_log.dart';
import 'package:awign_saas/hrms/reimbursements/data/model/reimbursement_detail_response.dart';
import 'package:awign_saas/hrms/reimbursements/data/network/repository/reimbursement_remote_repository.dart';
import 'package:awign_saas/hrms/reimbursements/features/reimbursements_detail/cubit/reimbursement_detail_state.dart';
import 'package:bloc/bloc.dart';
import 'package:get/get.dart';


class ReimbursementDetailCubit extends Cubit<ReimbursementDetailState> {
  final ReimbursementRemoteRepository _reimbursementRemoteRepository;
  ReimbursementDetailCubit(this._reimbursementRemoteRepository) : super(const ReimbursementDetailState());

  void getReimbursement(String uuid) async {
    try {
      emit(state.copyWith(isLoading: true));
      ReimbursementDetailResponse reimbursementDetailResponse = await _reimbursementRemoteRepository.getReimbursement(uuid);
      emit(state.copyWith(reimbursementDetailResponse: reimbursementDetailResponse,isLoading: false));
    } on ServerException catch (e) {
      emit(state.copyWith(uiState: UIState(failedWithoutAlertMessage: e.message!),isLoading: false));
    } on FailureException catch (e) {
      emit(state.copyWith(uiState: UIState(failedWithoutAlertMessage: e.message!),isLoading: false));
    } catch (e, st) {
      AppLog.e('getReimbursement : ${e.toString()} \n${st.toString()}');
      emit(state.copyWith(uiState: UIState(failedWithoutAlertMessage: 'we_regret_the_technical_error'.tr),isLoading: false));
    }
  }

  void deleteReimbursement(String uuid) async {
    try {
      var data = await _reimbursementRemoteRepository.deleteReimbursement(uuid);
      emit(state.copyWith(uiState: UIState(event: Event.success, successWithAlertMessage: '')));
    } on ServerException catch (e) {
      emit(state.copyWith(uiState: UIState(failedWithoutAlertMessage: e.message!)));
    } on FailureException catch (e) {
      emit(state.copyWith(uiState: UIState(failedWithoutAlertMessage: e.message!)));
    } catch (e, st) {
      AppLog.e('deleteReimbursement : ${e.toString()} \n${st.toString()}');
      emit(state.copyWith(uiState: UIState(failedWithoutAlertMessage: 'we_regret_the_technical_error'.tr)));
    }
  }
}
