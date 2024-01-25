// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DashboardStateCWProxy {
  DashboardState navigationItemList(List<NavigationItem>? navigationItemList);

  DashboardState currentTabIndex(int? currentTabIndex);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DashboardState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DashboardState(...).copyWith(id: 12, name: "My name")
  /// ````
  DashboardState call({
    List<NavigationItem>? navigationItemList,
    int? currentTabIndex,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfDashboardState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfDashboardState.copyWith.fieldName(...)`
class _$DashboardStateCWProxyImpl implements _$DashboardStateCWProxy {
  const _$DashboardStateCWProxyImpl(this._value);

  final DashboardState _value;

  @override
  DashboardState navigationItemList(List<NavigationItem>? navigationItemList) =>
      this(navigationItemList: navigationItemList);

  @override
  DashboardState currentTabIndex(int? currentTabIndex) =>
      this(currentTabIndex: currentTabIndex);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DashboardState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DashboardState(...).copyWith(id: 12, name: "My name")
  /// ````
  DashboardState call({
    Object? navigationItemList = const $CopyWithPlaceholder(),
    Object? currentTabIndex = const $CopyWithPlaceholder(),
  }) {
    return DashboardState(
      navigationItemList: navigationItemList == const $CopyWithPlaceholder()
          ? _value.navigationItemList
          // ignore: cast_nullable_to_non_nullable
          : navigationItemList as List<NavigationItem>?,
      currentTabIndex: currentTabIndex == const $CopyWithPlaceholder()
          ? _value.currentTabIndex
          // ignore: cast_nullable_to_non_nullable
          : currentTabIndex as int?,
    );
  }
}

extension $DashboardStateCopyWith on DashboardState {
  /// Returns a callable class that can be used as follows: `instanceOfDashboardState.copyWith(...)` or like so:`instanceOfDashboardState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DashboardStateCWProxy get copyWith => _$DashboardStateCWProxyImpl(this);
}
