import 'package:awign_saas/core/data/local/database/user_preferences/user_preferences.dart';
import 'package:awign_saas/core/exception/exception.dart';
import 'package:awign_saas/core/utils/app_log.dart';
import 'package:awign_saas/hrms/auth/data/model/employee_details.dart';
import 'package:awign_saas/hrms/auth/data/network/repository/auth_remote_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:get/get.dart';

import '../../../../../core/data/model/ui_state.dart';
import 'personal_details_state.dart';

class PersonalDetailsCubit extends Cubit<PersonalDetailsState> {
  final AuthRemoteRepository _authRemoteRepository;

  PersonalDetailsCubit(this._authRemoteRepository)
      : super(const PersonalDetailsState(currentTabIndex: 0));

  void updateCurrentTabIndex(int currentTabIndex) {
    emit(state.copyWith(currentTabIndex: currentTabIndex));
  }

  void getEmployeeDetails() async {
    try {
      emit(state.copyWith(isLoading: true));
      String? id = UserPreferences.getInstance().getCurrentUser()?.tenant?.userId;
      EmployeeDetails employeeDetails =
          await _authRemoteRepository.getEmployeeDetails(id ?? '');
      emit(state.copyWith(isLoading: false,employeeDetails: employeeDetails));
    } on ServerException catch (e) {
      emit(state.copyWith(
          isLoading: false,
          employeeDetails: null,
          uiState: UIState(
              event: Event.failed, failedWithoutAlertMessage: e.message!)));
    } on FailureException catch (e) {
      emit(state.copyWith(
          isLoading: false,
          employeeDetails: null,
          uiState: UIState(
              event: Event.failed, failedWithoutAlertMessage: e.message!)));
    } catch (e, st) {
      AppLog.e('getEmployeeDetails : ${e.toString()} \n${st.toString()}');
      emit(state.copyWith(
          isLoading: false,
          employeeDetails: null,
          uiState: UIState(
              event: Event.failed,
              failedWithoutAlertMessage: 'we_regret_the_technical_error'.tr)));
    }
  }
}
