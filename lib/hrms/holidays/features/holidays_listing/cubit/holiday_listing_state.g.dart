// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'holiday_listing_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$HolidayListingStateCWProxy {
  HolidayListingState uiState(UIState? uiState);

  HolidayListingState buttonState(ButtonState? buttonState);

  HolidayListingState currentTabIndex(int? currentTabIndex);

  HolidayListingState isLoading(bool? isLoading);

  HolidayListingState allHolidayList(List<Holiday>? allHolidayList);

  HolidayListingState regularHolidayList(List<Holiday>? regularHolidayList);

  HolidayListingState restrictedHolidayList(
      List<Holiday>? restrictedHolidayList);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `HolidayListingState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// HolidayListingState(...).copyWith(id: 12, name: "My name")
  /// ````
  HolidayListingState call({
    UIState? uiState,
    ButtonState? buttonState,
    int? currentTabIndex,
    bool? isLoading,
    List<Holiday>? allHolidayList,
    List<Holiday>? regularHolidayList,
    List<Holiday>? restrictedHolidayList,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfHolidayListingState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfHolidayListingState.copyWith.fieldName(...)`
class _$HolidayListingStateCWProxyImpl implements _$HolidayListingStateCWProxy {
  const _$HolidayListingStateCWProxyImpl(this._value);

  final HolidayListingState _value;

  @override
  HolidayListingState uiState(UIState? uiState) => this(uiState: uiState);

  @override
  HolidayListingState buttonState(ButtonState? buttonState) =>
      this(buttonState: buttonState);

  @override
  HolidayListingState currentTabIndex(int? currentTabIndex) =>
      this(currentTabIndex: currentTabIndex);

  @override
  HolidayListingState isLoading(bool? isLoading) => this(isLoading: isLoading);

  @override
  HolidayListingState allHolidayList(List<Holiday>? allHolidayList) =>
      this(allHolidayList: allHolidayList);

  @override
  HolidayListingState regularHolidayList(List<Holiday>? regularHolidayList) =>
      this(regularHolidayList: regularHolidayList);

  @override
  HolidayListingState restrictedHolidayList(
          List<Holiday>? restrictedHolidayList) =>
      this(restrictedHolidayList: restrictedHolidayList);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `HolidayListingState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// HolidayListingState(...).copyWith(id: 12, name: "My name")
  /// ````
  HolidayListingState call({
    Object? uiState = const $CopyWithPlaceholder(),
    Object? buttonState = const $CopyWithPlaceholder(),
    Object? currentTabIndex = const $CopyWithPlaceholder(),
    Object? isLoading = const $CopyWithPlaceholder(),
    Object? allHolidayList = const $CopyWithPlaceholder(),
    Object? regularHolidayList = const $CopyWithPlaceholder(),
    Object? restrictedHolidayList = const $CopyWithPlaceholder(),
  }) {
    return HolidayListingState(
      uiState: uiState == const $CopyWithPlaceholder()
          ? _value.uiState
          // ignore: cast_nullable_to_non_nullable
          : uiState as UIState?,
      buttonState: buttonState == const $CopyWithPlaceholder()
          ? _value.buttonState
          // ignore: cast_nullable_to_non_nullable
          : buttonState as ButtonState?,
      currentTabIndex: currentTabIndex == const $CopyWithPlaceholder()
          ? _value.currentTabIndex
          // ignore: cast_nullable_to_non_nullable
          : currentTabIndex as int?,
      isLoading: isLoading == const $CopyWithPlaceholder()
          ? _value.isLoading
          // ignore: cast_nullable_to_non_nullable
          : isLoading as bool?,
      allHolidayList: allHolidayList == const $CopyWithPlaceholder()
          ? _value.allHolidayList
          // ignore: cast_nullable_to_non_nullable
          : allHolidayList as List<Holiday>?,
      regularHolidayList: regularHolidayList == const $CopyWithPlaceholder()
          ? _value.regularHolidayList
          // ignore: cast_nullable_to_non_nullable
          : regularHolidayList as List<Holiday>?,
      restrictedHolidayList:
          restrictedHolidayList == const $CopyWithPlaceholder()
              ? _value.restrictedHolidayList
              // ignore: cast_nullable_to_non_nullable
              : restrictedHolidayList as List<Holiday>?,
    );
  }
}

extension $HolidayListingStateCopyWith on HolidayListingState {
  /// Returns a callable class that can be used as follows: `instanceOfHolidayListingState.copyWith(...)` or like so:`instanceOfHolidayListingState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$HolidayListingStateCWProxy get copyWith =>
      _$HolidayListingStateCWProxyImpl(this);
}
