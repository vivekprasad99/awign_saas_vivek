// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'regularisation_dashboard_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$RegularisationDashboardStateCWProxy {
  RegularisationDashboardState uiState(UIState? uiState);

  RegularisationDashboardState selectedBillingCycle(
      BillingCycle? selectedBillingCycle);

  RegularisationDashboardState isLoading(bool? isLoading);

  RegularisationDashboardState currentTabIndex(int? currentTabIndex);

  RegularisationDashboardState regularisationList(
      List<Regularisation>? regularisationList);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RegularisationDashboardState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RegularisationDashboardState(...).copyWith(id: 12, name: "My name")
  /// ````
  RegularisationDashboardState call({
    UIState? uiState,
    BillingCycle? selectedBillingCycle,
    bool? isLoading,
    int? currentTabIndex,
    List<Regularisation>? regularisationList,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfRegularisationDashboardState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfRegularisationDashboardState.copyWith.fieldName(...)`
class _$RegularisationDashboardStateCWProxyImpl
    implements _$RegularisationDashboardStateCWProxy {
  const _$RegularisationDashboardStateCWProxyImpl(this._value);

  final RegularisationDashboardState _value;

  @override
  RegularisationDashboardState uiState(UIState? uiState) =>
      this(uiState: uiState);

  @override
  RegularisationDashboardState selectedBillingCycle(
          BillingCycle? selectedBillingCycle) =>
      this(selectedBillingCycle: selectedBillingCycle);

  @override
  RegularisationDashboardState isLoading(bool? isLoading) =>
      this(isLoading: isLoading);

  @override
  RegularisationDashboardState currentTabIndex(int? currentTabIndex) =>
      this(currentTabIndex: currentTabIndex);

  @override
  RegularisationDashboardState regularisationList(
          List<Regularisation>? regularisationList) =>
      this(regularisationList: regularisationList);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RegularisationDashboardState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RegularisationDashboardState(...).copyWith(id: 12, name: "My name")
  /// ````
  RegularisationDashboardState call({
    Object? uiState = const $CopyWithPlaceholder(),
    Object? selectedBillingCycle = const $CopyWithPlaceholder(),
    Object? isLoading = const $CopyWithPlaceholder(),
    Object? currentTabIndex = const $CopyWithPlaceholder(),
    Object? regularisationList = const $CopyWithPlaceholder(),
  }) {
    return RegularisationDashboardState(
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
      regularisationList: regularisationList == const $CopyWithPlaceholder()
          ? _value.regularisationList
          // ignore: cast_nullable_to_non_nullable
          : regularisationList as List<Regularisation>?,
    );
  }
}

extension $RegularisationDashboardStateCopyWith
    on RegularisationDashboardState {
  /// Returns a callable class that can be used as follows: `instanceOfRegularisationDashboardState.copyWith(...)` or like so:`instanceOfRegularisationDashboardState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RegularisationDashboardStateCWProxy get copyWith =>
      _$RegularisationDashboardStateCWProxyImpl(this);
}
