// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rm_attendance_details_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$RMAttendanceDetailsStateCWProxy {
  RMAttendanceDetailsState uiState(UIState? uiState);

  RMAttendanceDetailsState buttonState(ButtonState? buttonState);

  RMAttendanceDetailsState employeeAttendance(
      EmployeeAttendance? employeeAttendance);

  RMAttendanceDetailsState placeMark(Placemark? placeMark);

  RMAttendanceDetailsState isAddressLoading(bool? isAddressLoading);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RMAttendanceDetailsState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RMAttendanceDetailsState(...).copyWith(id: 12, name: "My name")
  /// ````
  RMAttendanceDetailsState call({
    UIState? uiState,
    ButtonState? buttonState,
    EmployeeAttendance? employeeAttendance,
    Placemark? placeMark,
    bool? isAddressLoading,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfRMAttendanceDetailsState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfRMAttendanceDetailsState.copyWith.fieldName(...)`
class _$RMAttendanceDetailsStateCWProxyImpl
    implements _$RMAttendanceDetailsStateCWProxy {
  const _$RMAttendanceDetailsStateCWProxyImpl(this._value);

  final RMAttendanceDetailsState _value;

  @override
  RMAttendanceDetailsState uiState(UIState? uiState) => this(uiState: uiState);

  @override
  RMAttendanceDetailsState buttonState(ButtonState? buttonState) =>
      this(buttonState: buttonState);

  @override
  RMAttendanceDetailsState employeeAttendance(
          EmployeeAttendance? employeeAttendance) =>
      this(employeeAttendance: employeeAttendance);

  @override
  RMAttendanceDetailsState placeMark(Placemark? placeMark) =>
      this(placeMark: placeMark);

  @override
  RMAttendanceDetailsState isAddressLoading(bool? isAddressLoading) =>
      this(isAddressLoading: isAddressLoading);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RMAttendanceDetailsState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RMAttendanceDetailsState(...).copyWith(id: 12, name: "My name")
  /// ````
  RMAttendanceDetailsState call({
    Object? uiState = const $CopyWithPlaceholder(),
    Object? buttonState = const $CopyWithPlaceholder(),
    Object? employeeAttendance = const $CopyWithPlaceholder(),
    Object? placeMark = const $CopyWithPlaceholder(),
    Object? isAddressLoading = const $CopyWithPlaceholder(),
  }) {
    return RMAttendanceDetailsState(
      uiState: uiState == const $CopyWithPlaceholder()
          ? _value.uiState
          // ignore: cast_nullable_to_non_nullable
          : uiState as UIState?,
      buttonState: buttonState == const $CopyWithPlaceholder()
          ? _value.buttonState
          // ignore: cast_nullable_to_non_nullable
          : buttonState as ButtonState?,
      employeeAttendance: employeeAttendance == const $CopyWithPlaceholder()
          ? _value.employeeAttendance
          // ignore: cast_nullable_to_non_nullable
          : employeeAttendance as EmployeeAttendance?,
      placeMark: placeMark == const $CopyWithPlaceholder()
          ? _value.placeMark
          // ignore: cast_nullable_to_non_nullable
          : placeMark as Placemark?,
      isAddressLoading: isAddressLoading == const $CopyWithPlaceholder()
          ? _value.isAddressLoading
          // ignore: cast_nullable_to_non_nullable
          : isAddressLoading as bool?,
    );
  }
}

extension $RMAttendanceDetailsStateCopyWith on RMAttendanceDetailsState {
  /// Returns a callable class that can be used as follows: `instanceOfRMAttendanceDetailsState.copyWith(...)` or like so:`instanceOfRMAttendanceDetailsState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RMAttendanceDetailsStateCWProxy get copyWith =>
      _$RMAttendanceDetailsStateCWProxyImpl(this);
}
