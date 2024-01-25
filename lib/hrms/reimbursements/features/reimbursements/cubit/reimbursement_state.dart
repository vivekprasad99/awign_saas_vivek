import 'package:awign_saas/core/data/model/button_state.dart';
import 'package:awign_saas/core/data/model/ui_state.dart';
import 'package:awign_saas/hrms/attendance/data/model/billing_cycle.dart';
import 'package:awign_saas/hrms/reimbursements/data/model/reimbursement_response.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

part 'reimbursement_state.g.dart';

@CopyWith()
class ReimbursementState extends Equatable {
  final UIState? uiState;
  final ButtonState? buttonState;
  final ReimbursementResponse? reimbursementResponse;
  final bool? isSearchReimbursementLoading;
  final BillingCycle? selectedBillingCycle;
  final int? currentTabIndex;
  final List<Reimbursement>? pendingList;
  final List<Reimbursement>? approvedList;
  final List<Reimbursement>? rejectedList;

  const ReimbursementState(
      {this.uiState, this.buttonState,this.reimbursementResponse,this.isSearchReimbursementLoading,this.selectedBillingCycle,this.currentTabIndex,this.pendingList,this.approvedList,this.rejectedList});

  @override
  List<Object?> get props => [uiState, buttonState,reimbursementResponse,isSearchReimbursementLoading,selectedBillingCycle,currentTabIndex,pendingList,approvedList,rejectedList];
}
