// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otp_verification_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OTPVerificationStateCWProxy {
  OTPVerificationState uiState(UIState? uiState);

  OTPVerificationState buttonState(ButtonState? buttonState);

  OTPVerificationState isShowTimer(bool? isShowTimer);

  OTPVerificationState isShowResendButton(bool? isShowResendButton);

  OTPVerificationState timerText(String? timerText);

  OTPVerificationState isShowResendOTPLoading(bool? isShowResendOTPLoading);

  OTPVerificationState otp(String? otp);

  OTPVerificationState otpVerificationArgument(
      OTPVerificationArgument? otpVerificationArgument);

  OTPVerificationState userResponse(UserResponse? userResponse);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OTPVerificationState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OTPVerificationState(...).copyWith(id: 12, name: "My name")
  /// ````
  OTPVerificationState call({
    UIState? uiState,
    ButtonState? buttonState,
    bool? isShowTimer,
    bool? isShowResendButton,
    String? timerText,
    bool? isShowResendOTPLoading,
    String? otp,
    OTPVerificationArgument? otpVerificationArgument,
    UserResponse? userResponse,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfOTPVerificationState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfOTPVerificationState.copyWith.fieldName(...)`
class _$OTPVerificationStateCWProxyImpl
    implements _$OTPVerificationStateCWProxy {
  const _$OTPVerificationStateCWProxyImpl(this._value);

  final OTPVerificationState _value;

  @override
  OTPVerificationState uiState(UIState? uiState) => this(uiState: uiState);

  @override
  OTPVerificationState buttonState(ButtonState? buttonState) =>
      this(buttonState: buttonState);

  @override
  OTPVerificationState isShowTimer(bool? isShowTimer) =>
      this(isShowTimer: isShowTimer);

  @override
  OTPVerificationState isShowResendButton(bool? isShowResendButton) =>
      this(isShowResendButton: isShowResendButton);

  @override
  OTPVerificationState timerText(String? timerText) =>
      this(timerText: timerText);

  @override
  OTPVerificationState isShowResendOTPLoading(bool? isShowResendOTPLoading) =>
      this(isShowResendOTPLoading: isShowResendOTPLoading);

  @override
  OTPVerificationState otp(String? otp) => this(otp: otp);

  @override
  OTPVerificationState otpVerificationArgument(
          OTPVerificationArgument? otpVerificationArgument) =>
      this(otpVerificationArgument: otpVerificationArgument);

  @override
  OTPVerificationState userResponse(UserResponse? userResponse) =>
      this(userResponse: userResponse);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OTPVerificationState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OTPVerificationState(...).copyWith(id: 12, name: "My name")
  /// ````
  OTPVerificationState call({
    Object? uiState = const $CopyWithPlaceholder(),
    Object? buttonState = const $CopyWithPlaceholder(),
    Object? isShowTimer = const $CopyWithPlaceholder(),
    Object? isShowResendButton = const $CopyWithPlaceholder(),
    Object? timerText = const $CopyWithPlaceholder(),
    Object? isShowResendOTPLoading = const $CopyWithPlaceholder(),
    Object? otp = const $CopyWithPlaceholder(),
    Object? otpVerificationArgument = const $CopyWithPlaceholder(),
    Object? userResponse = const $CopyWithPlaceholder(),
  }) {
    return OTPVerificationState(
      uiState: uiState == const $CopyWithPlaceholder()
          ? _value.uiState
          // ignore: cast_nullable_to_non_nullable
          : uiState as UIState?,
      buttonState: buttonState == const $CopyWithPlaceholder()
          ? _value.buttonState
          // ignore: cast_nullable_to_non_nullable
          : buttonState as ButtonState?,
      isShowTimer: isShowTimer == const $CopyWithPlaceholder()
          ? _value.isShowTimer
          // ignore: cast_nullable_to_non_nullable
          : isShowTimer as bool?,
      isShowResendButton: isShowResendButton == const $CopyWithPlaceholder()
          ? _value.isShowResendButton
          // ignore: cast_nullable_to_non_nullable
          : isShowResendButton as bool?,
      timerText: timerText == const $CopyWithPlaceholder()
          ? _value.timerText
          // ignore: cast_nullable_to_non_nullable
          : timerText as String?,
      isShowResendOTPLoading:
          isShowResendOTPLoading == const $CopyWithPlaceholder()
              ? _value.isShowResendOTPLoading
              // ignore: cast_nullable_to_non_nullable
              : isShowResendOTPLoading as bool?,
      otp: otp == const $CopyWithPlaceholder()
          ? _value.otp
          // ignore: cast_nullable_to_non_nullable
          : otp as String?,
      otpVerificationArgument:
          otpVerificationArgument == const $CopyWithPlaceholder()
              ? _value.otpVerificationArgument
              // ignore: cast_nullable_to_non_nullable
              : otpVerificationArgument as OTPVerificationArgument?,
      userResponse: userResponse == const $CopyWithPlaceholder()
          ? _value.userResponse
          // ignore: cast_nullable_to_non_nullable
          : userResponse as UserResponse?,
    );
  }
}

extension $OTPVerificationStateCopyWith on OTPVerificationState {
  /// Returns a callable class that can be used as follows: `instanceOfOTPVerificationState.copyWith(...)` or like so:`instanceOfOTPVerificationState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OTPVerificationStateCWProxy get copyWith =>
      _$OTPVerificationStateCWProxyImpl(this);
}
