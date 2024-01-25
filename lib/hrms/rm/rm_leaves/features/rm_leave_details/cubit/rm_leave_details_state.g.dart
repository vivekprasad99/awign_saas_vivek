// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rm_leave_details_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$RMLeaveDetailsStateCWProxy {
  RMLeaveDetailsState uiState(UIState? uiState);

  RMLeaveDetailsState approveButtonState(ButtonState? approveButtonState);

  RMLeaveDetailsState rejectButtonState(ButtonState? rejectButtonState);

  RMLeaveDetailsState leave(Leave? leave);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RMLeaveDetailsState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RMLeaveDetailsState(...).copyWith(id: 12, name: "My name")
  /// ````
  RMLeaveDetailsState call({
    UIState? uiState,
    ButtonState? approveButtonState,
    ButtonState? rejectButtonState,
    Leave? leave,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfRMLeaveDetailsState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfRMLeaveDetailsState.copyWith.fieldName(...)`
class _$RMLeaveDetailsStateCWProxyImpl implements _$RMLeaveDetailsStateCWProxy {
  const _$RMLeaveDetailsStateCWProxyImpl(this._value);

  final RMLeaveDetailsState _value;

  @override
  RMLeaveDetailsState uiState(UIState? uiState) => this(uiState: uiState);

  @override
  RMLeaveDetailsState approveButtonState(ButtonState? approveButtonState) =>
      this(approveButtonState: approveButtonState);

  @override
  RMLeaveDetailsState rejectButtonState(ButtonState? rejectButtonState) =>
      this(rejectButtonState: rejectButtonState);

  @override
  RMLeaveDetailsState leave(Leave? leave) => this(leave: leave);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RMLeaveDetailsState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RMLeaveDetailsState(...).copyWith(id: 12, name: "My name")
  /// ````
  RMLeaveDetailsState call({
    Object? uiState = const $CopyWithPlaceholder(),
    Object? approveButtonState = const $CopyWithPlaceholder(),
    Object? rejectButtonState = const $CopyWithPlaceholder(),
    Object? leave = const $CopyWithPlaceholder(),
  }) {
    return RMLeaveDetailsState(
      uiState: uiState == const $CopyWithPlaceholder()
          ? _value.uiState
          // ignore: cast_nullable_to_non_nullable
          : uiState as UIState?,
      approveButtonState: approveButtonState == const $CopyWithPlaceholder()
          ? _value.approveButtonState
          // ignore: cast_nullable_to_non_nullable
          : approveButtonState as ButtonState?,
      rejectButtonState: rejectButtonState == const $CopyWithPlaceholder()
          ? _value.rejectButtonState
          // ignore: cast_nullable_to_non_nullable
          : rejectButtonState as ButtonState?,
      leave: leave == const $CopyWithPlaceholder()
          ? _value.leave
          // ignore: cast_nullable_to_non_nullable
          : leave as Leave?,
    );
  }
}

extension $RMLeaveDetailsStateCopyWith on RMLeaveDetailsState {
  /// Returns a callable class that can be used as follows: `instanceOfRMLeaveDetailsState.copyWith(...)` or like so:`instanceOfRMLeaveDetailsState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RMLeaveDetailsStateCWProxy get copyWith =>
      _$RMLeaveDetailsStateCWProxyImpl(this);
}
