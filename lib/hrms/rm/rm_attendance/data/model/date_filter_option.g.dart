// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'date_filter_option.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DateFilterOptionCWProxy {
  DateFilterOption label(String? label);

  DateFilterOption isSelected(bool? isSelected);

  DateFilterOption groupValue(int? groupValue);

  DateFilterOption customDateTime(DateTime? customDateTime);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DateFilterOption(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DateFilterOption(...).copyWith(id: 12, name: "My name")
  /// ````
  DateFilterOption call({
    String? label,
    bool? isSelected,
    int? groupValue,
    DateTime? customDateTime,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfDateFilterOption.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfDateFilterOption.copyWith.fieldName(...)`
class _$DateFilterOptionCWProxyImpl implements _$DateFilterOptionCWProxy {
  const _$DateFilterOptionCWProxyImpl(this._value);

  final DateFilterOption _value;

  @override
  DateFilterOption label(String? label) => this(label: label);

  @override
  DateFilterOption isSelected(bool? isSelected) => this(isSelected: isSelected);

  @override
  DateFilterOption groupValue(int? groupValue) => this(groupValue: groupValue);

  @override
  DateFilterOption customDateTime(DateTime? customDateTime) =>
      this(customDateTime: customDateTime);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DateFilterOption(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DateFilterOption(...).copyWith(id: 12, name: "My name")
  /// ````
  DateFilterOption call({
    Object? label = const $CopyWithPlaceholder(),
    Object? isSelected = const $CopyWithPlaceholder(),
    Object? groupValue = const $CopyWithPlaceholder(),
    Object? customDateTime = const $CopyWithPlaceholder(),
  }) {
    return DateFilterOption(
      label == const $CopyWithPlaceholder()
          ? _value.label
          // ignore: cast_nullable_to_non_nullable
          : label as String?,
      isSelected == const $CopyWithPlaceholder()
          ? _value.isSelected
          // ignore: cast_nullable_to_non_nullable
          : isSelected as bool?,
      groupValue == const $CopyWithPlaceholder()
          ? _value.groupValue
          // ignore: cast_nullable_to_non_nullable
          : groupValue as int?,
      customDateTime == const $CopyWithPlaceholder()
          ? _value.customDateTime
          // ignore: cast_nullable_to_non_nullable
          : customDateTime as DateTime?,
    );
  }
}

extension $DateFilterOptionCopyWith on DateFilterOption {
  /// Returns a callable class that can be used as follows: `instanceOfDateFilterOption.copyWith(...)` or like so:`instanceOfDateFilterOption.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DateFilterOptionCWProxy get copyWith => _$DateFilterOptionCWProxyImpl(this);
}
