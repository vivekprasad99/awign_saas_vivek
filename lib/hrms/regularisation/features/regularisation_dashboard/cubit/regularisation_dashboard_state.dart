import 'package:awign_saas/hrms/attendance/data/model/billing_cycle.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/data/model/ui_state.dart';
import '../../../data/model/regularisation_status_response.dart';

part 'regularisation_dashboard_state.g.dart';

@CopyWith()
class RegularisationDashboardState extends Equatable {
  final UIState? uiState;
  final BillingCycle? selectedBillingCycle;
  final bool? isLoading;
  final int? currentTabIndex;
  final List<Regularisation>? regularisationList;

  const RegularisationDashboardState({this.uiState, this.selectedBillingCycle, this.isLoading,
    this.currentTabIndex, this.regularisationList});

  @override
  List<Object?> get props => [uiState, selectedBillingCycle, isLoading, currentTabIndex, regularisationList];
}
