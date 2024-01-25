// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shift_filter_option.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ShiftFilterOptionCWProxy {
  ShiftFilterOption label(String? label);

  ShiftFilterOption isSelected(bool? isSelected);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ShiftFilterOption(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ShiftFilterOption(...).copyWith(id: 12, name: "My name")
  /// ````
  ShiftFilterOption call({
    String? label,
    bool? isSelected,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfShiftFilterOption.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfShiftFilterOption.copyWith.fieldName(...)`
class _$ShiftFilterOptionCWProxyImpl implements _$ShiftFilterOptionCWProxy {
  const _$ShiftFilterOptionCWProxyImpl(this._value);

  final ShiftFilterOption _value;

  @override
  ShiftFilterOption label(String? label) => this(label: label);

  @override
  ShiftFilterOption isSelected(bool? isSelected) =>
      this(isSelected: isSelected);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ShiftFilterOption(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ShiftFilterOption(...).copyWith(id: 12, name: "My name")
  /// ````
  ShiftFilterOption call({
    Object? label = const $CopyWithPlaceholder(),
    Object? isSelected = const $CopyWithPlaceholder(),
  }) {
    return ShiftFilterOption(
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

extension $ShiftFilterOptionCopyWith on ShiftFilterOption {
  /// Returns a callable class that can be used as follows: `instanceOfShiftFilterOption.copyWith(...)` or like so:`instanceOfShiftFilterOption.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ShiftFilterOptionCWProxy get copyWith =>
      _$ShiftFilterOptionCWProxyImpl(this);
}
