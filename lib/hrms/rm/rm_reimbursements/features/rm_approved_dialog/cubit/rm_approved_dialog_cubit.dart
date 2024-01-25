import 'package:awign_saas/core/data/model/button_state.dart';
import 'package:awign_saas/core/data/model/ui_state.dart';
import 'package:awign_saas/core/exception/exception.dart';
import 'package:awign_saas/core/utils/app_log.dart';
import 'package:awign_saas/core/utils/validator.dart';
import 'package:awign_saas/hrms/rm/rm_reimbursements/data/network/repository/rm_reimbursement_remote_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:get/get.dart';

import 'rm_approved_dialog_state.dart';

class RmApprovedDialogCubit extends Cubit<RmApprovedDialogState> {
  final RMReimbursementRemoteRepository _rmReimbursementRemoteRepository;
  RmApprovedDialogCubit(this._rmReimbursementRemoteRepository) : super(const RmApprovedDialogState());

  void updateAmount(String? amount) {
    if (Validator.checkNumber(amount) == null) {
      emit(state.copyWith(
          amountError: null,
          amount: amount,
          buttonState:  const ButtonState(isEnable: true)));
    } else {
      emit(state.copyWith(
          amountError: Validator.checkNumber(amount),
          buttonState:  const ButtonState(isEnable: false)));
    }
  }

  void updateRemark(String? remark) {
    emit(state.copyWith(
        remarkError: null,
        remark: remark,
        buttonState: const ButtonState(isEnable: true)));
  }

  void onApproveTap(String? expenseId,bool? isApproved) async {
    try {
    emit(state.copyWith(
        buttonState: ButtonState(isLoading: true, message: 'please_wait'.tr)));
    Map<String,dynamic> body = {
      "remarks" : state.remark,
     if(isApproved!) "approved_amount" : state.amount
    };
    await _rmReimbursementRemoteRepository.approvedReimbursement(body,expenseId,isApproved);
    emit(state.copyWith(buttonState: const ButtonState(isEnable: true, isSuccess: true)));
    await Future.delayed(const Duration(milliseconds: 500));
    emit(state.copyWith(uiState: UIState(event: Event.success)));
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
