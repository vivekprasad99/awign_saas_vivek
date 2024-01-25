import 'package:awign_saas/hrms/attendance/data/model/billing_cycle.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../core/data/model/ui_state.dart';
import '../../../data/model/regularize_search_response.dart';

part 'rm_regularisation_dashboard_state.g.dart';

@CopyWith()
class RMRegularisationDashboardState extends Equatable {
  final UIState? uiState;
  final BillingCycle? selectedBillingCycle;
  final bool? isLoading;
  final int? currentTabIndex;
  final List<Regularization>? pendingList;
  final List<Regularization>? approvedList;
  final List<Regularization>? rejectedList;
  final List<Regularization>? allList;

  const RMRegularisationDashboardState({this.uiState, this.selectedBillingCycle, this.isLoading,
    this.currentTabIndex, this.pendingList,this.approvedList,this.rejectedList,this.allList});

  @override
  List<Object?> get props => [uiState, selectedBillingCycle, isLoading, currentTabIndex, pendingList,approvedList,rejectedList,allList];
}
