// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'regularisation_details_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$RegularisationDetailsStateCWProxy {
  RegularisationDetailsState uiState(UIState? uiState);

  RegularisationDetailsState buttonState(ButtonState? buttonState);

  RegularisationDetailsState regularisation(Regularisation? regularisation);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RegularisationDetailsState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RegularisationDetailsState(...).copyWith(id: 12, name: "My name")
  /// ````
  RegularisationDetailsState call({
    UIState? uiState,
    ButtonState? buttonState,
    Regularisation? regularisation,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfRegularisationDetailsState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfRegularisationDetailsState.copyWith.fieldName(...)`
class _$RegularisationDetailsStateCWProxyImpl
    implements _$RegularisationDetailsStateCWProxy {
  const _$RegularisationDetailsStateCWProxyImpl(this._value);

  final RegularisationDetailsState _value;

  @override
  RegularisationDetailsState uiState(UIState? uiState) =>
      this(uiState: uiState);

  @override
  RegularisationDetailsState buttonState(ButtonState? buttonState) =>
      this(buttonState: buttonState);

  @override
  RegularisationDetailsState regularisation(Regularisation? regularisation) =>
      this(regularisation: regularisation);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RegularisationDetailsState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RegularisationDetailsState(...).copyWith(id: 12, name: "My name")
  /// ````
  RegularisationDetailsState call({
    Object? uiState = const $CopyWithPlaceholder(),
    Object? buttonState = const $CopyWithPlaceholder(),
    Object? regularisation = const $CopyWithPlaceholder(),
  }) {
    return RegularisationDetailsState(
      uiState: uiState == const $CopyWithPlaceholder()
          ? _value.uiState
          // ignore: cast_nullable_to_non_nullable
          : uiState as UIState?,
      buttonState: buttonState == const $CopyWithPlaceholder()
          ? _value.buttonState
          // ignore: cast_nullable_to_non_nullable
          : buttonState as ButtonState?,
      regularisation: regularisation == const $CopyWithPlaceholder()
          ? _value.regularisation
          // ignore: cast_nullable_to_non_nullable
          : regularisation as Regularisation?,
    );
  }
}

extension $RegularisationDetailsStateCopyWith on RegularisationDetailsState {
  /// Returns a callable class that can be used as follows: `instanceOfRegularisationDetailsState.copyWith(...)` or like so:`instanceOfRegularisationDetailsState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RegularisationDetailsStateCWProxy get copyWith =>
      _$RegularisationDetailsStateCWProxyImpl(this);
}
