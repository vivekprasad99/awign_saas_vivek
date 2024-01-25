// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_dashboard_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AttendanceDashboardStateCWProxy {
  AttendanceDashboardState uiState(UIState? uiState);

  AttendanceDashboardState selectedBillingCycle(
      BillingCycle? selectedBillingCycle);

  AttendanceDashboardState isLoading(bool? isLoading);

  AttendanceDashboardState currentTabIndex(int? currentTabIndex);

  AttendanceDashboardState presentList(List<AttendanceDetails>? presentList);

  AttendanceDashboardState absentList(List<AttendanceDetails>? absentList);

  AttendanceDashboardState leaveList(List<AttendanceDetails>? leaveList);

  AttendanceDashboardState allAttendanceList(
      List<AttendanceDetails>? allAttendanceList);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AttendanceDashboardState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AttendanceDashboardState(...).copyWith(id: 12, name: "My name")
  /// ````
  AttendanceDashboardState call({
    UIState? uiState,
    BillingCycle? selectedBillingCycle,
    bool? isLoading,
    int? currentTabIndex,
    List<AttendanceDetails>? presentList,
    List<AttendanceDetails>? absentList,
    List<AttendanceDetails>? leaveList,
    List<AttendanceDetails>? allAttendanceList,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAttendanceDashboardState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAttendanceDashboardState.copyWith.fieldName(...)`
class _$AttendanceDashboardStateCWProxyImpl
    implements _$AttendanceDashboardStateCWProxy {
  const _$AttendanceDashboardStateCWProxyImpl(this._value);

  final AttendanceDashboardState _value;

  @override
  AttendanceDashboardState uiState(UIState? uiState) => this(uiState: uiState);

  @override
  AttendanceDashboardState selectedBillingCycle(
          BillingCycle? selectedBillingCycle) =>
      this(selectedBillingCycle: selectedBillingCycle);

  @override
  AttendanceDashboardState isLoading(bool? isLoading) =>
      this(isLoading: isLoading);

  @override
  AttendanceDashboardState currentTabIndex(int? currentTabIndex) =>
      this(currentTabIndex: currentTabIndex);

  @override
  AttendanceDashboardState presentList(List<AttendanceDetails>? presentList) =>
      this(presentList: presentList);

  @override
  AttendanceDashboardState absentList(List<AttendanceDetails>? absentList) =>
      this(absentList: absentList);

  @override
  AttendanceDashboardState leaveList(List<AttendanceDetails>? leaveList) =>
      this(leaveList: leaveList);

  @override
  AttendanceDashboardState allAttendanceList(
          List<AttendanceDetails>? allAttendanceList) =>
      this(allAttendanceList: allAttendanceList);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AttendanceDashboardState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AttendanceDashboardState(...).copyWith(id: 12, name: "My name")
  /// ````
  AttendanceDashboardState call({
    Object? uiState = const $CopyWithPlaceholder(),
    Object? selectedBillingCycle = const $CopyWithPlaceholder(),
    Object? isLoading = const $CopyWithPlaceholder(),
    Object? currentTabIndex = const $CopyWithPlaceholder(),
    Object? presentList = const $CopyWithPlaceholder(),
    Object? absentList = const $CopyWithPlaceholder(),
    Object? leaveList = const $CopyWithPlaceholder(),
    Object? allAttendanceList = const $CopyWithPlaceholder(),
  }) {
    return AttendanceDashboardState(
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
          : presentList as List<AttendanceDetails>?,
      absentList: absentList == const $CopyWithPlaceholder()
          ? _value.absentList
          // ignore: cast_nullable_to_non_nullable
          : absentList as List<AttendanceDetails>?,
      leaveList: leaveList == const $CopyWithPlaceholder()
          ? _value.leaveList
          // ignore: cast_nullable_to_non_nullable
          : leaveList as List<AttendanceDetails>?,
      allAttendanceList: allAttendanceList == const $CopyWithPlaceholder()
          ? _value.allAttendanceList
          // ignore: cast_nullable_to_non_nullable
          : allAttendanceList as List<AttendanceDetails>?,
    );
  }
}

extension $AttendanceDashboardStateCopyWith on AttendanceDashboardState {
  /// Returns a callable class that can be used as follows: `instanceOfAttendanceDashboardState.copyWith(...)` or like so:`instanceOfAttendanceDashboardState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AttendanceDashboardStateCWProxy get copyWith =>
      _$AttendanceDashboardStateCWProxyImpl(this);
}
