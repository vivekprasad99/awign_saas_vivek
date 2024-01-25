// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rm_leave_listing_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$RMLeaveListingStateCWProxy {
  RMLeaveListingState uiState(UIState? uiState);

  RMLeaveListingState buttonState(ButtonState? buttonState);

  RMLeaveListingState leaves(List<Leave>? leaves);

  RMLeaveListingState isSearchLeavesLoading(bool? isSearchLeavesLoading);

  RMLeaveListingState currentTabIndex(int? currentTabIndex);

  RMLeaveListingState selectedBillingCycle(BillingCycle? selectedBillingCycle);

  RMLeaveListingState isLeaveBalanceLoading(bool? isLeaveBalanceLoading);

  RMLeaveListingState leaveBalanceResponse(
      LeaveBalanceResponse? leaveBalanceResponse);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RMLeaveListingState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RMLeaveListingState(...).copyWith(id: 12, name: "My name")
  /// ````
  RMLeaveListingState call({
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

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfRMLeaveListingState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfRMLeaveListingState.copyWith.fieldName(...)`
class _$RMLeaveListingStateCWProxyImpl implements _$RMLeaveListingStateCWProxy {
  const _$RMLeaveListingStateCWProxyImpl(this._value);

  final RMLeaveListingState _value;

  @override
  RMLeaveListingState uiState(UIState? uiState) => this(uiState: uiState);

  @override
  RMLeaveListingState buttonState(ButtonState? buttonState) =>
      this(buttonState: buttonState);

  @override
  RMLeaveListingState leaves(List<Leave>? leaves) => this(leaves: leaves);

  @override
  RMLeaveListingState isSearchLeavesLoading(bool? isSearchLeavesLoading) =>
      this(isSearchLeavesLoading: isSearchLeavesLoading);

  @override
  RMLeaveListingState currentTabIndex(int? currentTabIndex) =>
      this(currentTabIndex: currentTabIndex);

  @override
  RMLeaveListingState selectedBillingCycle(
          BillingCycle? selectedBillingCycle) =>
      this(selectedBillingCycle: selectedBillingCycle);

  @override
  RMLeaveListingState isLeaveBalanceLoading(bool? isLeaveBalanceLoading) =>
      this(isLeaveBalanceLoading: isLeaveBalanceLoading);

  @override
  RMLeaveListingState leaveBalanceResponse(
          LeaveBalanceResponse? leaveBalanceResponse) =>
      this(leaveBalanceResponse: leaveBalanceResponse);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RMLeaveListingState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RMLeaveListingState(...).copyWith(id: 12, name: "My name")
  /// ````
  RMLeaveListingState call({
    Object? uiState = const $CopyWithPlaceholder(),
    Object? buttonState = const $CopyWithPlaceholder(),
    Object? leaves = const $CopyWithPlaceholder(),
    Object? isSearchLeavesLoading = const $CopyWithPlaceholder(),
    Object? currentTabIndex = const $CopyWithPlaceholder(),
    Object? selectedBillingCycle = const $CopyWithPlaceholder(),
    Object? isLeaveBalanceLoading = const $CopyWithPlaceholder(),
    Object? leaveBalanceResponse = const $CopyWithPlaceholder(),
  }) {
    return RMLeaveListingState(
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

extension $RMLeaveListingStateCopyWith on RMLeaveListingState {
  /// Returns a callable class that can be used as follows: `instanceOfRMLeaveListingState.copyWith(...)` or like so:`instanceOfRMLeaveListingState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RMLeaveListingStateCWProxy get copyWith =>
      _$RMLeaveListingStateCWProxyImpl(this);
}
