// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banner_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BannerStateCWProxy {
  BannerState uiState(UIState? uiState);

  BannerState currentPageIndex(int? currentPageIndex);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BannerState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BannerState(...).copyWith(id: 12, name: "My name")
  /// ````
  BannerState call({
    UIState? uiState,
    int? currentPageIndex,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfBannerState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfBannerState.copyWith.fieldName(...)`
class _$BannerStateCWProxyImpl implements _$BannerStateCWProxy {
  const _$BannerStateCWProxyImpl(this._value);

  final BannerState _value;

  @override
  BannerState uiState(UIState? uiState) => this(uiState: uiState);

  @override
  BannerState currentPageIndex(int? currentPageIndex) =>
      this(currentPageIndex: currentPageIndex);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BannerState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BannerState(...).copyWith(id: 12, name: "My name")
  /// ````
  BannerState call({
    Object? uiState = const $CopyWithPlaceholder(),
    Object? currentPageIndex = const $CopyWithPlaceholder(),
  }) {
    return BannerState(
      uiState: uiState == const $CopyWithPlaceholder()
          ? _value.uiState
          // ignore: cast_nullable_to_non_nullable
          : uiState as UIState?,
      currentPageIndex: currentPageIndex == const $CopyWithPlaceholder()
          ? _value.currentPageIndex
          // ignore: cast_nullable_to_non_nullable
          : currentPageIndex as int?,
    );
  }
}

extension $BannerStateCopyWith on BannerState {
  /// Returns a callable class that can be used as follows: `instanceOfBannerState.copyWith(...)` or like so:`instanceOfBannerState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BannerStateCWProxy get copyWith => _$BannerStateCWProxyImpl(this);
}
