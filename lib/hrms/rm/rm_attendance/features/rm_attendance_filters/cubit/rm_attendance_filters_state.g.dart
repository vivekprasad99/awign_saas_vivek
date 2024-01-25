// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rm_attendance_filters_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$RMAttendanceFiltersStateCWProxy {
  RMAttendanceFiltersState uiState(UIState? uiState);

  RMAttendanceFiltersState filterOptionList(
      List<FilterOption>? filterOptionList);

  RMAttendanceFiltersState lastSelectedFilter(FilterOption? lastSelectedFilter);

  RMAttendanceFiltersState lastSelectedFilterIndex(
      int? lastSelectedFilterIndex);

  RMAttendanceFiltersState buttonState(ButtonState? buttonState);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RMAttendanceFiltersState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RMAttendanceFiltersState(...).copyWith(id: 12, name: "My name")
  /// ````
  RMAttendanceFiltersState call({
    UIState? uiState,
    List<FilterOption>? filterOptionList,
    FilterOption? lastSelectedFilter,
    int? lastSelectedFilterIndex,
    ButtonState? buttonState,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfRMAttendanceFiltersState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfRMAttendanceFiltersState.copyWith.fieldName(...)`
class _$RMAttendanceFiltersStateCWProxyImpl
    implements _$RMAttendanceFiltersStateCWProxy {
  const _$RMAttendanceFiltersStateCWProxyImpl(this._value);

  final RMAttendanceFiltersState _value;

  @override
  RMAttendanceFiltersState uiState(UIState? uiState) => this(uiState: uiState);

  @override
  RMAttendanceFiltersState filterOptionList(
          List<FilterOption>? filterOptionList) =>
      this(filterOptionList: filterOptionList);

  @override
  RMAttendanceFiltersState lastSelectedFilter(
          FilterOption? lastSelectedFilter) =>
      this(lastSelectedFilter: lastSelectedFilter);

  @override
  RMAttendanceFiltersState lastSelectedFilterIndex(
          int? lastSelectedFilterIndex) =>
      this(lastSelectedFilterIndex: lastSelectedFilterIndex);

  @override
  RMAttendanceFiltersState buttonState(ButtonState? buttonState) =>
      this(buttonState: buttonState);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RMAttendanceFiltersState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RMAttendanceFiltersState(...).copyWith(id: 12, name: "My name")
  /// ````
  RMAttendanceFiltersState call({
    Object? uiState = const $CopyWithPlaceholder(),
    Object? filterOptionList = const $CopyWithPlaceholder(),
    Object? lastSelectedFilter = const $CopyWithPlaceholder(),
    Object? lastSelectedFilterIndex = const $CopyWithPlaceholder(),
    Object? buttonState = const $CopyWithPlaceholder(),
  }) {
    return RMAttendanceFiltersState(
      uiState: uiState == const $CopyWithPlaceholder()
          ? _value.uiState
          // ignore: cast_nullable_to_non_nullable
          : uiState as UIState?,
      filterOptionList: filterOptionList == const $CopyWithPlaceholder()
          ? _value.filterOptionList
          // ignore: cast_nullable_to_non_nullable
          : filterOptionList as List<FilterOption>?,
      lastSelectedFilter: lastSelectedFilter == const $CopyWithPlaceholder()
          ? _value.lastSelectedFilter
          // ignore: cast_nullable_to_non_nullable
          : lastSelectedFilter as FilterOption?,
      lastSelectedFilterIndex:
          lastSelectedFilterIndex == const $CopyWithPlaceholder()
              ? _value.lastSelectedFilterIndex
              // ignore: cast_nullable_to_non_nullable
              : lastSelectedFilterIndex as int?,
      buttonState: buttonState == const $CopyWithPlaceholder()
          ? _value.buttonState
          // ignore: cast_nullable_to_non_nullable
          : buttonState as ButtonState?,
    );
  }
}

extension $RMAttendanceFiltersStateCopyWith on RMAttendanceFiltersState {
  /// Returns a callable class that can be used as follows: `instanceOfRMAttendanceFiltersState.copyWith(...)` or like so:`instanceOfRMAttendanceFiltersState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RMAttendanceFiltersStateCWProxy get copyWith =>
      _$RMAttendanceFiltersStateCWProxyImpl(this);
}
