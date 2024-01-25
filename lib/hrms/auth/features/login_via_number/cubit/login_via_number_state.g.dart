// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_via_number_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$LoginViaNumberStateCWProxy {
  LoginViaNumberState uiState(UIState? uiState);

  LoginViaNumberState buttonState(ButtonState? buttonState);

  LoginViaNumberState mobileNumber(String? mobileNumber);

  LoginViaNumberState mobileNumberError(String? mobileNumberError);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `LoginViaNumberState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// LoginViaNumberState(...).copyWith(id: 12, name: "My name")
  /// ````
  LoginViaNumberState call({
    UIState? uiState,
    ButtonState? buttonState,
    String? mobileNumber,
    String? mobileNumberError,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfLoginViaNumberState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfLoginViaNumberState.copyWith.fieldName(...)`
class _$LoginViaNumberStateCWProxyImpl implements _$LoginViaNumberStateCWProxy {
  const _$LoginViaNumberStateCWProxyImpl(this._value);

  final LoginViaNumberState _value;

  @override
  LoginViaNumberState uiState(UIState? uiState) => this(uiState: uiState);

  @override
  LoginViaNumberState buttonState(ButtonState? buttonState) =>
      this(buttonState: buttonState);

  @override
  LoginViaNumberState mobileNumber(String? mobileNumber) =>
      this(mobileNumber: mobileNumber);

  @override
  LoginViaNumberState mobileNumberError(String? mobileNumberError) =>
      this(mobileNumberError: mobileNumberError);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `LoginViaNumberState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// LoginViaNumberState(...).copyWith(id: 12, name: "My name")
  /// ````
  LoginViaNumberState call({
    Object? uiState = const $CopyWithPlaceholder(),
    Object? buttonState = const $CopyWithPlaceholder(),
    Object? mobileNumber = const $CopyWithPlaceholder(),
    Object? mobileNumberError = const $CopyWithPlaceholder(),
  }) {
    return LoginViaNumberState(
      uiState: uiState == const $CopyWithPlaceholder()
          ? _value.uiState
          // ignore: cast_nullable_to_non_nullable
          : uiState as UIState?,
      buttonState: buttonState == const $CopyWithPlaceholder()
          ? _value.buttonState
          // ignore: cast_nullable_to_non_nullable
          : buttonState as ButtonState?,
      mobileNumber: mobileNumber == const $CopyWithPlaceholder()
          ? _value.mobileNumber
          // ignore: cast_nullable_to_non_nullable
          : mobileNumber as String?,
      mobileNumberError: mobileNumberError == const $CopyWithPlaceholder()
          ? _value.mobileNumberError
          // ignore: cast_nullable_to_non_nullable
          : mobileNumberError as String?,
    );
  }
}

extension $LoginViaNumberStateCopyWith on LoginViaNumberState {
  /// Returns a callable class that can be used as follows: `instanceOfLoginViaNumberState.copyWith(...)` or like so:`instanceOfLoginViaNumberState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$LoginViaNumberStateCWProxy get copyWith =>
      _$LoginViaNumberStateCWProxyImpl(this);
}
