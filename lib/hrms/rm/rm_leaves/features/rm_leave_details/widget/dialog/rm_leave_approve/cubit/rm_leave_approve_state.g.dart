// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rm_leave_approve_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$RMLeaveApproveStateCWProxy {
  RMLeaveApproveState uiState(UIState? uiState);

  RMLeaveApproveState buttonState(ButtonState? buttonState);

  RMLeaveApproveState remarks(String? remarks);

  RMLeaveApproveState leave(Leave? leave);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RMLeaveApproveState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RMLeaveApproveState(...).copyWith(id: 12, name: "My name")
  /// ````
  RMLeaveApproveState call({
    UIState? uiState,
    ButtonState? buttonState,
    String? remarks,
    Leave? leave,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfRMLeaveApproveState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfRMLeaveApproveState.copyWith.fieldName(...)`
class _$RMLeaveApproveStateCWProxyImpl implements _$RMLeaveApproveStateCWProxy {
  const _$RMLeaveApproveStateCWProxyImpl(this._value);

  final RMLeaveApproveState _value;

  @override
  RMLeaveApproveState uiState(UIState? uiState) => this(uiState: uiState);

  @override
  RMLeaveApproveState buttonState(ButtonState? buttonState) =>
      this(buttonState: buttonState);

  @override
  RMLeaveApproveState remarks(String? remarks) => this(remarks: remarks);

  @override
  RMLeaveApproveState leave(Leave? leave) => this(leave: leave);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RMLeaveApproveState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RMLeaveApproveState(...).copyWith(id: 12, name: "My name")
  /// ````
  RMLeaveApproveState call({
    Object? uiState = const $CopyWithPlaceholder(),
    Object? buttonState = const $CopyWithPlaceholder(),
    Object? remarks = const $CopyWithPlaceholder(),
    Object? leave = const $CopyWithPlaceholder(),
  }) {
    return RMLeaveApproveState(
      uiState: uiState == const $CopyWithPlaceholder()
          ? _value.uiState
          // ignore: cast_nullable_to_non_nullable
          : uiState as UIState?,
      buttonState: buttonState == const $CopyWithPlaceholder()
          ? _value.buttonState
          // ignore: cast_nullable_to_non_nullable
          : buttonState as ButtonState?,
      remarks: remarks == const $CopyWithPlaceholder()
          ? _value.remarks
          // ignore: cast_nullable_to_non_nullable
          : remarks as String?,
      leave: leave == const $CopyWithPlaceholder()
          ? _value.leave
          // ignore: cast_nullable_to_non_nullable
          : leave as Leave?,
    );
  }
}

extension $RMLeaveApproveStateCopyWith on RMLeaveApproveState {
  /// Returns a callable class that can be used as follows: `instanceOfRMLeaveApproveState.copyWith(...)` or like so:`instanceOfRMLeaveApproveState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RMLeaveApproveStateCWProxy get copyWith =>
      _$RMLeaveApproveStateCWProxyImpl(this);
}
