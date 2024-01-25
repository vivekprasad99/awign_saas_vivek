// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rm_comp_off_details_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$RMCompOffDetailsStateCWProxy {
  RMCompOffDetailsState uiState(UIState? uiState);

  RMCompOffDetailsState approveButtonState(ButtonState? approveButtonState);

  RMCompOffDetailsState rejectButtonState(ButtonState? rejectButtonState);

  RMCompOffDetailsState compOff(CompOff? compOff);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RMCompOffDetailsState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RMCompOffDetailsState(...).copyWith(id: 12, name: "My name")
  /// ````
  RMCompOffDetailsState call({
    UIState? uiState,
    ButtonState? approveButtonState,
    ButtonState? rejectButtonState,
    CompOff? compOff,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfRMCompOffDetailsState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfRMCompOffDetailsState.copyWith.fieldName(...)`
class _$RMCompOffDetailsStateCWProxyImpl
    implements _$RMCompOffDetailsStateCWProxy {
  const _$RMCompOffDetailsStateCWProxyImpl(this._value);

  final RMCompOffDetailsState _value;

  @override
  RMCompOffDetailsState uiState(UIState? uiState) => this(uiState: uiState);

  @override
  RMCompOffDetailsState approveButtonState(ButtonState? approveButtonState) =>
      this(approveButtonState: approveButtonState);

  @override
  RMCompOffDetailsState rejectButtonState(ButtonState? rejectButtonState) =>
      this(rejectButtonState: rejectButtonState);

  @override
  RMCompOffDetailsState compOff(CompOff? compOff) => this(compOff: compOff);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RMCompOffDetailsState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RMCompOffDetailsState(...).copyWith(id: 12, name: "My name")
  /// ````
  RMCompOffDetailsState call({
    Object? uiState = const $CopyWithPlaceholder(),
    Object? approveButtonState = const $CopyWithPlaceholder(),
    Object? rejectButtonState = const $CopyWithPlaceholder(),
    Object? compOff = const $CopyWithPlaceholder(),
  }) {
    return RMCompOffDetailsState(
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
      compOff: compOff == const $CopyWithPlaceholder()
          ? _value.compOff
          // ignore: cast_nullable_to_non_nullable
          : compOff as CompOff?,
    );
  }
}

extension $RMCompOffDetailsStateCopyWith on RMCompOffDetailsState {
  /// Returns a callable class that can be used as follows: `instanceOfRMCompOffDetailsState.copyWith(...)` or like so:`instanceOfRMCompOffDetailsState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RMCompOffDetailsStateCWProxy get copyWith =>
      _$RMCompOffDetailsStateCWProxyImpl(this);
}
