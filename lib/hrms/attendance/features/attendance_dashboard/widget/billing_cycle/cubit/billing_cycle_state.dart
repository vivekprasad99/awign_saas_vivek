import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

import '../../../../../data/model/billing_cycle.dart';

part 'billing_cycle_state.g.dart';

@CopyWith()
class BillingCycleState extends Equatable {
  final List<BillingCycle>? billingCycleList;
  final BillingCycle? selectedBillingCycle;

  const BillingCycleState({this.billingCycleList, this.selectedBillingCycle});

  @override
  List<Object?> get props => [billingCycleList, selectedBillingCycle];
}
