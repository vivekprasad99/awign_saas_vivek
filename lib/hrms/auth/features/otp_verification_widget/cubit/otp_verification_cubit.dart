import 'dart:async';

import 'package:awign_saas/core/data/local/database/user_preferences/user_preferences.dart';
import 'package:awign_saas/core/data/model/button_state.dart';
import 'package:awign_saas/core/extension/common_extension.dart';
import 'package:awign_saas/hrms/auth/data/model/employee_details.dart';
import 'package:awign_saas/hrms/auth/data/model/user_response.dart';
import 'package:awign_saas/hrms/auth/features/otp_verification_widget/data/otp_verification_argument.dart';
import 'package:bloc/bloc.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import '../../../../../core/data/local/database/model/current_user/user.dart';
import '../../../../../core/data/model/api_response.dart';
import '../../../../../core/data/model/ui_state.dart';
import '../../../../../core/exception/exception.dart';
import '../../../../../core/utils/app_log.dart';
import '../../../../../core/utils/validator.dart';
import '../../../data/network/repository/auth_remote_repository.dart';
import 'otp_verification_state.dart';

class OtpVerificationCubit extends Cubit<OTPVerificationState> {
  final AuthRemoteRepository _authRemoteRepository;
  OtpVerificationCubit(this._authRemoteRepository) : super(const OTPVerificationState(buttonState: ButtonState()));

  void updateOTP(String? otp) {
    if (Validator.checkOTP(otp) == null) {
      emit(state.copyWith(otp: otp, buttonState: const ButtonState(isEnable: true)));
    } else {
      emit(state.copyWith(otp: null, buttonState: const ButtonState(isEnable: false)));
    }
  }

  showResendOTPTimer(OTPVerificationArgument otpVerificationArgument) {
    emit(state.copyWith(otpVerificationArgument: otpVerificationArgument));
    startResendOTPTimer(otpVerificationArgument.getTimerSecond());
  }

  void startResendOTPTimer(int timerSecond) {
    var interval = const Duration(seconds: 1);
    int timerMaxSeconds = timerSecond;
    int currentSeconds = 0;
    var duration = interval;
    Timer.periodic(duration, (timer) {
      currentSeconds = timer.tick;
      String timerText =
          '${((timerMaxSeconds - currentSeconds) ~/ 60).toString().padLeft(2, '0')}:${((timerMaxSeconds - currentSeconds) % 60).toString().padLeft(2, '0')}';
      if (timerText == '00:00' && !isClosed) {
        emit(state.copyWith(timerText: timerText, isShowTimer: false, isShowResendButton: true));
      } else if(!isClosed) {
        emit(state.copyWith(timerText: timerText, isShowTimer: true, isShowResendOTPLoading: false));
      }
      if (timer.tick >= timerMaxSeconds) timer.cancel();
    });
  }

  void sendOTP() async {
    try {
      emit(state.copyWith(isShowResendButton: false, isShowResendOTPLoading: true));
      var (String resendTime, String xAuthToken) = await _authRemoteRepository.sendOTP(state.otpVerificationArgument?.mobileNumber ?? '');
      UserPreferences.getInstance().putXAuthToken(xAuthToken);
      OTPVerificationArgument? otpVerificationArgument = state.otpVerificationArgument;
      otpVerificationArgument?.resendTime = resendTime;
      emit(state.copyWith(otpVerificationArgument: otpVerificationArgument));
      startResendOTPTimer(state.otpVerificationArgument!.getTimerSecond());
    } on ServerException catch (e) {
      emit(state.copyWith(isShowResendOTPLoading: false, isShowResendButton: true, uiState: UIState(event: Event.failed, failedWithoutAlertMessage: e.message!),
          buttonState: const ButtonState(isLoading: false, isEnable: true)));
    } on FailureException catch (e) {
      emit(state.copyWith(isShowResendOTPLoading: false, isShowResendButton: true, uiState: UIState(event: Event.failed, failedWithoutAlertMessage: e.message!),
          buttonState: const ButtonState(isLoading: false, isEnable: true)));
    } catch (e, st) {
      AppLog.e('sendOTP : ${e.toString()} \n${st.toString()}');
      emit(state.copyWith(isShowResendOTPLoading: false, isShowResendButton: true, uiState: UIState(event: Event.failed, failedWithoutAlertMessage: 'we_regret_the_technical_error'.tr),
          buttonState: const ButtonState(isLoading: false, isEnable: true)));
    }
  }

  void validateOTP() async {
    try {
      emit(state.copyWith(buttonState: ButtonState(isLoading: true, message: 'please_wait'.tr)));
      var (UserResponse userResponse, String xAuthToken) = await _authRemoteRepository.validateOTP(state.otp ?? '');
      if(userResponse.user != null) {
        UserPreferences.getInstance().putXAuthToken(xAuthToken);
        if(userResponse.tenants?.length == 1) {
          userResponse.user!.tenant = userResponse.tenants![0];
          getAuthTokenByTenantID(userResponse.user!);
        } else {
          emit(state.copyWith(userResponse: userResponse, uiState: UIState(isOnScreenLoading: false, event: Event.success)));
        }
      } else {
        emit(state.copyWith(buttonState: const ButtonState(isEnable: true), uiState: UIState(event: Event.failed, failedWithoutAlertMessage: 'we_regret_the_technical_error'.tr)));
      }
    } on ServerException catch (e) {
      emit(state.copyWith(buttonState: const ButtonState(isEnable: true), uiState: UIState(event: Event.failed, failedWithoutAlertMessage: e.message!)));
    } on FailureException catch (e) {
      emit(state.copyWith(buttonState: const ButtonState(isEnable: true), uiState: UIState(event: Event.failed, failedWithoutAlertMessage: e.message!)));
    } catch (e, st) {
      AppLog.e('validateOTP : ${e.toString()} \n${st.toString()}');
      emit(state.copyWith(buttonState: const ButtonState(isEnable: true), uiState: UIState(event: Event.failed, failedWithoutAlertMessage: 'we_regret_the_technical_error'.tr)));
    }
  }

  void getAuthTokenByTenantID(User user) async {
    try {
      var (ApiResponse apiResponse, String xAuthToken) = await _authRemoteRepository.getAuthTokenByTenantID(user.tenant?.organization ?? '');
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
