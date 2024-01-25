// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rm_comp_off_approve_reject_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$RMCompOffApproveRejectStateCWProxy {
  RMCompOffApproveRejectState uiState(UIState? uiState);

  RMCompOffApproveRejectState buttonState(ButtonState? buttonState);

  RMCompOffApproveRejectState remarks(String? remarks);

  RMCompOffApproveRejectState compOff(CompOff? compOff);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RMCompOffApproveRejectState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RMCompOffApproveRejectState(...).copyWith(id: 12, name: "My name")
  /// ````
  RMCompOffApproveRejectState call({
    UIState? uiState,
    ButtonState? buttonState,
    String? remarks,
    CompOff? compOff,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfRMCompOffApproveRejectState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfRMCompOffApproveRejectState.copyWith.fieldName(...)`
class _$RMCompOffApproveRejectStateCWProxyImpl
    implements _$RMCompOffApproveRejectStateCWProxy {
  const _$RMCompOffApproveRejectStateCWProxyImpl(this._value);

  final RMCompOffApproveRejectState _value;

  @override
  RMCompOffApproveRejectState uiState(UIState? uiState) =>
      this(uiState: uiState);

  @override
  RMCompOffApproveRejectState buttonState(ButtonState? buttonState) =>
      this(buttonState: buttonState);

  @override
  RMCompOffApproveRejectState remarks(String? remarks) =>
      this(remarks: remarks);

  @override
  RMCompOffApproveRejectState compOff(CompOff? compOff) =>
      this(compOff: compOff);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RMCompOffApproveRejectState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RMCompOffApproveRejectState(...).copyWith(id: 12, name: "My name")
  /// ````
  RMCompOffApproveRejectState call({
    Object? uiState = const $CopyWithPlaceholder(),
    Object? buttonState = const $CopyWithPlaceholder(),
    Object? remarks = const $CopyWithPlaceholder(),
    Object? compOff = const $CopyWithPlaceholder(),
  }) {
    return RMCompOffApproveRejectState(
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
      compOff: compOff == const $CopyWithPlaceholder()
          ? _value.compOff
          // ignore: cast_nullable_to_non_nullable
          : compOff as CompOff?,
    );
  }
}

extension $RMCompOffApproveRejectStateCopyWith on RMCompOffApproveRejectState {
  /// Returns a callable class that can be used as follows: `instanceOfRMCompOffApproveRejectState.copyWith(...)` or like so:`instanceOfRMCompOffApproveRejectState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RMCompOffApproveRejectStateCWProxy get copyWith =>
      _$RMCompOffApproveRejectStateCWProxyImpl(this);
}
