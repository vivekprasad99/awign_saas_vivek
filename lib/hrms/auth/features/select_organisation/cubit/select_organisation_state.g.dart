// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'select_organisation_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SelectOrganisationStateCWProxy {
  SelectOrganisationState uiState(UIState? uiState);

  SelectOrganisationState user(User? user);

  SelectOrganisationState otpVerified(bool? otpVerified);

  SelectOrganisationState tenants(List<Tenant>? tenants);

  SelectOrganisationState buttonState(ButtonState? buttonState);

  SelectOrganisationState selectedTenant(Tenant? selectedTenant);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SelectOrganisationState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SelectOrganisationState(...).copyWith(id: 12, name: "My name")
  /// ````
  SelectOrganisationState call({
    UIState? uiState,
    User? user,
    bool? otpVerified,
    List<Tenant>? tenants,
    ButtonState? buttonState,
    Tenant? selectedTenant,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfSelectOrganisationState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfSelectOrganisationState.copyWith.fieldName(...)`
class _$SelectOrganisationStateCWProxyImpl
    implements _$SelectOrganisationStateCWProxy {
  const _$SelectOrganisationStateCWProxyImpl(this._value);

  final SelectOrganisationState _value;

  @override
  SelectOrganisationState uiState(UIState? uiState) => this(uiState: uiState);

  @override
  SelectOrganisationState user(User? user) => this(user: user);

  @override
  SelectOrganisationState otpVerified(bool? otpVerified) =>
      this(otpVerified: otpVerified);

  @override
  SelectOrganisationState tenants(List<Tenant>? tenants) =>
      this(tenants: tenants);

  @override
  SelectOrganisationState buttonState(ButtonState? buttonState) =>
      this(buttonState: buttonState);

  @override
  SelectOrganisationState selectedTenant(Tenant? selectedTenant) =>
      this(selectedTenant: selectedTenant);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SelectOrganisationState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SelectOrganisationState(...).copyWith(id: 12, name: "My name")
  /// ````
  SelectOrganisationState call({
    Object? uiState = const $CopyWithPlaceholder(),
    Object? user = const $CopyWithPlaceholder(),
    Object? otpVerified = const $CopyWithPlaceholder(),
    Object? tenants = const $CopyWithPlaceholder(),
    Object? buttonState = const $CopyWithPlaceholder(),
    Object? selectedTenant = const $CopyWithPlaceholder(),
  }) {
    return SelectOrganisationState(
      uiState: uiState == const $CopyWithPlaceholder()
          ? _value.uiState
          // ignore: cast_nullable_to_non_nullable
          : uiState as UIState?,
      user: user == const $CopyWithPlaceholder()
          ? _value.user
          // ignore: cast_nullable_to_non_nullable
          : user as User?,
      otpVerified: otpVerified == const $CopyWithPlaceholder()
          ? _value.otpVerified
          // ignore: cast_nullable_to_non_nullable
          : otpVerified as bool?,
      tenants: tenants == const $CopyWithPlaceholder()
          ? _value.tenants
          // ignore: cast_nullable_to_non_nullable
          : tenants as List<Tenant>?,
      buttonState: buttonState == const $CopyWithPlaceholder()
          ? _value.buttonState
          // ignore: cast_nullable_to_non_nullable
          : buttonState as ButtonState?,
      selectedTenant: selectedTenant == const $CopyWithPlaceholder()
          ? _value.selectedTenant
          // ignore: cast_nullable_to_non_nullable
          : selectedTenant as Tenant?,
    );
  }
}

extension $SelectOrganisationStateCopyWith on SelectOrganisationState {
  /// Returns a callable class that can be used as follows: `instanceOfSelectOrganisationState.copyWith(...)` or like so:`instanceOfSelectOrganisationState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SelectOrganisationStateCWProxy get copyWith =>
      _$SelectOrganisationStateCWProxyImpl(this);
}
