// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comp_off_listing_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CompOffListingStateCWProxy {
  CompOffListingState uiState(UIState? uiState);

  CompOffListingState pendingList(List<CompOff>? pendingList);

  CompOffListingState approvedList(List<CompOff>? approvedList);

  CompOffListingState rejectedList(List<CompOff>? rejectedList);

  CompOffListingState cancelledList(List<CompOff>? cancelledList);

  CompOffListingState isLoading(bool? isLoading);

  CompOffListingState currentTabIndex(int? currentTabIndex);

  CompOffListingState selectedBillingCycle(BillingCycle? selectedBillingCycle);

  CompOffListingState isCompOffBalanceLoading(bool? isCompOffBalanceLoading);

  CompOffListingState compOffBalance(double? compOffBalance);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CompOffListingState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CompOffListingState(...).copyWith(id: 12, name: "My name")
  /// ````
  CompOffListingState call({
    UIState? uiState,
    List<CompOff>? pendingList,
    List<CompOff>? approvedList,
    List<CompOff>? rejectedList,
    List<CompOff>? cancelledList,
    bool? isLoading,
    int? currentTabIndex,
    BillingCycle? selectedBillingCycle,
    bool? isCompOffBalanceLoading,
    double? compOffBalance,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCompOffListingState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCompOffListingState.copyWith.fieldName(...)`
class _$CompOffListingStateCWProxyImpl implements _$CompOffListingStateCWProxy {
  const _$CompOffListingStateCWProxyImpl(this._value);

  final CompOffListingState _value;

  @override
  CompOffListingState uiState(UIState? uiState) => this(uiState: uiState);

  @override
  CompOffListingState pendingList(List<CompOff>? pendingList) =>
      this(pendingList: pendingList);

  @override
  CompOffListingState approvedList(List<CompOff>? approvedList) =>
      this(approvedList: approvedList);

  @override
  CompOffListingState rejectedList(List<CompOff>? rejectedList) =>
      this(rejectedList: rejectedList);

  @override
  CompOffListingState cancelledList(List<CompOff>? cancelledList) =>
      this(cancelledList: cancelledList);

  @override
  CompOffListingState isLoading(bool? isLoading) => this(isLoading: isLoading);

  @override
  CompOffListingState currentTabIndex(int? currentTabIndex) =>
      this(currentTabIndex: currentTabIndex);

  @override
  CompOffListingState selectedBillingCycle(
          BillingCycle? selectedBillingCycle) =>
      this(selectedBillingCycle: selectedBillingCycle);

  @override
  CompOffListingState isCompOffBalanceLoading(bool? isCompOffBalanceLoading) =>
      this(isCompOffBalanceLoading: isCompOffBalanceLoading);

  @override
  CompOffListingState compOffBalance(double? compOffBalance) =>
      this(compOffBalance: compOffBalance);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CompOffListingState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CompOffListingState(...).copyWith(id: 12, name: "My name")
  /// ````
  CompOffListingState call({
    Object? uiState = const $CopyWithPlaceholder(),
    Object? pendingList = const $CopyWithPlaceholder(),
    Object? approvedList = const $CopyWithPlaceholder(),
    Object? rejectedList = const $CopyWithPlaceholder(),
    Object? cancelledList = const $CopyWithPlaceholder(),
    Object? isLoading = const $CopyWithPlaceholder(),
    Object? currentTabIndex = const $CopyWithPlaceholder(),
    Object? selectedBillingCycle = const $CopyWithPlaceholder(),
    Object? isCompOffBalanceLoading = const $CopyWithPlaceholder(),
    Object? compOffBalance = const $CopyWithPlaceholder(),
  }) {
    return CompOffListingState(
      uiState: uiState == const $CopyWithPlaceholder()
          ? _value.uiState
          // ignore: cast_nullable_to_non_nullable
          : uiState as UIState?,
      pendingList: pendingList == const $CopyWithPlaceholder()
          ? _value.pendingList
          // ignore: cast_nullable_to_non_nullable
          : pendingList as List<CompOff>?,
      approvedList: approvedList == const $CopyWithPlaceholder()
          ? _value.approvedList
          // ignore: cast_nullable_to_non_nullable
          : approvedList as List<CompOff>?,
      rejectedList: rejectedList == const $CopyWithPlaceholder()
          ? _value.rejectedList
          // ignore: cast_nullable_to_non_nullable
          : rejectedList as List<CompOff>?,
      cancelledList: cancelledList == const $CopyWithPlaceholder()
          ? _value.cancelledList
          // ignore: cast_nullable_to_non_nullable
          : cancelledList as List<CompOff>?,
      isLoading: isLoading == const $CopyWithPlaceholder()
          ? _value.isLoading
          // ignore: cast_nullable_to_non_nullable
          : isLoading as bool?,
      currentTabIndex: currentTabIndex == const $CopyWithPlaceholder()
          ? _value.currentTabIndex
          // ignore: cast_nullable_to_non_nullable
          : currentTabIndex as int?,
      selectedBillingCycle: selectedBillingCycle == const $CopyWithPlaceholder()
          ? _value.selectedBillingCycle
          // ignore: cast_nullable_to_non_nullable
          : selectedBillingCycle as BillingCycle?,
      isCompOffBalanceLoading:
          isCompOffBalanceLoading == const $CopyWithPlaceholder()
              ? _value.isCompOffBalanceLoading
              // ignore: cast_nullable_to_non_nullable
              : isCompOffBalanceLoading as bool?,
      compOffBalance: compOffBalance == const $CopyWithPlaceholder()
          ? _value.compOffBalance
          // ignore: cast_nullable_to_non_nullable
          : compOffBalance as double?,
    );
  }
}

extension $CompOffListingStateCopyWith on CompOffListingState {
  /// Returns a callable class that can be used as follows: `instanceOfCompOffListingState.copyWith(...)` or like so:`instanceOfCompOffListingState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CompOffListingStateCWProxy get copyWith =>
      _$CompOffListingStateCWProxyImpl(this);
}
