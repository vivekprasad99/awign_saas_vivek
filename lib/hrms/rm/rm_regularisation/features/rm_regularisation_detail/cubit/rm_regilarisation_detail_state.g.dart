// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rm_regilarisation_detail_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$RmRegilarisationDetailStateCWProxy {
  RmRegilarisationDetailState uiState(UIState? uiState);

  RmRegilarisationDetailState isLoading(bool? isLoading);

  RmRegilarisationDetailState rmRegularizeSearchResponse(
      RmRegularizeSearchResponse? rmRegularizeSearchResponse);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RmRegilarisationDetailState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RmRegilarisationDetailState(...).copyWith(id: 12, name: "My name")
  /// ````
  RmRegilarisationDetailState call({
    UIState? uiState,
    bool? isLoading,
    RmRegularizeSearchResponse? rmRegularizeSearchResponse,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfRmRegilarisationDetailState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfRmRegilarisationDetailState.copyWith.fieldName(...)`
class _$RmRegilarisationDetailStateCWProxyImpl
    implements _$RmRegilarisationDetailStateCWProxy {
  const _$RmRegilarisationDetailStateCWProxyImpl(this._value);

  final RmRegilarisationDetailState _value;

  @override
  RmRegilarisationDetailState uiState(UIState? uiState) =>
      this(uiState: uiState);

  @override
  RmRegilarisationDetailState isLoading(bool? isLoading) =>
      this(isLoading: isLoading);

  @override
  RmRegilarisationDetailState rmRegularizeSearchResponse(
          RmRegularizeSearchResponse? rmRegularizeSearchResponse) =>
      this(rmRegularizeSearchResponse: rmRegularizeSearchResponse);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RmRegilarisationDetailState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RmRegilarisationDetailState(...).copyWith(id: 12, name: "My name")
  /// ````
  RmRegilarisationDetailState call({
    Object? uiState = const $CopyWithPlaceholder(),
    Object? isLoading = const $CopyWithPlaceholder(),
    Object? rmRegularizeSearchResponse = const $CopyWithPlaceholder(),
  }) {
    return RmRegilarisationDetailState(
      uiState: uiState == const $CopyWithPlaceholder()
          ? _value.uiState
          // ignore: cast_nullable_to_non_nullable
          : uiState as UIState?,
      isLoading: isLoading == const $CopyWithPlaceholder()
          ? _value.isLoading
          // ignore: cast_nullable_to_non_nullable
          : isLoading as bool?,
      rmRegularizeSearchResponse:
          rmRegularizeSearchResponse == const $CopyWithPlaceholder()
              ? _value.rmRegularizeSearchResponse
              // ignore: cast_nullable_to_non_nullable
              : rmRegularizeSearchResponse as RmRegularizeSearchResponse?,
    );
  }
}

extension $RmRegilarisationDetailStateCopyWith on RmRegilarisationDetailState {
  /// Returns a callable class that can be used as follows: `instanceOfRmRegilarisationDetailState.copyWith(...)` or like so:`instanceOfRmRegilarisationDetailState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RmRegilarisationDetailStateCWProxy get copyWith =>
      _$RmRegilarisationDetailStateCWProxyImpl(this);
}
