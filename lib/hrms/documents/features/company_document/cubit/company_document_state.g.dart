// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_document_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CompanyDocumentStateCWProxy {
  CompanyDocumentState uiState(UIState? uiState);

  CompanyDocumentState buttonState(ButtonState? buttonState);

  CompanyDocumentState isSearchDocumentLoading(bool? isSearchDocumentLoading);

  CompanyDocumentState documents(List<Documents>? documents);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CompanyDocumentState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CompanyDocumentState(...).copyWith(id: 12, name: "My name")
  /// ````
  CompanyDocumentState call({
    UIState? uiState,
    ButtonState? buttonState,
    bool? isSearchDocumentLoading,
    List<Documents>? documents,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCompanyDocumentState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCompanyDocumentState.copyWith.fieldName(...)`
class _$CompanyDocumentStateCWProxyImpl
    implements _$CompanyDocumentStateCWProxy {
  const _$CompanyDocumentStateCWProxyImpl(this._value);

  final CompanyDocumentState _value;

  @override
  CompanyDocumentState uiState(UIState? uiState) => this(uiState: uiState);

  @override
  CompanyDocumentState buttonState(ButtonState? buttonState) =>
      this(buttonState: buttonState);

  @override
  CompanyDocumentState isSearchDocumentLoading(bool? isSearchDocumentLoading) =>
      this(isSearchDocumentLoading: isSearchDocumentLoading);

  @override
  CompanyDocumentState documents(List<Documents>? documents) =>
      this(documents: documents);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CompanyDocumentState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CompanyDocumentState(...).copyWith(id: 12, name: "My name")
  /// ````
  CompanyDocumentState call({
    Object? uiState = const $CopyWithPlaceholder(),
    Object? buttonState = const $CopyWithPlaceholder(),
    Object? isSearchDocumentLoading = const $CopyWithPlaceholder(),
    Object? documents = const $CopyWithPlaceholder(),
  }) {
    return CompanyDocumentState(
      uiState: uiState == const $CopyWithPlaceholder()
          ? _value.uiState
          // ignore: cast_nullable_to_non_nullable
          : uiState as UIState?,
      buttonState: buttonState == const $CopyWithPlaceholder()
          ? _value.buttonState
          // ignore: cast_nullable_to_non_nullable
          : buttonState as ButtonState?,
      isSearchDocumentLoading:
          isSearchDocumentLoading == const $CopyWithPlaceholder()
              ? _value.isSearchDocumentLoading
              // ignore: cast_nullable_to_non_nullable
              : isSearchDocumentLoading as bool?,
      documents: documents == const $CopyWithPlaceholder()
          ? _value.documents
          // ignore: cast_nullable_to_non_nullable
          : documents as List<Documents>?,
    );
  }
}

extension $CompanyDocumentStateCopyWith on CompanyDocumentState {
  /// Returns a callable class that can be used as follows: `instanceOfCompanyDocumentState.copyWith(...)` or like so:`instanceOfCompanyDocumentState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CompanyDocumentStateCWProxy get copyWith =>
      _$CompanyDocumentStateCWProxyImpl(this);
}
