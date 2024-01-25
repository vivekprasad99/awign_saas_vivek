import 'package:awign_saas/hrms/comp_off/data/model/comp_off_details_response.dart';
import 'package:bloc/bloc.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../../../../../core/data/model/ui_state.dart';
import '../../../../../../core/exception/exception.dart';
import '../../../../../../core/utils/app_log.dart';
import '../../../../../comp_off/data/network/repository/comp_off_remote_repository.dart';
import 'rm_comp_off_details_state.dart';

class RMCompOffDetailsCubit extends Cubit<RMCompOffDetailsState> {
  final CompOffRemoteRepository _compOffRemoteRepository;
  RMCompOffDetailsCubit(this._compOffRemoteRepository) : super(const RMCompOffDetailsState());

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
}
