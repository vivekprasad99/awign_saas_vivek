// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'billing_cycle_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BillingCycleStateCWProxy {
  BillingCycleState billingCycleList(List<BillingCycle>? billingCycleList);

  BillingCycleState selectedBillingCycle(BillingCycle? selectedBillingCycle);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BillingCycleState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BillingCycleState(...).copyWith(id: 12, name: "My name")
  /// ````
  BillingCycleState call({
    List<BillingCycle>? billingCycleList,
    BillingCycle? selectedBillingCycle,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfBillingCycleState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfBillingCycleState.copyWith.fieldName(...)`
class _$BillingCycleStateCWProxyImpl implements _$BillingCycleStateCWProxy {
  const _$BillingCycleStateCWProxyImpl(this._value);

  final BillingCycleState _value;

  @override
  BillingCycleState billingCycleList(List<BillingCycle>? billingCycleList) =>
      this(billingCycleList: billingCycleList);

  @override
  BillingCycleState selectedBillingCycle(BillingCycle? selectedBillingCycle) =>
      this(selectedBillingCycle: selectedBillingCycle);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BillingCycleState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BillingCycleState(...).copyWith(id: 12, name: "My name")
  /// ````
  BillingCycleState call({
    Object? billingCycleList = const $CopyWithPlaceholder(),
    Object? selectedBillingCycle = const $CopyWithPlaceholder(),
  }) {
    return BillingCycleState(
      billingCycleList: billingCycleList == const $CopyWithPlaceholder()
          ? _value.billingCycleList
          // ignore: cast_nullable_to_non_nullable
          : billingCycleList as List<BillingCycle>?,
      selectedBillingCycle: selectedBillingCycle == const $CopyWithPlaceholder()
          ? _value.selectedBillingCycle
          // ignore: cast_nullable_to_non_nullable
          : selectedBillingCycle as BillingCycle?,
    );
  }
}

extension $BillingCycleStateCopyWith on BillingCycleState {
  /// Returns a callable class that can be used as follows: `instanceOfBillingCycleState.copyWith(...)` or like so:`instanceOfBillingCycleState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BillingCycleStateCWProxy get copyWith =>
      _$BillingCycleStateCWProxyImpl(this);
}
