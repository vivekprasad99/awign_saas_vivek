// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leaves_listing_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$LeavesListingStateCWProxy {
  LeavesListingState uiState(UIState? uiState);

  LeavesListingState buttonState(ButtonState? buttonState);

  LeavesListingState leaves(List<Leave>? leaves);

  LeavesListingState isSearchLeavesLoading(bool? isSearchLeavesLoading);

  LeavesListingState currentTabIndex(int? currentTabIndex);

  LeavesListingState selectedBillingCycle(BillingCycle? selectedBillingCycle);

  LeavesListingState isLeaveBalanceLoading(bool? isLeaveBalanceLoading);

  LeavesListingState leaveBalanceResponse(
      LeaveBalanceResponse? leaveBalanceResponse);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `LeavesListingState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// LeavesListingState(...).copyWith(id: 12, name: "My name")
  /// ````
  LeavesListingState call({
    UIState? uiState,
    ButtonState? buttonState,
    List<Leave>? leaves,
    bool? isSearchLeavesLoading,
    int? currentTabIndex,
    BillingCycle? selectedBillingCycle,
    bool? isLeaveBalanceLoading,
    LeaveBalanceResponse? leaveBalanceResponse,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfLeavesListingState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfLeavesListingState.copyWith.fieldName(...)`
class _$LeavesListingStateCWProxyImpl implements _$LeavesListingStateCWProxy {
  const _$LeavesListingStateCWProxyImpl(this._value);

  final LeavesListingState _value;

  @override
  LeavesListingState uiState(UIState? uiState) => this(uiState: uiState);

  @override
  LeavesListingState buttonState(ButtonState? buttonState) =>
      this(buttonState: buttonState);

  @override
  LeavesListingState leaves(List<Leave>? leaves) => this(leaves: leaves);

  @override
  LeavesListingState isSearchLeavesLoading(bool? isSearchLeavesLoading) =>
      this(isSearchLeavesLoading: isSearchLeavesLoading);

  @override
  LeavesListingState currentTabIndex(int? currentTabIndex) =>
      this(currentTabIndex: currentTabIndex);

  @override
  LeavesListingState selectedBillingCycle(BillingCycle? selectedBillingCycle) =>
      this(selectedBillingCycle: selectedBillingCycle);

  @override
  LeavesListingState isLeaveBalanceLoading(bool? isLeaveBalanceLoading) =>
      this(isLeaveBalanceLoading: isLeaveBalanceLoading);

  @override
  LeavesListingState leaveBalanceResponse(
          LeaveBalanceResponse? leaveBalanceResponse) =>
      this(leaveBalanceResponse: leaveBalanceResponse);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `LeavesListingState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// LeavesListingState(...).copyWith(id: 12, name: "My name")
  /// ````
  LeavesListingState call({
    Object? uiState = const $CopyWithPlaceholder(),
    Object? buttonState = const $CopyWithPlaceholder(),
    Object? leaves = const $CopyWithPlaceholder(),
    Object? isSearchLeavesLoading = const $CopyWithPlaceholder(),
    Object? currentTabIndex = const $CopyWithPlaceholder(),
    Object? selectedBillingCycle = const $CopyWithPlaceholder(),
    Object? isLeaveBalanceLoading = const $CopyWithPlaceholder(),
    Object? leaveBalanceResponse = const $CopyWithPlaceholder(),
  }) {
    return LeavesListingState(
      uiState: uiState == const $CopyWithPlaceholder()
          ? _value.uiState
          // ignore: cast_nullable_to_non_nullable
          : uiState as UIState?,
      buttonState: buttonState == const $CopyWithPlaceholder()
          ? _value.buttonState
          // ignore: cast_nullable_to_non_nullable
          : buttonState as ButtonState?,
      leaves: leaves == const $CopyWithPlaceholder()
          ? _value.leaves
          // ignore: cast_nullable_to_non_nullable
          : leaves as List<Leave>?,
      isSearchLeavesLoading:
          isSearchLeavesLoading == const $CopyWithPlaceholder()
              ? _value.isSearchLeavesLoading
              // ignore: cast_nullable_to_non_nullable
              : isSearchLeavesLoading as bool?,
      currentTabIndex: currentTabIndex == const $CopyWithPlaceholder()
          ? _value.currentTabIndex
          // ignore: cast_nullable_to_non_nullable
          : currentTabIndex as int?,
      selectedBillingCycle: selectedBillingCycle == const $CopyWithPlaceholder()
          ? _value.selectedBillingCycle
          // ignore: cast_nullable_to_non_nullable
          : selectedBillingCycle as BillingCycle?,
      isLeaveBalanceLoading:
          isLeaveBalanceLoading == const $CopyWithPlaceholder()
              ? _value.isLeaveBalanceLoading
              // ignore: cast_nullable_to_non_nullable
              : isLeaveBalanceLoading as bool?,
      leaveBalanceResponse: leaveBalanceResponse == const $CopyWithPlaceholder()
          ? _value.leaveBalanceResponse
          // ignore: cast_nullable_to_non_nullable
          : leaveBalanceResponse as LeaveBalanceResponse?,
    );
  }
}

extension $LeavesListingStateCopyWith on LeavesListingState {
  /// Returns a callable class that can be used as follows: `instanceOfLeavesListingState.copyWith(...)` or like so:`instanceOfLeavesListingState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$LeavesListingStateCWProxy get copyWith =>
      _$LeavesListingStateCWProxyImpl(this);
}
