import 'package:awign_saas/hrms/attendance/data/model/billing_cycle.dart';
import 'package:awign_saas/hrms/comp_off/data/model/comp_off.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import '../../../../../../core/data/model/ui_state.dart';

part 'rm_comp_off_listing_state.g.dart';

@CopyWith()
class RMCompOffListingState extends Equatable {
  final UIState? uiState;
  final BillingCycle? selectedBillingCycle;
  final bool? isLoading;
  final int? currentTabIndex;
  final List<CompOff>? pendingList;
  final List<CompOff>? approvedList;
  final List<CompOff>? rejectedList;
  final List<CompOff>? allList;

  const RMCompOffListingState({this.uiState, this.selectedBillingCycle, this.isLoading,
    this.currentTabIndex, this.pendingList,this.approvedList,this.rejectedList,this.allList});

  @override
  List<Object?> get props => [uiState, selectedBillingCycle, isLoading, currentTabIndex, pendingList,approvedList,rejectedList,allList];
}
