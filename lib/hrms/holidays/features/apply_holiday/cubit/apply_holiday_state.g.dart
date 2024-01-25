// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apply_holiday_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ApplyHolidayStateCWProxy {
  ApplyHolidayState uiState(UIState? uiState);

  ApplyHolidayState buttonState(ButtonState? buttonState);

  ApplyHolidayState reason(String? reason);

  ApplyHolidayState reasonError(String? reasonError);

  ApplyHolidayState date(DateTime? date);

  ApplyHolidayState dateError(String? dateError);

  ApplyHolidayState holiday(Holiday? holiday);

  ApplyHolidayState managerList(List<Manager>? managerList);

  ApplyHolidayState selectedManager(Manager? selectedManager);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ApplyHolidayState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ApplyHolidayState(...).copyWith(id: 12, name: "My name")
  /// ````
  ApplyHolidayState call({
    UIState? uiState,
    ButtonState? buttonState,
    String? reason,
    String? reasonError,
    DateTime? date,
    String? dateError,
    Holiday? holiday,
    List<Manager>? managerList,
    Manager? selectedManager,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfApplyHolidayState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfApplyHolidayState.copyWith.fieldName(...)`
class _$ApplyHolidayStateCWProxyImpl implements _$ApplyHolidayStateCWProxy {
  const _$ApplyHolidayStateCWProxyImpl(this._value);

  final ApplyHolidayState _value;

  @override
  ApplyHolidayState uiState(UIState? uiState) => this(uiState: uiState);

  @override
  ApplyHolidayState buttonState(ButtonState? buttonState) =>
      this(buttonState: buttonState);

  @override
  ApplyHolidayState reason(String? reason) => this(reason: reason);

  @override
  ApplyHolidayState reasonError(String? reasonError) =>
      this(reasonError: reasonError);

  @override
  ApplyHolidayState date(DateTime? date) => this(date: date);

  @override
  ApplyHolidayState dateError(String? dateError) => this(dateError: dateError);

  @override
  ApplyHolidayState holiday(Holiday? holiday) => this(holiday: holiday);

  @override
  ApplyHolidayState managerList(List<Manager>? managerList) =>
      this(managerList: managerList);

  @override
  ApplyHolidayState selectedManager(Manager? selectedManager) =>
      this(selectedManager: selectedManager);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ApplyHolidayState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ApplyHolidayState(...).copyWith(id: 12, name: "My name")
  /// ````
  ApplyHolidayState call({
    Object? uiState = const $CopyWithPlaceholder(),
    Object? buttonState = const $CopyWithPlaceholder(),
    Object? reason = const $CopyWithPlaceholder(),
    Object? reasonError = const $CopyWithPlaceholder(),
    Object? date = const $CopyWithPlaceholder(),
    Object? dateError = const $CopyWithPlaceholder(),
    Object? holiday = const $CopyWithPlaceholder(),
    Object? managerList = const $CopyWithPlaceholder(),
    Object? selectedManager = const $CopyWithPlaceholder(),
  }) {
    return ApplyHolidayState(
      uiState: uiState == const $CopyWithPlaceholder()
          ? _value.uiState
          // ignore: cast_nullable_to_non_nullable
          : uiState as UIState?,
      buttonState: buttonState == const $CopyWithPlaceholder()
          ? _value.buttonState
          // ignore: cast_nullable_to_non_nullable
          : buttonState as ButtonState?,
      reason: reason == const $CopyWithPlaceholder()
          ? _value.reason
          // ignore: cast_nullable_to_non_nullable
          : reason as String?,
      reasonError: reasonError == const $CopyWithPlaceholder()
          ? _value.reasonError
          // ignore: cast_nullable_to_non_nullable
          : reasonError as String?,
      date: date == const $CopyWithPlaceholder()
          ? _value.date
          // ignore: cast_nullable_to_non_nullable
          : date as DateTime?,
      dateError: dateError == const $CopyWithPlaceholder()
          ? _value.dateError
          // ignore: cast_nullable_to_non_nullable
          : dateError as String?,
      holiday: holiday == const $CopyWithPlaceholder()
          ? _value.holiday
          // ignore: cast_nullable_to_non_nullable
          : holiday as Holiday?,
      managerList: managerList == const $CopyWithPlaceholder()
          ? _value.managerList
          // ignore: cast_nullable_to_non_nullable
          : managerList as List<Manager>?,
      selectedManager: selectedManager == const $CopyWithPlaceholder()
          ? _value.selectedManager
          // ignore: cast_nullable_to_non_nullable
          : selectedManager as Manager?,
    );
  }
}

extension $ApplyHolidayStateCopyWith on ApplyHolidayState {
  /// Returns a callable class that can be used as follows: `instanceOfApplyHolidayState.copyWith(...)` or like so:`instanceOfApplyHolidayState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ApplyHolidayStateCWProxy get copyWith =>
      _$ApplyHolidayStateCWProxyImpl(this);
}
