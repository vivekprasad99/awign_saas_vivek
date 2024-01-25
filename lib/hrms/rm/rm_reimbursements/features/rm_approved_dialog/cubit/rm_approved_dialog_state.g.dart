// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rm_approved_dialog_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$RmApprovedDialogStateCWProxy {
  RmApprovedDialogState uiState(UIState? uiState);

  RmApprovedDialogState buttonState(ButtonState? buttonState);

  RmApprovedDialogState amount(String? amount);

  RmApprovedDialogState amountError(String? amountError);

  RmApprovedDialogState remark(String? remark);

  RmApprovedDialogState remarkError(String? remarkError);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RmApprovedDialogState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RmApprovedDialogState(...).copyWith(id: 12, name: "My name")
  /// ````
  RmApprovedDialogState call({
    UIState? uiState,
    ButtonState? buttonState,
    String? amount,
    String? amountError,
    String? remark,
    String? remarkError,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfRmApprovedDialogState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfRmApprovedDialogState.copyWith.fieldName(...)`
class _$RmApprovedDialogStateCWProxyImpl
    implements _$RmApprovedDialogStateCWProxy {
  const _$RmApprovedDialogStateCWProxyImpl(this._value);

  final RmApprovedDialogState _value;

  @override
  RmApprovedDialogState uiState(UIState? uiState) => this(uiState: uiState);

  @override
  RmApprovedDialogState buttonState(ButtonState? buttonState) =>
      this(buttonState: buttonState);

  @override
  RmApprovedDialogState amount(String? amount) => this(amount: amount);

  @override
  RmApprovedDialogState amountError(String? amountError) =>
      this(amountError: amountError);

  @override
  RmApprovedDialogState remark(String? remark) => this(remark: remark);

  @override
  RmApprovedDialogState remarkError(String? remarkError) =>
      this(remarkError: remarkError);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RmApprovedDialogState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RmApprovedDialogState(...).copyWith(id: 12, name: "My name")
  /// ````
  RmApprovedDialogState call({
    Object? uiState = const $CopyWithPlaceholder(),
    Object? buttonState = const $CopyWithPlaceholder(),
    Object? amount = const $CopyWithPlaceholder(),
    Object? amountError = const $CopyWithPlaceholder(),
    Object? remark = const $CopyWithPlaceholder(),
    Object? remarkError = const $CopyWithPlaceholder(),
  }) {
    return RmApprovedDialogState(
      uiState: uiState == const $CopyWithPlaceholder()
          ? _value.uiState
          // ignore: cast_nullable_to_non_nullable
          : uiState as UIState?,
      buttonState: buttonState == const $CopyWithPlaceholder()
          ? _value.buttonState
          // ignore: cast_nullable_to_non_nullable
          : buttonState as ButtonState?,
      amount: amount == const $CopyWithPlaceholder()
          ? _value.amount
          // ignore: cast_nullable_to_non_nullable
          : amount as String?,
      amountError: amountError == const $CopyWithPlaceholder()
          ? _value.amountError
          // ignore: cast_nullable_to_non_nullable
          : amountError as String?,
      remark: remark == const $CopyWithPlaceholder()
          ? _value.remark
          // ignore: cast_nullable_to_non_nullable
          : remark as String?,
      remarkError: remarkError == const $CopyWithPlaceholder()
          ? _value.remarkError
          // ignore: cast_nullable_to_non_nullable
          : remarkError as String?,
    );
  }
}

extension $RmApprovedDialogStateCopyWith on RmApprovedDialogState {
  /// Returns a callable class that can be used as follows: `instanceOfRmApprovedDialogState.copyWith(...)` or like so:`instanceOfRmApprovedDialogState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RmApprovedDialogStateCWProxy get copyWith =>
      _$RmApprovedDialogStateCWProxyImpl(this);
}
