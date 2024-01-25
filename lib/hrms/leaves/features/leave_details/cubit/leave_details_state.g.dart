// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave_details_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$LeaveDetailsStateCWProxy {
  LeaveDetailsState uiState(UIState? uiState);

  LeaveDetailsState buttonState(ButtonState? buttonState);

  LeaveDetailsState leave(Leave? leave);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `LeaveDetailsState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// LeaveDetailsState(...).copyWith(id: 12, name: "My name")
  /// ````
  LeaveDetailsState call({
    UIState? uiState,
    ButtonState? buttonState,
    Leave? leave,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfLeaveDetailsState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfLeaveDetailsState.copyWith.fieldName(...)`
class _$LeaveDetailsStateCWProxyImpl implements _$LeaveDetailsStateCWProxy {
  const _$LeaveDetailsStateCWProxyImpl(this._value);

  final LeaveDetailsState _value;

  @override
  LeaveDetailsState uiState(UIState? uiState) => this(uiState: uiState);

  @override
  LeaveDetailsState buttonState(ButtonState? buttonState) =>
      this(buttonState: buttonState);

  @override
  LeaveDetailsState leave(Leave? leave) => this(leave: leave);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `LeaveDetailsState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// LeaveDetailsState(...).copyWith(id: 12, name: "My name")
  /// ````
  LeaveDetailsState call({
    Object? uiState = const $CopyWithPlaceholder(),
    Object? buttonState = const $CopyWithPlaceholder(),
    Object? leave = const $CopyWithPlaceholder(),
  }) {
    return LeaveDetailsState(
      uiState: uiState == const $CopyWithPlaceholder()
          ? _value.uiState
          // ignore: cast_nullable_to_non_nullable
          : uiState as UIState?,
      buttonState: buttonState == const $CopyWithPlaceholder()
          ? _value.buttonState
          // ignore: cast_nullable_to_non_nullable
          : buttonState as ButtonState?,
      leave: leave == const $CopyWithPlaceholder()
          ? _value.leave
          // ignore: cast_nullable_to_non_nullable
          : leave as Leave?,
    );
  }
}

extension $LeaveDetailsStateCopyWith on LeaveDetailsState {
  /// Returns a callable class that can be used as follows: `instanceOfLeaveDetailsState.copyWith(...)` or like so:`instanceOfLeaveDetailsState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$LeaveDetailsStateCWProxy get copyWith =>
      _$LeaveDetailsStateCWProxyImpl(this);
}
