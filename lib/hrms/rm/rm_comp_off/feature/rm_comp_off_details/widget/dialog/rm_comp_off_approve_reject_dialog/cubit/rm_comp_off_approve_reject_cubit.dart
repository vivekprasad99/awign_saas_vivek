import 'package:awign_saas/hrms/rm/rm_comp_off/data/model/comp_off_approve_reject_request.dart';
import 'package:awign_saas/hrms/rm/rm_comp_off/data/network/repository/rm_comp_off_remote_repository.dart';
import 'package:awign_saas/hrms/rm/rm_comp_off/feature/rm_comp_off_details/widget/dialog/rm_comp_off_approve_reject_dialog/cubit/rm_comp_off_approve_reject_state.dart';
import 'package:bloc/bloc.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../../../../../../../../core/data/model/button_state.dart';
import '../../../../../../../../../core/data/model/ui_state.dart';
import '../../../../../../../../../core/exception/exception.dart';
import '../../../../../../../../../core/utils/app_log.dart';
import '../../../../../../../../comp_off/data/model/comp_off.dart';

class RMCompOffApproveRejectCubit extends Cubit<RMCompOffApproveRejectState> {
  final RMCompOffRemoteRepository _rmCompOffRemoteRepository;
  RMCompOffApproveRejectCubit(this._rmCompOffRemoteRepository) : super(const RMCompOffApproveRejectState());

  updateLeave(CompOff compOff) {
    emit(state.copyWith(compOff: compOff));
  }

  void updateRemarks(String? remarks) {
    emit(state.copyWith(remarks: remarks));
  }

  void approveOrDeclineCompOff(CompOffStatus compOffStatus) async {
    try {
      emit(state.copyWith(buttonState: ButtonState(isLoading: true, message: 'please_wait'.tr)));
      CompOffApproveRejectRequest updateLeaveRequest = CompOffApproveRejectRequest(status: compOffStatus,
          managerRemark: state.remarks);
      await _rmCompOffRemoteRepository.approveOrRejectCompOff(state.compOff?.id ?? -1, updateLeaveRequest);
      String message = '';
      if(compOffStatus == CompOffStatus.accepted) {
        message = 'comp_off_accepted'.tr;
      } else {
        message = 'comp_off_rejected'.tr;
      }
      emit(state.copyWith(buttonState: ButtonState(isEnable: true, isSuccess: true, message: message)));
      await Future.delayed(const Duration(milliseconds: 500));
      emit(state.copyWith(uiState: UIState(event: Event.success)));
    } on ServerException catch (e) {
      emit(state.copyWith(buttonState: const ButtonState(isEnable: true),
          uiState: UIState(event: Event.failed, failedWithoutAlertMessage: e.message!)));
    } on FailureException catch (e) {
      emit(state.copyWith(buttonState: const ButtonState(isEnable: true),
          uiState: UIState(event: Event.failed, failedWithoutAlertMessage: e.message!)));
    } catch (e, st) {
      AppLog.e('approveOrDeclineCompOff : ${e.toString()} \n${st.toString()}');
      emit(state.copyWith(buttonState: const ButtonState(isEnable: true),
          uiState: UIState(event: Event.failed, failedWithoutAlertMessage: 'we_regret_the_technical_error'.tr)));
    }
  }
}
