// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'regularisation_alert_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$RegularisationAlertStateCWProxy {
  RegularisationAlertState uiState(UIState? uiState);

  RegularisationAlertState isLoading(bool? isLoading);

  RegularisationAlertState pendingRegularisationCount(
      int? pendingRegularisationCount);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RegularisationAlertState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RegularisationAlertState(...).copyWith(id: 12, name: "My name")
  /// ````
  RegularisationAlertState call({
    UIState? uiState,
    bool? isLoading,
    int? pendingRegularisationCount,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfRegularisationAlertState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfRegularisationAlertState.copyWith.fieldName(...)`
class _$RegularisationAlertStateCWProxyImpl
    implements _$RegularisationAlertStateCWProxy {
  const _$RegularisationAlertStateCWProxyImpl(this._value);

  final RegularisationAlertState _value;

  @override
  RegularisationAlertState uiState(UIState? uiState) => this(uiState: uiState);

  @override
  RegularisationAlertState isLoading(bool? isLoading) =>
      this(isLoading: isLoading);

  @override
  RegularisationAlertState pendingRegularisationCount(
          int? pendingRegularisationCount) =>
      this(pendingRegularisationCount: pendingRegularisationCount);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RegularisationAlertState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RegularisationAlertState(...).copyWith(id: 12, name: "My name")
  /// ````
  RegularisationAlertState call({
    Object? uiState = const $CopyWithPlaceholder(),
    Object? isLoading = const $CopyWithPlaceholder(),
    Object? pendingRegularisationCount = const $CopyWithPlaceholder(),
  }) {
    return RegularisationAlertState(
      uiState: uiState == const $CopyWithPlaceholder()
          ? _value.uiState
          // ignore: cast_nullable_to_non_nullable
          : uiState as UIState?,
      isLoading: isLoading == const $CopyWithPlaceholder()
          ? _value.isLoading
          // ignore: cast_nullable_to_non_nullable
          : isLoading as bool?,
      pendingRegularisationCount:
          pendingRegularisationCount == const $CopyWithPlaceholder()
              ? _value.pendingRegularisationCount
              // ignore: cast_nullable_to_non_nullable
              : pendingRegularisationCount as int?,
    );
  }
}

extension $RegularisationAlertStateCopyWith on RegularisationAlertState {
  /// Returns a callable class that can be used as follows: `instanceOfRegularisationAlertState.copyWith(...)` or like so:`instanceOfRegularisationAlertState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RegularisationAlertStateCWProxy get copyWith =>
      _$RegularisationAlertStateCWProxyImpl(this);
}
