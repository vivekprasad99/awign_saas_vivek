// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rm_comp_off_listing_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$RMCompOffListingStateCWProxy {
  RMCompOffListingState uiState(UIState? uiState);

  RMCompOffListingState selectedBillingCycle(
      BillingCycle? selectedBillingCycle);

  RMCompOffListingState isLoading(bool? isLoading);

  RMCompOffListingState currentTabIndex(int? currentTabIndex);

  RMCompOffListingState pendingList(List<CompOff>? pendingList);

  RMCompOffListingState approvedList(List<CompOff>? approvedList);

  RMCompOffListingState rejectedList(List<CompOff>? rejectedList);

  RMCompOffListingState allList(List<CompOff>? allList);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RMCompOffListingState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RMCompOffListingState(...).copyWith(id: 12, name: "My name")
  /// ````
  RMCompOffListingState call({
    UIState? uiState,
    BillingCycle? selectedBillingCycle,
    bool? isLoading,
    int? currentTabIndex,
    List<CompOff>? pendingList,
    List<CompOff>? approvedList,
    List<CompOff>? rejectedList,
    List<CompOff>? allList,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfRMCompOffListingState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfRMCompOffListingState.copyWith.fieldName(...)`
class _$RMCompOffListingStateCWProxyImpl
    implements _$RMCompOffListingStateCWProxy {
  const _$RMCompOffListingStateCWProxyImpl(this._value);

  final RMCompOffListingState _value;

  @override
  RMCompOffListingState uiState(UIState? uiState) => this(uiState: uiState);

  @override
  RMCompOffListingState selectedBillingCycle(
          BillingCycle? selectedBillingCycle) =>
      this(selectedBillingCycle: selectedBillingCycle);

  @override
  RMCompOffListingState isLoading(bool? isLoading) =>
      this(isLoading: isLoading);

  @override
  RMCompOffListingState currentTabIndex(int? currentTabIndex) =>
      this(currentTabIndex: currentTabIndex);

  @override
  RMCompOffListingState pendingList(List<CompOff>? pendingList) =>
      this(pendingList: pendingList);

  @override
  RMCompOffListingState approvedList(List<CompOff>? approvedList) =>
      this(approvedList: approvedList);

  @override
  RMCompOffListingState rejectedList(List<CompOff>? rejectedList) =>
      this(rejectedList: rejectedList);

  @override
  RMCompOffListingState allList(List<CompOff>? allList) =>
      this(allList: allList);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RMCompOffListingState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RMCompOffListingState(...).copyWith(id: 12, name: "My name")
  /// ````
  RMCompOffListingState call({
    Object? uiState = const $CopyWithPlaceholder(),
    Object? selectedBillingCycle = const $CopyWithPlaceholder(),
    Object? isLoading = const $CopyWithPlaceholder(),
    Object? currentTabIndex = const $CopyWithPlaceholder(),
    Object? pendingList = const $CopyWithPlaceholder(),
    Object? approvedList = const $CopyWithPlaceholder(),
    Object? rejectedList = const $CopyWithPlaceholder(),
    Object? allList = const $CopyWithPlaceholder(),
  }) {
    return RMCompOffListingState(
      uiState: uiState == const $CopyWithPlaceholder()
          ? _value.uiState
          // ignore: cast_nullable_to_non_nullable
          : uiState as UIState?,
      selectedBillingCycle: selectedBillingCycle == const $CopyWithPlaceholder()
          ? _value.selectedBillingCycle
          // ignore: cast_nullable_to_non_nullable
          : selectedBillingCycle as BillingCycle?,
      isLoading: isLoading == const $CopyWithPlaceholder()
          ? _value.isLoading
          // ignore: cast_nullable_to_non_nullable
          : isLoading as bool?,
      currentTabIndex: currentTabIndex == const $CopyWithPlaceholder()
          ? _value.currentTabIndex
          // ignore: cast_nullable_to_non_nullable
          : currentTabIndex as int?,
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
      allList: allList == const $CopyWithPlaceholder()
          ? _value.allList
          // ignore: cast_nullable_to_non_nullable
          : allList as List<CompOff>?,
    );
  }
}

extension $RMCompOffListingStateCopyWith on RMCompOffListingState {
  /// Returns a callable class that can be used as follows: `instanceOfRMCompOffListingState.copyWith(...)` or like so:`instanceOfRMCompOffListingState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RMCompOffListingStateCWProxy get copyWith =>
      _$RMCompOffListingStateCWProxyImpl(this);
}
