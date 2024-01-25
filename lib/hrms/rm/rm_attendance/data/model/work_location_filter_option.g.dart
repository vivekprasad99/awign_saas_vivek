// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_location_filter_option.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$WorkLocationFilterOptionCWProxy {
  WorkLocationFilterOption label(String? label);

  WorkLocationFilterOption isSelected(bool? isSelected);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `WorkLocationFilterOption(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// WorkLocationFilterOption(...).copyWith(id: 12, name: "My name")
  /// ````
  WorkLocationFilterOption call({
    String? label,
    bool? isSelected,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfWorkLocationFilterOption.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfWorkLocationFilterOption.copyWith.fieldName(...)`
class _$WorkLocationFilterOptionCWProxyImpl
    implements _$WorkLocationFilterOptionCWProxy {
  const _$WorkLocationFilterOptionCWProxyImpl(this._value);

  final WorkLocationFilterOption _value;

  @override
  WorkLocationFilterOption label(String? label) => this(label: label);

  @override
  WorkLocationFilterOption isSelected(bool? isSelected) =>
      this(isSelected: isSelected);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `WorkLocationFilterOption(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// WorkLocationFilterOption(...).copyWith(id: 12, name: "My name")
  /// ````
  WorkLocationFilterOption call({
    Object? label = const $CopyWithPlaceholder(),
    Object? isSelected = const $CopyWithPlaceholder(),
  }) {
    return WorkLocationFilterOption(
      label == const $CopyWithPlaceholder()
          ? _value.label
          // ignore: cast_nullable_to_non_nullable
          : label as String?,
      isSelected == const $CopyWithPlaceholder()
          ? _value.isSelected
          // ignore: cast_nullable_to_non_nullable
          : isSelected as bool?,
    );
  }
}

extension $WorkLocationFilterOptionCopyWith on WorkLocationFilterOption {
  /// Returns a callable class that can be used as follows: `instanceOfWorkLocationFilterOption.copyWith(...)` or like so:`instanceOfWorkLocationFilterOption.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$WorkLocationFilterOptionCWProxy get copyWith =>
      _$WorkLocationFilterOptionCWProxyImpl(this);
}
