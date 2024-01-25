import 'package:awign_saas/hrms/attendance/data/model/billing_cycle.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/data/model/ui_state.dart';
import '../../../data/model/attendance_response.dart';

part 'regularisation_alert_state.g.dart';

@CopyWith()
class RegularisationAlertState extends Equatable {
  final UIState? uiState;
  final bool? isLoading;
  final int? pendingRegularisationCount;

  const RegularisationAlertState({this.uiState, this.isLoading, this.pendingRegularisationCount});

  @override
  List<Object?> get props => [uiState, isLoading, pendingRegularisationCount];
}
