// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rm_regularisation_dashboard_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$RMRegularisationDashboardStateCWProxy {
  RMRegularisationDashboardState uiState(UIState? uiState);

  RMRegularisationDashboardState selectedBillingCycle(
      BillingCycle? selectedBillingCycle);

  RMRegularisationDashboardState isLoading(bool? isLoading);

  RMRegularisationDashboardState currentTabIndex(int? currentTabIndex);

  RMRegularisationDashboardState pendingList(List<Regularization>? pendingList);

  RMRegularisationDashboardState approvedList(
      List<Regularization>? approvedList);

  RMRegularisationDashboardState rejectedList(
      List<Regularization>? rejectedList);

  RMRegularisationDashboardState allList(List<Regularization>? allList);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RMRegularisationDashboardState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RMRegularisationDashboardState(...).copyWith(id: 12, name: "My name")
  /// ````
  RMRegularisationDashboardState call({
    UIState? uiState,
    BillingCycle? selectedBillingCycle,
    bool? isLoading,
    int? currentTabIndex,
    List<Regularization>? pendingList,
    List<Regularization>? approvedList,
    List<Regularization>? rejectedList,
    List<Regularization>? allList,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfRMRegularisationDashboardState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfRMRegularisationDashboardState.copyWith.fieldName(...)`
class _$RMRegularisationDashboardStateCWProxyImpl
    implements _$RMRegularisationDashboardStateCWProxy {
  const _$RMRegularisationDashboardStateCWProxyImpl(this._value);

  final RMRegularisationDashboardState _value;

  @override
  RMRegularisationDashboardState uiState(UIState? uiState) =>
      this(uiState: uiState);

  @override
  RMRegularisationDashboardState selectedBillingCycle(
          BillingCycle? selectedBillingCycle) =>
      this(selectedBillingCycle: selectedBillingCycle);

  @override
  RMRegularisationDashboardState isLoading(bool? isLoading) =>
      this(isLoading: isLoading);

  @override
  RMRegularisationDashboardState currentTabIndex(int? currentTabIndex) =>
      this(currentTabIndex: currentTabIndex);

  @override
  RMRegularisationDashboardState pendingList(
          List<Regularization>? pendingList) =>
      this(pendingList: pendingList);

  @override
  RMRegularisationDashboardState approvedList(
          List<Regularization>? approvedList) =>
      this(approvedList: approvedList);

  @override
  RMRegularisationDashboardState rejectedList(
          List<Regularization>? rejectedList) =>
      this(rejectedList: rejectedList);

  @override
  RMRegularisationDashboardState allList(List<Regularization>? allList) =>
      this(allList: allList);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RMRegularisationDashboardState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RMRegularisationDashboardState(...).copyWith(id: 12, name: "My name")
  /// ````
  RMRegularisationDashboardState call({
    Object? uiState = const $CopyWithPlaceholder(),
    Object? selectedBillingCycle = const $CopyWithPlaceholder(),
    Object? isLoading = const $CopyWithPlaceholder(),
    Object? currentTabIndex = const $CopyWithPlaceholder(),
    Object? pendingList = const $CopyWithPlaceholder(),
    Object? approvedList = const $CopyWithPlaceholder(),
    Object? rejectedList = const $CopyWithPlaceholder(),
    Object? allList = const $CopyWithPlaceholder(),
  }) {
    return RMRegularisationDashboardState(
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
          : pendingList as List<Regularization>?,
      approvedList: approvedList == const $CopyWithPlaceholder()
          ? _value.approvedList
          // ignore: cast_nullable_to_non_nullable
          : approvedList as List<Regularization>?,
      rejectedList: rejectedList == const $CopyWithPlaceholder()
          ? _value.rejectedList
          // ignore: cast_nullable_to_non_nullable
          : rejectedList as List<Regularization>?,
      allList: allList == const $CopyWithPlaceholder()
          ? _value.allList
          // ignore: cast_nullable_to_non_nullable
          : allList as List<Regularization>?,
    );
  }
}

extension $RMRegularisationDashboardStateCopyWith
    on RMRegularisationDashboardState {
  /// Returns a callable class that can be used as follows: `instanceOfRMRegularisationDashboardState.copyWith(...)` or like so:`instanceOfRMRegularisationDashboardState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RMRegularisationDashboardStateCWProxy get copyWith =>
      _$RMRegularisationDashboardStateCWProxyImpl(this);
}
