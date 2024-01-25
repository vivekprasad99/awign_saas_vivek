// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'splash_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SplashStateCWProxy {
  SplashState uiState(UIState? uiState);

  SplashState isTimerCompleted(bool? isTimerCompleted);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SplashState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SplashState(...).copyWith(id: 12, name: "My name")
  /// ````
  SplashState call({
    UIState? uiState,
    bool? isTimerCompleted,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfSplashState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfSplashState.copyWith.fieldName(...)`
class _$SplashStateCWProxyImpl implements _$SplashStateCWProxy {
  const _$SplashStateCWProxyImpl(this._value);

  final SplashState _value;

  @override
  SplashState uiState(UIState? uiState) => this(uiState: uiState);

  @override
  SplashState isTimerCompleted(bool? isTimerCompleted) =>
      this(isTimerCompleted: isTimerCompleted);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SplashState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SplashState(...).copyWith(id: 12, name: "My name")
  /// ````
  SplashState call({
    Object? uiState = const $CopyWithPlaceholder(),
    Object? isTimerCompleted = const $CopyWithPlaceholder(),
  }) {
    return SplashState(
      uiState: uiState == const $CopyWithPlaceholder()
          ? _value.uiState
          // ignore: cast_nullable_to_non_nullable
          : uiState as UIState?,
      isTimerCompleted: isTimerCompleted == const $CopyWithPlaceholder()
          ? _value.isTimerCompleted
          // ignore: cast_nullable_to_non_nullable
          : isTimerCompleted as bool?,
    );
  }
}

extension $SplashStateCopyWith on SplashState {
  /// Returns a callable class that can be used as follows: `instanceOfSplashState.copyWith(...)` or like so:`instanceOfSplashState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SplashStateCWProxy get copyWith => _$SplashStateCWProxyImpl(this);
}
