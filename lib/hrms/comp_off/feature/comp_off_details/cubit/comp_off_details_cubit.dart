import 'package:awign_saas/core/data/model/button_state.dart';
import 'package:awign_saas/hrms/comp_off/data/model/comp_off_details_response.dart';
import 'package:awign_saas/hrms/comp_off/feature/comp_off_details/cubit/comp_off_details_state.dart';
import 'package:bloc/bloc.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../../../../core/data/model/ui_state.dart';
import '../../../../../core/exception/exception.dart';
import '../../../../../core/utils/app_log.dart';
import '../../../data/network/repository/comp_off_remote_repository.dart';

class CompOffDetailsCubit extends Cubit<CompOffDetailsState> {
  final CompOffRemoteRepository _compOffRemoteRepository;
  CompOffDetailsCubit(this._compOffRemoteRepository) : super(const CompOffDetailsState());

  void getCompOffDetails(int compOffID) async {
    try {
      emit(state.copyWith(uiState: UIState(isOnScreenLoading: true)));
      CompOffDetailsResponse compOffDetailsResponse = await _compOffRemoteRepository.getCompOffDetails(compOffID);
      emit(state.copyWith(compOff: compOffDetailsResponse.compOffDetails,
          uiState: UIState(isOnScreenLoading: false, event: Event.reloadWidget)));
    } on ServerException catch (e) {
      emit(state.copyWith(uiState: UIState(isOnScreenLoading: false,
          event: Event.failed, failedWithoutAlertMessage: e.message!)));
    } on FailureException catch (e) {
      emit(state.copyWith(uiState: UIState(isOnScreenLoading: false,
          event: Event.failed, failedWithoutAlertMessage: e.message!)));
    } catch (e, st) {
      AppLog.e('getCompOffDetails : ${e.toString()} \n${st.toString()}');
      emit(state.copyWith(uiState: UIState(isOnScreenLoading: false,
          event: Event.failed, failedWithoutAlertMessage: 'we_regret_the_technical_error'.tr)));
    }
  }

  void withdrawCompOff(int compOffID) async {
    try {
      emit(state.copyWith(buttonState: ButtonState(isLoading: true, message: 'please_wait'.tr)));
      await _compOffRemoteRepository.withdrawCompOff(compOffID);
      emit(state.copyWith(buttonState: const ButtonState(isLoading: false, isSuccess: true)));
      await Future.delayed(const Duration(milliseconds: 500));
      emit(state.copyWith(uiState: UIState(event: Event.success)));
    } on ServerException catch (e) {
      emit(state.copyWith(buttonState: const ButtonState(isLoading: false, isEnable: true),
          uiState: UIState(event: Event.failed, failedWithoutAlertMessage: e.message!)));
    } on FailureException catch (e) {
      emit(state.copyWith(buttonState: const ButtonState(isLoading: false, isEnable: true),
          uiState: UIState(isOnScreenLoading: false, event: Event.failed, failedWithoutAlertMessage: e.message!)));
    } catch (e, st) {
      AppLog.e('withdrawCompOff : ${e.toString()} \n${st.toString()}');
      emit(state.copyWith(buttonState: const ButtonState(isLoading: false, isEnable: true),
          uiState: UIState(isOnScreenLoading: false, event: Event.failed, failedWithoutAlertMessage: 'we_regret_the_technical_error'.tr)));
    }
  }
}
