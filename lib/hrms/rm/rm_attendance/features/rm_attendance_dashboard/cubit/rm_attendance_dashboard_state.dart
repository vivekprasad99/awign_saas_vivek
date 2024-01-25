import 'package:awign_saas/hrms/attendance/data/model/billing_cycle.dart';
import 'package:awign_saas/hrms/rm/rm_attendance/data/model/employee_attendance.dart';
import 'package:awign_saas/hrms/rm/rm_attendance/data/model/employee_attendance.dart';
import 'package:awign_saas/hrms/rm/rm_attendance/data/model/employee_attendance.dart';
import 'package:awign_saas/hrms/rm/rm_attendance/data/model/employee_attendance.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../core/data/model/ui_state.dart';
import '../../../../../attendance/data/model/attendance_response.dart';

part 'rm_attendance_dashboard_state.g.dart';

@CopyWith()
class RMAttendanceDashboardState extends Equatable {
  final UIState? uiState;
  final BillingCycle? selectedBillingCycle;
  final bool? isLoading;
  final int? currentTabIndex;
  final List<EmployeeAttendance>? presentList;
  final List<EmployeeAttendance>? absentList;
  final List<EmployeeAttendance>? leaveList;
  final List<EmployeeAttendance>? allAttendanceList;

  const RMAttendanceDashboardState({this.uiState, this.selectedBillingCycle, this.isLoading,
    this.currentTabIndex, this.presentList, this.absentList, this.leaveList, this.allAttendanceList});

  @override
  List<Object?> get props => [uiState, selectedBillingCycle, isLoading, currentTabIndex, presentList, absentList, leaveList, allAttendanceList];
}
