// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rm_reimbursement_detail_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$RMReimbursementDetailStateCWProxy {
  RMReimbursementDetailState uiState(UIState? uiState);

  RMReimbursementDetailState buttonState(ButtonState? buttonState);

  RMReimbursementDetailState reimbursementDetailResponse(
      ReimbursementDetailResponse? reimbursementDetailResponse);

  RMReimbursementDetailState isLoading(bool? isLoading);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RMReimbursementDetailState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RMReimbursementDetailState(...).copyWith(id: 12, name: "My name")
  /// ````
  RMReimbursementDetailState call({
    UIState? uiState,
    ButtonState? buttonState,
    ReimbursementDetailResponse? reimbursementDetailResponse,
    bool? isLoading,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfRMReimbursementDetailState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfRMReimbursementDetailState.copyWith.fieldName(...)`
class _$RMReimbursementDetailStateCWProxyImpl
    implements _$RMReimbursementDetailStateCWProxy {
  const _$RMReimbursementDetailStateCWProxyImpl(this._value);

  final RMReimbursementDetailState _value;

  @override
  RMReimbursementDetailState uiState(UIState? uiState) =>
      this(uiState: uiState);

  @override
  RMReimbursementDetailState buttonState(ButtonState? buttonState) =>
      this(buttonState: buttonState);

  @override
  RMReimbursementDetailState reimbursementDetailResponse(
          ReimbursementDetailResponse? reimbursementDetailResponse) =>
      this(reimbursementDetailResponse: reimbursementDetailResponse);

  @override
  RMReimbursementDetailState isLoading(bool? isLoading) =>
      this(isLoading: isLoading);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RMReimbursementDetailState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RMReimbursementDetailState(...).copyWith(id: 12, name: "My name")
  /// ````
  RMReimbursementDetailState call({
    Object? uiState = const $CopyWithPlaceholder(),
    Object? buttonState = const $CopyWithPlaceholder(),
    Object? reimbursementDetailResponse = const $CopyWithPlaceholder(),
    Object? isLoading = const $CopyWithPlaceholder(),
  }) {
    return RMReimbursementDetailState(
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

extension $RMReimbursementDetailStateCopyWith on RMReimbursementDetailState {
  /// Returns a callable class that can be used as follows: `instanceOfRMReimbursementDetailState.copyWith(...)` or like so:`instanceOfRMReimbursementDetailState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RMReimbursementDetailStateCWProxy get copyWith =>
      _$RMReimbursementDetailStateCWProxyImpl(this);
}
