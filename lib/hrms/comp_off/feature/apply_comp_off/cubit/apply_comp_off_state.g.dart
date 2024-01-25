// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apply_comp_off_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ApplyCompOffStateCWProxy {
  ApplyCompOffState uiState(UIState? uiState);

  ApplyCompOffState buttonState(ButtonState? buttonState);

  ApplyCompOffState reason(String? reason);

  ApplyCompOffState reasonError(String? reasonError);

  ApplyCompOffState date(DateTime? date);

  ApplyCompOffState dateError(String? dateError);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ApplyCompOffState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ApplyCompOffState(...).copyWith(id: 12, name: "My name")
  /// ````
  ApplyCompOffState call({
    UIState? uiState,
    ButtonState? buttonState,
    String? reason,
    String? reasonError,
    DateTime? date,
    String? dateError,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfApplyCompOffState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfApplyCompOffState.copyWith.fieldName(...)`
class _$ApplyCompOffStateCWProxyImpl implements _$ApplyCompOffStateCWProxy {
  const _$ApplyCompOffStateCWProxyImpl(this._value);

  final ApplyCompOffState _value;

  @override
  ApplyCompOffState uiState(UIState? uiState) => this(uiState: uiState);

  @override
  ApplyCompOffState buttonState(ButtonState? buttonState) =>
      this(buttonState: buttonState);

  @override
  ApplyCompOffState reason(String? reason) => this(reason: reason);

  @override
  ApplyCompOffState reasonError(String? reasonError) =>
      this(reasonError: reasonError);

  @override
  ApplyCompOffState date(DateTime? date) => this(date: date);

  @override
  ApplyCompOffState dateError(String? dateError) => this(dateError: dateError);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ApplyCompOffState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ApplyCompOffState(...).copyWith(id: 12, name: "My name")
  /// ````
  ApplyCompOffState call({
    Object? uiState = const $CopyWithPlaceholder(),
    Object? buttonState = const $CopyWithPlaceholder(),
    Object? reason = const $CopyWithPlaceholder(),
    Object? reasonError = const $CopyWithPlaceholder(),
    Object? date = const $CopyWithPlaceholder(),
    Object? dateError = const $CopyWithPlaceholder(),
  }) {
    return ApplyCompOffState(
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
    );
  }
}

extension $ApplyCompOffStateCopyWith on ApplyCompOffState {
  /// Returns a callable class that can be used as follows: `instanceOfApplyCompOffState.copyWith(...)` or like so:`instanceOfApplyCompOffState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ApplyCompOffStateCWProxy get copyWith =>
      _$ApplyCompOffStateCWProxyImpl(this);
}
