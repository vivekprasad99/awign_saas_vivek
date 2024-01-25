import 'package:awign_saas/hrms/comp_off/data/model/comp_off.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/data/model/button_state.dart';
import '../../../../../core/data/model/ui_state.dart';
import '../../../../attendance/data/model/billing_cycle.dart';

part 'comp_off_listing_state.g.dart';

@CopyWith()
class CompOffListingState extends Equatable {
  final UIState? uiState;
  final List<CompOff>? pendingList;
  final List<CompOff>? approvedList;
  final List<CompOff>? rejectedList;
  final List<CompOff>? cancelledList;
  final bool? isLoading;
  final int? currentTabIndex;
  final BillingCycle? selectedBillingCycle;
  final bool? isCompOffBalanceLoading;
  final double? compOffBalance;

  const CompOffListingState(
      {this.uiState, this.pendingList, this.approvedList, this.rejectedList, this.cancelledList,
        this.isLoading, this.currentTabIndex, this.selectedBillingCycle, this.isCompOffBalanceLoading,
        this.compOffBalance});

  @override
  List<Object?> get props => [uiState, pendingList, approvedList, rejectedList, cancelledList,
    isLoading, currentTabIndex, selectedBillingCycle, isCompOffBalanceLoading, compOffBalance];
}
