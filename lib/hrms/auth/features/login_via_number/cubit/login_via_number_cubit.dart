import 'package:awign_saas/core/data/local/database/user_preferences/user_preferences.dart';
import 'package:awign_saas/core/data/model/button_state.dart';
import 'package:awign_saas/hrms/auth/features/otp_verification_widget/data/otp_verification_argument.dart';
import 'package:bloc/bloc.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import '../../../../../core/data/model/ui_state.dart';
import '../../../../../core/exception/exception.dart';
import '../../../../../core/utils/app_log.dart';
import '../../../../../core/utils/validator.dart';
import '../../../data/network/repository/auth_remote_repository.dart';
import 'login_via_number_state.dart';


class LoginViaNumberCubit extends Cubit<LoginViaNumberState> {
  final AuthRemoteRepository _authRemoteRepository;
  LoginViaNumberCubit(this._authRemoteRepository) : super(const LoginViaNumberState(buttonState: ButtonState()));

  void updateMobileNumber(String? mobileNumber) {
    if (Validator.checkMobileNumber(mobileNumber) == null) {
      emit(state.copyWith(mobileNumberError: null, mobileNumber: mobileNumber, buttonState: const ButtonState(isEnable: true)));
    } else {
      emit(state.copyWith(mobileNumberError: Validator.checkMobileNumber(mobileNumber), buttonState: const ButtonState(isEnable: false)));
    }
  }

  void sendOTP() async {
    try {
      emit(state.copyWith(buttonState: ButtonState(isLoading: true, message: 'please_wait'.tr)));
      var (String resendTime, String xAuthToken) = await _authRemoteRepository.sendOTP(state.mobileNumber ?? '');
      UserPreferences.getInstance().putXAuthToken(xAuthToken);
      emit(state.copyWith(uiState: UIState(event: Event.otpSent, data: OTPVerificationArgument(state.mobileNumber!, resendTime)),
          buttonState: const ButtonState(isLoading: false, isEnable: true)));
    } on ServerException catch (e) {
      emit(state.copyWith(uiState: UIState(event: Event.failed, failedWithoutAlertMessage: e.message!),
          buttonState: const ButtonState(isLoading: false, isEnable: true)));
    } on FailureException catch (e) {
      emit(state.copyWith(uiState: UIState(event: Event.failed, failedWithoutAlertMessage: e.message!),
          buttonState: const ButtonState(isLoading: false, isEnable: true)));
    } catch (e, st) {
      AppLog.e('sendOTP : ${e.toString()} \n${st.toString()}');
      emit(state.copyWith(uiState: UIState(event: Event.failed, failedWithoutAlertMessage: 'we_regret_the_technical_error'.tr),
          buttonState: const ButtonState(isLoading: false, isEnable: true)));
    }
  }
}
