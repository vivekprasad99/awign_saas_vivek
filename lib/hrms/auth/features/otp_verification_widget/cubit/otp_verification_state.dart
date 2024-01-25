import 'package:awign_saas/hrms/auth/data/model/user_response.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/data/local/database/model/current_user/tenant.dart';
import '../../../../../core/data/model/button_state.dart';
import '../../../../../core/data/model/ui_state.dart';
import '../data/otp_verification_argument.dart';

part 'otp_verification_state.g.dart';

@CopyWith()
class OTPVerificationState extends Equatable {
  final UIState? uiState;
  final ButtonState? buttonState;
  final bool? isShowTimer;
  final bool? isShowResendButton;
  final String? timerText;
  final bool? isShowResendOTPLoading;
  final String? otp;
  final OTPVerificationArgument? otpVerificationArgument;
  final UserResponse? userResponse;

  const OTPVerificationState(
      {this.uiState,
      this.buttonState,
      this.isShowTimer,
      this.isShowResendButton,
      this.timerText,
      this.isShowResendOTPLoading,
      this.otp,
      this.otpVerificationArgument,
      this.userResponse});

  @override
  List<Object?> get props => [
        uiState,
        buttonState,
        isShowTimer,
        isShowResendButton,
        timerText,
        isShowResendOTPLoading,
        otp,
        userResponse,
      ];
}
