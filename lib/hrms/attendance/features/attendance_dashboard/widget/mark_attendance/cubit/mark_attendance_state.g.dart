// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mark_attendance_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MarkAttendanceStateCWProxy {
  MarkAttendanceState uiState(UIState? uiState);

  MarkAttendanceState buttonState(ButtonState? buttonState);

  MarkAttendanceState punchType(PunchType? punchType);

  MarkAttendanceState lastPunchInTime(String? lastPunchInTime);

  MarkAttendanceState lastPunchOutTime(String? lastPunchOutTime);

  MarkAttendanceState duration(Duration? duration);

  MarkAttendanceState attendanceType(AttendanceType? attendanceType);

  MarkAttendanceState workLocation(WorkLocation? workLocation);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `MarkAttendanceState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// MarkAttendanceState(...).copyWith(id: 12, name: "My name")
  /// ````
  MarkAttendanceState call({
    UIState? uiState,
    ButtonState? buttonState,
    PunchType? punchType,
    String? lastPunchInTime,
    String? lastPunchOutTime,
    Duration? duration,
    AttendanceType? attendanceType,
    WorkLocation? workLocation,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfMarkAttendanceState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfMarkAttendanceState.copyWith.fieldName(...)`
class _$MarkAttendanceStateCWProxyImpl implements _$MarkAttendanceStateCWProxy {
  const _$MarkAttendanceStateCWProxyImpl(this._value);

  final MarkAttendanceState _value;

  @override
  MarkAttendanceState uiState(UIState? uiState) => this(uiState: uiState);

  @override
  MarkAttendanceState buttonState(ButtonState? buttonState) =>
      this(buttonState: buttonState);

  @override
  MarkAttendanceState punchType(PunchType? punchType) =>
      this(punchType: punchType);

  @override
  MarkAttendanceState lastPunchInTime(String? lastPunchInTime) =>
      this(lastPunchInTime: lastPunchInTime);

  @override
  MarkAttendanceState lastPunchOutTime(String? lastPunchOutTime) =>
      this(lastPunchOutTime: lastPunchOutTime);

  @override
  MarkAttendanceState duration(Duration? duration) => this(duration: duration);

  @override
  MarkAttendanceState attendanceType(AttendanceType? attendanceType) =>
      this(attendanceType: attendanceType);

  @override
  MarkAttendanceState workLocation(WorkLocation? workLocation) =>
      this(workLocation: workLocation);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `MarkAttendanceState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// MarkAttendanceState(...).copyWith(id: 12, name: "My name")
  /// ````
  MarkAttendanceState call({
    Object? uiState = const $CopyWithPlaceholder(),
    Object? buttonState = const $CopyWithPlaceholder(),
    Object? punchType = const $CopyWithPlaceholder(),
    Object? lastPunchInTime = const $CopyWithPlaceholder(),
    Object? lastPunchOutTime = const $CopyWithPlaceholder(),
    Object? duration = const $CopyWithPlaceholder(),
    Object? attendanceType = const $CopyWithPlaceholder(),
    Object? workLocation = const $CopyWithPlaceholder(),
  }) {
    return MarkAttendanceState(
      uiState: uiState == const $CopyWithPlaceholder()
          ? _value.uiState
          // ignore: cast_nullable_to_non_nullable
          : uiState as UIState?,
      buttonState: buttonState == const $CopyWithPlaceholder()
          ? _value.buttonState
          // ignore: cast_nullable_to_non_nullable
          : buttonState as ButtonState?,
      punchType: punchType == const $CopyWithPlaceholder()
          ? _value.punchType
          // ignore: cast_nullable_to_non_nullable
          : punchType as PunchType?,
      lastPunchInTime: lastPunchInTime == const $CopyWithPlaceholder()
          ? _value.lastPunchInTime
          // ignore: cast_nullable_to_non_nullable
          : lastPunchInTime as String?,
      lastPunchOutTime: lastPunchOutTime == const $CopyWithPlaceholder()
          ? _value.lastPunchOutTime
          // ignore: cast_nullable_to_non_nullable
          : lastPunchOutTime as String?,
      duration: duration == const $CopyWithPlaceholder()
          ? _value.duration
          // ignore: cast_nullable_to_non_nullable
          : duration as Duration?,
      attendanceType: attendanceType == const $CopyWithPlaceholder()
          ? _value.attendanceType
          // ignore: cast_nullable_to_non_nullable
          : attendanceType as AttendanceType?,
      workLocation: workLocation == const $CopyWithPlaceholder()
          ? _value.workLocation
          // ignore: cast_nullable_to_non_nullable
          : workLocation as WorkLocation?,
    );
  }
}

extension $MarkAttendanceStateCopyWith on MarkAttendanceState {
  /// Returns a callable class that can be used as follows: `instanceOfMarkAttendanceState.copyWith(...)` or like so:`instanceOfMarkAttendanceState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MarkAttendanceStateCWProxy get copyWith =>
      _$MarkAttendanceStateCWProxyImpl(this);
}
