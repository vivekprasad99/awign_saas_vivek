import 'package:awign_saas/core/data/model/button_state.dart';
import 'package:awign_saas/core/data/model/ui_state.dart';
import 'package:awign_saas/core/exception/exception.dart';
import 'package:awign_saas/core/utils/app_log.dart';
import 'package:awign_saas/core/widget/dialog/rm_regularise_approved_dialog/cubit/rm_regularise_approved_dialog_state.dart';
import 'package:awign_saas/hrms/rm/rm_regularisation/data/network/repository/rm_regularisation_remote_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:get/get.dart';

class RmRegulariseApprovedDialogCubit extends Cubit<RmRegulariseApprovedDialogState> {
  final RMRegularisationRemoteRepository _rMRegularisationRemoteRepository;
  RmRegulariseApprovedDialogCubit(this._rMRegularisationRemoteRepository) : super(const RmRegulariseApprovedDialogState());

  void updateRemark(String? remark) {
    emit(state.copyWith(
        remarkError: null,
        remark: remark,
        buttonState: const ButtonState(isEnable: true)));
  }

  void updateButtonState(bool? value) {
    emit(state.copyWith(
        buttonState:  ButtonState(isEnable: value!)));
  }

  void onApproveTap(String? regulariseId,bool? isApproved) async {
    try {
      emit(state.copyWith(
          buttonState:
          ButtonState(isLoading: true, message: 'please_wait'.tr)));
      Map<String,dynamic> body = {
        "remarks" : state.remark,
      };
      _rMRegularisationRemoteRepository.approvedRegularisation(body,regulariseId,isApproved);
      emit(state.copyWith(
          buttonState: const ButtonState(isEnable: true, isSuccess: true)));
      await Future.delayed(const Duration(milliseconds: 500));
      emit(state.copyWith(
          uiState: UIState(event: Event.success, successWithAlertMessage: '')));
    } on ServerException catch (e) {
      emit(state.copyWith(
          buttonState: const ButtonState(isEnable: true),
          uiState: UIState(
              event: Event.failed, failedWithoutAlertMessage: e.message!)));
    } on FailureException catch (e) {
      emit(state.copyWith(
          buttonState: const ButtonState(isEnable: true),
          uiState: UIState(
              event: Event.failed, failedWithoutAlertMessage: e.message!)));
    } catch (e, st) {
      AppLog.e('onApproveTap : ${e.toString()} \n${st.toString()}');
      emit(state.copyWith(
          buttonState: const ButtonState(isEnable: true),
          uiState: UIState(
              event: Event.failed,
              failedWithoutAlertMessage: 'we_regret_the_technical_error'.tr)));
    }
  }
}
