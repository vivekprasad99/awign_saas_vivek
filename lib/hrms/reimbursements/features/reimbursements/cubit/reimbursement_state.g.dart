// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reimbursement_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ReimbursementStateCWProxy {
  ReimbursementState uiState(UIState? uiState);

  ReimbursementState buttonState(ButtonState? buttonState);

  ReimbursementState reimbursementResponse(
      ReimbursementResponse? reimbursementResponse);

  ReimbursementState isSearchReimbursementLoading(
      bool? isSearchReimbursementLoading);

  ReimbursementState selectedBillingCycle(BillingCycle? selectedBillingCycle);

  ReimbursementState currentTabIndex(int? currentTabIndex);

  ReimbursementState pendingList(List<Reimbursement>? pendingList);

  ReimbursementState approvedList(List<Reimbursement>? approvedList);

  ReimbursementState rejectedList(List<Reimbursement>? rejectedList);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ReimbursementState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ReimbursementState(...).copyWith(id: 12, name: "My name")
  /// ````
  ReimbursementState call({
    UIState? uiState,
    ButtonState? buttonState,
    ReimbursementResponse? reimbursementResponse,
    bool? isSearchReimbursementLoading,
    BillingCycle? selectedBillingCycle,
    int? currentTabIndex,
    List<Reimbursement>? pendingList,
    List<Reimbursement>? approvedList,
    List<Reimbursement>? rejectedList,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfReimbursementState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfReimbursementState.copyWith.fieldName(...)`
class _$ReimbursementStateCWProxyImpl implements _$ReimbursementStateCWProxy {
  const _$ReimbursementStateCWProxyImpl(this._value);

  final ReimbursementState _value;

  @override
  ReimbursementState uiState(UIState? uiState) => this(uiState: uiState);

  @override
  ReimbursementState buttonState(ButtonState? buttonState) =>
      this(buttonState: buttonState);

  @override
  ReimbursementState reimbursementResponse(
          ReimbursementResponse? reimbursementResponse) =>
      this(reimbursementResponse: reimbursementResponse);

  @override
  ReimbursementState isSearchReimbursementLoading(
          bool? isSearchReimbursementLoading) =>
      this(isSearchReimbursementLoading: isSearchReimbursementLoading);

  @override
  ReimbursementState selectedBillingCycle(BillingCycle? selectedBillingCycle) =>
      this(selectedBillingCycle: selectedBillingCycle);

  @override
  ReimbursementState currentTabIndex(int? currentTabIndex) =>
      this(currentTabIndex: currentTabIndex);

  @override
  ReimbursementState pendingList(List<Reimbursement>? pendingList) =>
      this(pendingList: pendingList);

  @override
  ReimbursementState approvedList(List<Reimbursement>? approvedList) =>
      this(approvedList: approvedList);

  @override
  ReimbursementState rejectedList(List<Reimbursement>? rejectedList) =>
      this(rejectedList: rejectedList);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ReimbursementState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ReimbursementState(...).copyWith(id: 12, name: "My name")
  /// ````
  ReimbursementState call({
    Object? uiState = const $CopyWithPlaceholder(),
    Object? buttonState = const $CopyWithPlaceholder(),
    Object? reimbursementResponse = const $CopyWithPlaceholder(),
    Object? isSearchReimbursementLoading = const $CopyWithPlaceholder(),
    Object? selectedBillingCycle = const $CopyWithPlaceholder(),
    Object? currentTabIndex = const $CopyWithPlaceholder(),
    Object? pendingList = const $CopyWithPlaceholder(),
    Object? approvedList = const $CopyWithPlaceholder(),
    Object? rejectedList = const $CopyWithPlaceholder(),
  }) {
    return ReimbursementState(
      uiState: uiState == const $CopyWithPlaceholder()
          ? _value.uiState
          // ignore: cast_nullable_to_non_nullable
          : uiState as UIState?,
      buttonState: buttonState == const $CopyWithPlaceholder()
          ? _value.buttonState
          // ignore: cast_nullable_to_non_nullable
          : buttonState as ButtonState?,
      reimbursementResponse:
          reimbursementResponse == const $CopyWithPlaceholder()
              ? _value.reimbursementResponse
              // ignore: cast_nullable_to_non_nullable
              : reimbursementResponse as ReimbursementResponse?,
      isSearchReimbursementLoading:
          isSearchReimbursementLoading == const $CopyWithPlaceholder()
              ? _value.isSearchReimbursementLoading
              // ignore: cast_nullable_to_non_nullable
              : isSearchReimbursementLoading as bool?,
      selectedBillingCycle: selectedBillingCycle == const $CopyWithPlaceholder()
          ? _value.selectedBillingCycle
          // ignore: cast_nullable_to_non_nullable
          : selectedBillingCycle as BillingCycle?,
      currentTabIndex: currentTabIndex == const $CopyWithPlaceholder()
          ? _value.currentTabIndex
          // ignore: cast_nullable_to_non_nullable
          : currentTabIndex as int?,
      pendingList: pendingList == const $CopyWithPlaceholder()
          ? _value.pendingList
          // ignore: cast_nullable_to_non_nullable
          : pendingList as List<Reimbursement>?,
      approvedList: approvedList == const $CopyWithPlaceholder()
          ? _value.approvedList
          // ignore: cast_nullable_to_non_nullable
          : approvedList as List<Reimbursement>?,
      rejectedList: rejectedList == const $CopyWithPlaceholder()
          ? _value.rejectedList
          // ignore: cast_nullable_to_non_nullable
          : rejectedList as List<Reimbursement>?,
    );
  }
}

extension $ReimbursementStateCopyWith on ReimbursementState {
  /// Returns a callable class that can be used as follows: `instanceOfReimbursementState.copyWith(...)` or like so:`instanceOfReimbursementState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ReimbursementStateCWProxy get copyWith =>
      _$ReimbursementStateCWProxyImpl(this);
}
