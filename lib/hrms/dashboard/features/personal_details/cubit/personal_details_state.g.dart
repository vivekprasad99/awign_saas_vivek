// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personal_details_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PersonalDetailsStateCWProxy {
  PersonalDetailsState uiState(UIState? uiState);

  PersonalDetailsState currentTabIndex(int? currentTabIndex);

  PersonalDetailsState isLoading(bool? isLoading);

  PersonalDetailsState employeeDetails(EmployeeDetails? employeeDetails);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PersonalDetailsState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PersonalDetailsState(...).copyWith(id: 12, name: "My name")
  /// ````
  PersonalDetailsState call({
    UIState? uiState,
    int? currentTabIndex,
    bool? isLoading,
    EmployeeDetails? employeeDetails,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPersonalDetailsState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPersonalDetailsState.copyWith.fieldName(...)`
class _$PersonalDetailsStateCWProxyImpl
    implements _$PersonalDetailsStateCWProxy {
  const _$PersonalDetailsStateCWProxyImpl(this._value);

  final PersonalDetailsState _value;

  @override
  PersonalDetailsState uiState(UIState? uiState) => this(uiState: uiState);

  @override
  PersonalDetailsState currentTabIndex(int? currentTabIndex) =>
      this(currentTabIndex: currentTabIndex);

  @override
  PersonalDetailsState isLoading(bool? isLoading) => this(isLoading: isLoading);

  @override
  PersonalDetailsState employeeDetails(EmployeeDetails? employeeDetails) =>
      this(employeeDetails: employeeDetails);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PersonalDetailsState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PersonalDetailsState(...).copyWith(id: 12, name: "My name")
  /// ````
  PersonalDetailsState call({
    Object? uiState = const $CopyWithPlaceholder(),
    Object? currentTabIndex = const $CopyWithPlaceholder(),
    Object? isLoading = const $CopyWithPlaceholder(),
    Object? employeeDetails = const $CopyWithPlaceholder(),
  }) {
    return PersonalDetailsState(
      uiState: uiState == const $CopyWithPlaceholder()
          ? _value.uiState
          // ignore: cast_nullable_to_non_nullable
          : uiState as UIState?,
      currentTabIndex: currentTabIndex == const $CopyWithPlaceholder()
          ? _value.currentTabIndex
          // ignore: cast_nullable_to_non_nullable
          : currentTabIndex as int?,
      isLoading: isLoading == const $CopyWithPlaceholder()
          ? _value.isLoading
          // ignore: cast_nullable_to_non_nullable
          : isLoading as bool?,
      employeeDetails: employeeDetails == const $CopyWithPlaceholder()
          ? _value.employeeDetails
          // ignore: cast_nullable_to_non_nullable
          : employeeDetails as EmployeeDetails?,
    );
  }
}

extension $PersonalDetailsStateCopyWith on PersonalDetailsState {
  /// Returns a callable class that can be used as follows: `instanceOfPersonalDetailsState.copyWith(...)` or like so:`instanceOfPersonalDetailsState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PersonalDetailsStateCWProxy get copyWith =>
      _$PersonalDetailsStateCWProxyImpl(this);
}
