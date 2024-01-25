import 'package:awign_saas/core/data/model/button_state.dart';
import 'package:awign_saas/core/data/model/ui_state.dart';
import 'package:awign_saas/hrms/attendance/data/model/billing_cycle.dart';
import 'package:awign_saas/hrms/reimbursements/data/model/reimbursement_response.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

import '../../../data/model/rm_reimbursement_search_response.dart';

part 'rm_reimbursement_dashboard_state.g.dart';

@CopyWith()
class RmReimbursementDashboardState extends Equatable {
  final UIState? uiState;
  final BillingCycle? selectedBillingCycle;
  final bool? isLoading;
  final int? currentTabIndex;
  final RmReimbursementSearch? rmReimbursementSearch;
  final List<Reimbursements>? pendingList;
  final List<Reimbursements>? approvedList;
  final List<Reimbursements>? rejectedList;
  final List<Reimbursements>? allList;
  final ButtonState? buttonState;
  final bool? isStatusLoading;

  const RmReimbursementDashboardState(
      {this.uiState,
      this.selectedBillingCycle,
      this.isLoading,
      this.currentTabIndex,
      this.rmReimbursementSearch,
      this.buttonState,
      this.pendingList,
      this.approvedList,
      this.rejectedList,
      this.allList,this.isStatusLoading});

  @override
  List<Object?> get props => [
        uiState,
        selectedBillingCycle,
        isLoading,
        currentTabIndex,
        rmReimbursementSearch,
        buttonState,
        pendingList,
        approvedList,
        rejectedList,
        allList,
    isStatusLoading
      ];
}
