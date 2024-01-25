import 'package:awign_saas/hrms/leaves/data/model/leave_balance_response.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../core/data/model/button_state.dart';
import '../../../../../../core/data/model/ui_state.dart';
import '../../../../../attendance/data/model/billing_cycle.dart';
import '../../../../../leaves/data/model/leave.dart';

part 'rm_leave_listing_state.g.dart';

@CopyWith()
class RMLeaveListingState extends Equatable {
  final UIState? uiState;
  final ButtonState? buttonState;
  final List<Leave>? leaves;
  final bool? isSearchLeavesLoading;
  final int? currentTabIndex;
  final BillingCycle? selectedBillingCycle;
  final bool? isLeaveBalanceLoading;
  final LeaveBalanceResponse? leaveBalanceResponse;

  const RMLeaveListingState(
      {this.uiState, this.buttonState, this.leaves, this.isSearchLeavesLoading,
        this.currentTabIndex, this.selectedBillingCycle, this.isLeaveBalanceLoading, this.leaveBalanceResponse});

  @override
  List<Object?> get props => [uiState, buttonState, leaves, isSearchLeavesLoading,
    currentTabIndex, selectedBillingCycle, isLeaveBalanceLoading, leaveBalanceResponse];
}
