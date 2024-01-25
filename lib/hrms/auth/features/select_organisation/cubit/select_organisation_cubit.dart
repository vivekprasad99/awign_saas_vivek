import 'package:awign_saas/core/data/local/database/model/current_user/user.dart';
import 'package:awign_saas/core/data/model/button_state.dart';
import 'package:awign_saas/core/extension/common_extension.dart';
import 'package:awign_saas/hrms/auth/data/model/user_response.dart';
import 'package:bloc/bloc.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../../../../core/data/local/database/model/current_user/tenant.dart';
import '../../../../../core/data/local/database/user_preferences/user_preferences.dart';
import '../../../../../core/data/model/api_response.dart';
import '../../../../../core/data/model/ui_state.dart';
import '../../../../../core/exception/exception.dart';
import '../../../../../core/utils/app_log.dart';
import '../../../data/model/employee_details.dart';
import '../../../data/network/repository/auth_remote_repository.dart';
import 'select_organisation_state.dart';

class SelectOrganisationCubit extends Cubit<SelectOrganisationState> {
  final AuthRemoteRepository _authRemoteRepository;
  SelectOrganisationCubit(this._authRemoteRepository) : super(const SelectOrganisationState(buttonState: ButtonState()));

  updateUserDetails(UserResponse userResponse) {
    emit(state.copyWith(user: userResponse.user, tenants: userResponse.tenants, otpVerified: userResponse.otpVerified));
  }

  updateTenantList(int index, Tenant tenant) {
    if(state.tenants != null) {
      List<Tenant> tenantList = state.tenants!;
      List<Tenant> tempTenantList = [];
      tempTenantList.addAll(tenantList);
      for(int i = 0; i < tenantList.length; i++) {
        Tenant tenant = tempTenantList[i];
        tenant.isSelected = false;
        tempTenantList[i] = tenant;
      }
      tenant.isSelected = true;
      tempTenantList[index] = tenant;
      emit(state.copyWith(tenants: List.from(tempTenantList), uiState: UIState(event: Event.reloadWidget),
          buttonState: const ButtonState(isEnable: true), selectedTenant: tenant));
    }
  }

  void getAuthTokenByTenantID() async {
    try {
      emit(state.copyWith(buttonState: ButtonState(isLoading: true, message: 'please_wait'.tr)));
      var (ApiResponse apiResponse, String xAuthToken) = await _authRemoteRepository.getAuthTokenByTenantID(state.selectedTenant?.organization ?? '');
      User user = state.user!;
      user.tenant = state.selectedTenant;
      UserPreferences.getInstance().putXAuthToken(xAuthToken);
      getEmployeeDetails(user, apiResponse.message);
    } on ServerException catch (e) {
      emit(state.copyWith(buttonState: const ButtonState(isEnable: true), uiState: UIState(event: Event.failed, failedWithoutAlertMessage: e.message!)));
    } on FailureException catch (e) {
      emit(state.copyWith(buttonState: const ButtonState(isEnable: true), uiState: UIState(event: Event.failed, failedWithoutAlertMessage: e.message!)));
    } catch (e, st) {
      AppLog.e('getAuthTokenByTenantID : ${e.toString()} \n${st.toString()}');
      emit(state.copyWith(buttonState: const ButtonState(isEnable: true), uiState: UIState(event: Event.failed, failedWithoutAlertMessage: 'we_regret_the_technical_error'.tr)));
    }
  }

  void getEmployeeDetails(User user, String? message) async {
    try {
      EmployeeDetails employeeDetails = await _authRemoteRepository.getEmployeeDetails(user.tenant?.userId ?? '');
      if(!employeeDetails.teams.isNullOrEmpty && (employeeDetails.teams?[0].head ?? false)
          && employeeDetails.teams?[0].headId == user.tenant?.userId) {
        user.isManager = true;
      }
      user.workLocation = employeeDetails.workLocation;
      UserPreferences.getInstance().putCurrentUser(user);
      emit(state.copyWith(buttonState: ButtonState(isSuccess: true, message: message)));
      await Future.delayed(const Duration(milliseconds: 500));
      emit(state.copyWith(uiState: UIState(event: Event.verified)));
    } on ServerException catch (e) {
      emit(state.copyWith(buttonState: const ButtonState(isEnable: true), uiState: UIState(event: Event.failed, failedWithoutAlertMessage: e.message!)));
    } on FailureException catch (e) {
      emit(state.copyWith(buttonState: const ButtonState(isEnable: true), uiState: UIState(event: Event.failed, failedWithoutAlertMessage: e.message!)));
    } catch (e, st) {
      AppLog.e('getEmployeeDetails : ${e.toString()} \n${st.toString()}');
      emit(state.copyWith(buttonState: const ButtonState(isEnable: true), uiState: UIState(event: Event.failed, failedWithoutAlertMessage: 'we_regret_the_technical_error'.tr)));
    }
  }
}
