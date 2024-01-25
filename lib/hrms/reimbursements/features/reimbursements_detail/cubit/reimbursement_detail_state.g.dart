// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reimbursement_detail_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ReimbursementDetailStateCWProxy {
  ReimbursementDetailState uiState(UIState? uiState);

  ReimbursementDetailState buttonState(ButtonState? buttonState);

  ReimbursementDetailState reimbursementDetailResponse(
      ReimbursementDetailResponse? reimbursementDetailResponse);

  ReimbursementDetailState isLoading(bool? isLoading);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ReimbursementDetailState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ReimbursementDetailState(...).copyWith(id: 12, name: "My name")
  /// ````
  ReimbursementDetailState call({
    UIState? uiState,
    ButtonState? buttonState,
    ReimbursementDetailResponse? reimbursementDetailResponse,
    bool? isLoading,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfReimbursementDetailState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfReimbursementDetailState.copyWith.fieldName(...)`
class _$ReimbursementDetailStateCWProxyImpl
    implements _$ReimbursementDetailStateCWProxy {
  const _$ReimbursementDetailStateCWProxyImpl(this._value);

  final ReimbursementDetailState _value;

  @override
  ReimbursementDetailState uiState(UIState? uiState) => this(uiState: uiState);

  @override
  ReimbursementDetailState buttonState(ButtonState? buttonState) =>
      this(buttonState: buttonState);

  @override
  ReimbursementDetailState reimbursementDetailResponse(
          ReimbursementDetailResponse? reimbursementDetailResponse) =>
      this(reimbursementDetailResponse: reimbursementDetailResponse);

  @override
  ReimbursementDetailState isLoading(bool? isLoading) =>
      this(isLoading: isLoading);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ReimbursementDetailState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ReimbursementDetailState(...).copyWith(id: 12, name: "My name")
  /// ````
  ReimbursementDetailState call({
    Object? uiState = const $CopyWithPlaceholder(),
    Object? buttonState = const $CopyWithPlaceholder(),
    Object? reimbursementDetailResponse = const $CopyWithPlaceholder(),
    Object? isLoading = const $CopyWithPlaceholder(),
  }) {
    return ReimbursementDetailState(
      uiState: uiState == const $CopyWithPlaceholder()
          ? _value.uiState
          // ignore: cast_nullable_to_non_nullable
          : uiState as UIState?,
      buttonState: buttonState == const $CopyWithPlaceholder()
          ? _value.buttonState
          // ignore: cast_nullable_to_non_nullable
          : buttonState as ButtonState?,
      reimbursementDetailResponse:
          reimbursementDetailResponse == const $CopyWithPlaceholder()
              ? _value.reimbursementDetailResponse
              // ignore: cast_nullable_to_non_nullable
              : reimbursementDetailResponse as ReimbursementDetailResponse?,
      isLoading: isLoading == const $CopyWithPlaceholder()
          ? _value.isLoading
          // ignore: cast_nullable_to_non_nullable
          : isLoading as bool?,
    );
  }
}

extension $ReimbursementDetailStateCopyWith on ReimbursementDetailState {
  /// Returns a callable class that can be used as follows: `instanceOfReimbursementDetailState.copyWith(...)` or like so:`instanceOfReimbursementDetailState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ReimbursementDetailStateCWProxy get copyWith =>
      _$ReimbursementDetailStateCWProxyImpl(this);
}
