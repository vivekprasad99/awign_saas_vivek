// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'faq_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$FaqStateCWProxy {
  FaqState uiState(UIState? uiState);

  FaqState buttonState(ButtonState? buttonState);

  FaqState navbar(List<NavBarData>? navbar);

  FaqState isSelected(bool isSelected);

  FaqState isSearchFaqLoading(bool? isSearchFaqLoading);

  FaqState faqs(List<Faqs>? faqs);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `FaqState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// FaqState(...).copyWith(id: 12, name: "My name")
  /// ````
  FaqState call({
    UIState? uiState,
    ButtonState? buttonState,
    List<NavBarData>? navbar,
    bool? isSelected,
    bool? isSearchFaqLoading,
    List<Faqs>? faqs,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfFaqState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfFaqState.copyWith.fieldName(...)`
class _$FaqStateCWProxyImpl implements _$FaqStateCWProxy {
  const _$FaqStateCWProxyImpl(this._value);

  final FaqState _value;

  @override
  FaqState uiState(UIState? uiState) => this(uiState: uiState);

  @override
  FaqState buttonState(ButtonState? buttonState) =>
      this(buttonState: buttonState);

  @override
  FaqState navbar(List<NavBarData>? navbar) => this(navbar: navbar);

  @override
  FaqState isSelected(bool isSelected) => this(isSelected: isSelected);

  @override
  FaqState isSearchFaqLoading(bool? isSearchFaqLoading) =>
      this(isSearchFaqLoading: isSearchFaqLoading);

  @override
  FaqState faqs(List<Faqs>? faqs) => this(faqs: faqs);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `FaqState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// FaqState(...).copyWith(id: 12, name: "My name")
  /// ````
  FaqState call({
    Object? uiState = const $CopyWithPlaceholder(),
    Object? buttonState = const $CopyWithPlaceholder(),
    Object? navbar = const $CopyWithPlaceholder(),
    Object? isSelected = const $CopyWithPlaceholder(),
    Object? isSearchFaqLoading = const $CopyWithPlaceholder(),
    Object? faqs = const $CopyWithPlaceholder(),
  }) {
    return FaqState(
      uiState: uiState == const $CopyWithPlaceholder()
          ? _value.uiState
          // ignore: cast_nullable_to_non_nullable
          : uiState as UIState?,
      buttonState: buttonState == const $CopyWithPlaceholder()
          ? _value.buttonState
          // ignore: cast_nullable_to_non_nullable
          : buttonState as ButtonState?,
      navbar: navbar == const $CopyWithPlaceholder()
          ? _value.navbar
          // ignore: cast_nullable_to_non_nullable
          : navbar as List<NavBarData>?,
      isSelected:
          isSelected == const $CopyWithPlaceholder() || isSelected == null
              ? _value.isSelected
              // ignore: cast_nullable_to_non_nullable
              : isSelected as bool,
      isSearchFaqLoading: isSearchFaqLoading == const $CopyWithPlaceholder()
          ? _value.isSearchFaqLoading
          // ignore: cast_nullable_to_non_nullable
          : isSearchFaqLoading as bool?,
      faqs: faqs == const $CopyWithPlaceholder()
          ? _value.faqs
          // ignore: cast_nullable_to_non_nullable
          : faqs as List<Faqs>?,
    );
  }
}

extension $FaqStateCopyWith on FaqState {
  /// Returns a callable class that can be used as follows: `instanceOfFaqState.copyWith(...)` or like so:`instanceOfFaqState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$FaqStateCWProxy get copyWith => _$FaqStateCWProxyImpl(this);
}
