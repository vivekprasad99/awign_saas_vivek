import 'package:bloc/bloc.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../../../../core/data/model/button_state.dart';
import '../../../../../core/data/model/ui_state.dart';
import '../../../../../core/exception/exception.dart';
import '../../../../../core/utils/app_log.dart';
import '../../../data/model/regularisation_status_response.dart';
import '../../../data/network/repository/regularisation_remote_repository.dart';
import 'regularisation_details_state.dart';


class RegularisationDetailsCubit extends Cubit<RegularisationDetailsState> {
  final RegularisationRemoteRepository _regularisationRemoteRepository;
  RegularisationDetailsCubit(this._regularisationRemoteRepository) : super(const RegularisationDetailsState());

  updateRegularisation(Regularisation regularisation) {
    emit(state.copyWith(regularisation: regularisation));
  }

  void withdrawRegularisation() async {
    try {
      emit(state.copyWith(buttonState: ButtonState(isLoading: true, message: 'please_wait'.tr)));
      await _regularisationRemoteRepository.withdrawRegularisation(state.regularisation?.id ?? '');
      emit(state.copyWith(buttonState: const ButtonState(isLoading: false, isSuccess: true)));
      await Future.delayed(const Duration(milliseconds: 500));
      emit(state.copyWith(uiState: UIState(event: Event.success)));
    } on ServerException catch (e) {
      emit(state.copyWith(buttonState: const ButtonState(isLoading: false),
          uiState: UIState(event: Event.failed, failedWithoutAlertMessage: e.message!)));
    } on FailureException catch (e) {
      emit(state.copyWith(buttonState: const ButtonState(isLoading: false),
          uiState: UIState(isOnScreenLoading: false, event: Event.failed, failedWithoutAlertMessage: e.message!)));
    } catch (e, st) {
      AppLog.e('withdrawRegularisation : ${e.toString()} \n${st.toString()}');
      emit(state.copyWith(buttonState: const ButtonState(isLoading: false),
          uiState: UIState(isOnScreenLoading: false, event: Event.failed, failedWithoutAlertMessage: 'we_regret_the_technical_error'.tr)));
    }
  }
}
