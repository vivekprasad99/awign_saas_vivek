import 'package:awign_saas/hrms/attendance/data/model/billing_cycle.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/data/model/ui_state.dart';
import '../../../data/model/attendance_response.dart';

part 'attendance_dashboard_state.g.dart';

@CopyWith()
class AttendanceDashboardState extends Equatable {
  final UIState? uiState;
  final BillingCycle? selectedBillingCycle;
  final bool? isLoading;
  final int? currentTabIndex;
  final List<AttendanceDetails>? presentList;
  final List<AttendanceDetails>? absentList;
  final List<AttendanceDetails>? leaveList;
  final List<AttendanceDetails>? allAttendanceList;

  const AttendanceDashboardState({this.uiState, this.selectedBillingCycle, this.isLoading,
    this.currentTabIndex, this.presentList, this.absentList, this.leaveList, this.allAttendanceList});

  @override
  List<Object?> get props => [uiState, selectedBillingCycle, isLoading, currentTabIndex, presentList, absentList, leaveList, allAttendanceList];
}
