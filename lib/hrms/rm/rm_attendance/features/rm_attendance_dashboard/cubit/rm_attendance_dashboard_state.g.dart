// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rm_attendance_dashboard_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$RMAttendanceDashboardStateCWProxy {
  RMAttendanceDashboardState uiState(UIState? uiState);

  RMAttendanceDashboardState selectedBillingCycle(
      BillingCycle? selectedBillingCycle);

  RMAttendanceDashboardState isLoading(bool? isLoading);

  RMAttendanceDashboardState currentTabIndex(int? currentTabIndex);

  RMAttendanceDashboardState presentList(List<EmployeeAttendance>? presentList);

  RMAttendanceDashboardState absentList(List<EmployeeAttendance>? absentList);

  RMAttendanceDashboardState leaveList(List<EmployeeAttendance>? leaveList);

  RMAttendanceDashboardState allAttendanceList(
      List<EmployeeAttendance>? allAttendanceList);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RMAttendanceDashboardState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RMAttendanceDashboardState(...).copyWith(id: 12, name: "My name")
  /// ````
  RMAttendanceDashboardState call({
    UIState? uiState,
    BillingCycle? selectedBillingCycle,
    bool? isLoading,
    int? currentTabIndex,
    List<EmployeeAttendance>? presentList,
    List<EmployeeAttendance>? absentList,
    List<EmployeeAttendance>? leaveList,
    List<EmployeeAttendance>? allAttendanceList,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfRMAttendanceDashboardState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfRMAttendanceDashboardState.copyWith.fieldName(...)`
class _$RMAttendanceDashboardStateCWProxyImpl
    implements _$RMAttendanceDashboardStateCWProxy {
  const _$RMAttendanceDashboardStateCWProxyImpl(this._value);

  final RMAttendanceDashboardState _value;

  @override
  RMAttendanceDashboardState uiState(UIState? uiState) =>
      this(uiState: uiState);

  @override
  RMAttendanceDashboardState selectedBillingCycle(
          BillingCycle? selectedBillingCycle) =>
      this(selectedBillingCycle: selectedBillingCycle);

  @override
  RMAttendanceDashboardState isLoading(bool? isLoading) =>
      this(isLoading: isLoading);

  @override
  RMAttendanceDashboardState currentTabIndex(int? currentTabIndex) =>
      this(currentTabIndex: currentTabIndex);

  @override
  RMAttendanceDashboardState presentList(
          List<EmployeeAttendance>? presentList) =>
      this(presentList: presentList);

  @override
  RMAttendanceDashboardState absentList(List<EmployeeAttendance>? absentList) =>
      this(absentList: absentList);

  @override
  RMAttendanceDashboardState leaveList(List<EmployeeAttendance>? leaveList) =>
      this(leaveList: leaveList);

  @override
  RMAttendanceDashboardState allAttendanceList(
          List<EmployeeAttendance>? allAttendanceList) =>
      this(allAttendanceList: allAttendanceList);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RMAttendanceDashboardState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RMAttendanceDashboardState(...).copyWith(id: 12, name: "My name")
  /// ````
  RMAttendanceDashboardState call({
    Object? uiState = const $CopyWithPlaceholder(),
    Object? selectedBillingCycle = const $CopyWithPlaceholder(),
    Object? isLoading = const $CopyWithPlaceholder(),
    Object? currentTabIndex = const $CopyWithPlaceholder(),
    Object? presentList = const $CopyWithPlaceholder(),
    Object? absentList = const $CopyWithPlaceholder(),
    Object? leaveList = const $CopyWithPlaceholder(),
    Object? allAttendanceList = const $CopyWithPlaceholder(),
  }) {
    return RMAttendanceDashboardState(
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
      presentList: presentList == const $CopyWithPlaceholder()
          ? _value.presentList
          // ignore: cast_nullable_to_non_nullable
          : presentList as List<EmployeeAttendance>?,
      absentList: absentList == const $CopyWithPlaceholder()
          ? _value.absentList
          // ignore: cast_nullable_to_non_nullable
          : absentList as List<EmployeeAttendance>?,
      leaveList: leaveList == const $CopyWithPlaceholder()
          ? _value.leaveList
          // ignore: cast_nullable_to_non_nullable
          : leaveList as List<EmployeeAttendance>?,
      allAttendanceList: allAttendanceList == const $CopyWithPlaceholder()
          ? _value.allAttendanceList
          // ignore: cast_nullable_to_non_nullable
          : allAttendanceList as List<EmployeeAttendance>?,
    );
  }
}

extension $RMAttendanceDashboardStateCopyWith on RMAttendanceDashboardState {
  /// Returns a callable class that can be used as follows: `instanceOfRMAttendanceDashboardState.copyWith(...)` or like so:`instanceOfRMAttendanceDashboardState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RMAttendanceDashboardStateCWProxy get copyWith =>
      _$RMAttendanceDashboardStateCWProxyImpl(this);
}
