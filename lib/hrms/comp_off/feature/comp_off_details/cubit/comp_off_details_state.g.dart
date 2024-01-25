// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comp_off_details_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CompOffDetailsStateCWProxy {
  CompOffDetailsState uiState(UIState? uiState);

  CompOffDetailsState buttonState(ButtonState? buttonState);

  CompOffDetailsState compOff(CompOff? compOff);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CompOffDetailsState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CompOffDetailsState(...).copyWith(id: 12, name: "My name")
  /// ````
  CompOffDetailsState call({
    UIState? uiState,
    ButtonState? buttonState,
    CompOff? compOff,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCompOffDetailsState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCompOffDetailsState.copyWith.fieldName(...)`
class _$CompOffDetailsStateCWProxyImpl implements _$CompOffDetailsStateCWProxy {
  const _$CompOffDetailsStateCWProxyImpl(this._value);

  final CompOffDetailsState _value;

  @override
  CompOffDetailsState uiState(UIState? uiState) => this(uiState: uiState);

  @override
  CompOffDetailsState buttonState(ButtonState? buttonState) =>
      this(buttonState: buttonState);

  @override
  CompOffDetailsState compOff(CompOff? compOff) => this(compOff: compOff);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CompOffDetailsState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CompOffDetailsState(...).copyWith(id: 12, name: "My name")
  /// ````
  CompOffDetailsState call({
    Object? uiState = const $CopyWithPlaceholder(),
    Object? buttonState = const $CopyWithPlaceholder(),
    Object? compOff = const $CopyWithPlaceholder(),
  }) {
    return CompOffDetailsState(
      uiState: uiState == const $CopyWithPlaceholder()
          ? _value.uiState
          // ignore: cast_nullable_to_non_nullable
          : uiState as UIState?,
      buttonState: buttonState == const $CopyWithPlaceholder()
          ? _value.buttonState
          // ignore: cast_nullable_to_non_nullable
          : buttonState as ButtonState?,
      compOff: compOff == const $CopyWithPlaceholder()
          ? _value.compOff
          // ignore: cast_nullable_to_non_nullable
          : compOff as CompOff?,
    );
  }
}

extension $CompOffDetailsStateCopyWith on CompOffDetailsState {
  /// Returns a callable class that can be used as follows: `instanceOfCompOffDetailsState.copyWith(...)` or like so:`instanceOfCompOffDetailsState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CompOffDetailsStateCWProxy get copyWith =>
      _$CompOffDetailsStateCWProxyImpl(this);
}
