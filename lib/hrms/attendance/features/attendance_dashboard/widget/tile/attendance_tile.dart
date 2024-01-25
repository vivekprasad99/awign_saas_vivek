import 'package:awign_saas/hrms/attendance/data/model/attendance_response.dart';
import 'package:awign_saas/hrms/attendance/data/model/billing_cycle.dart';
import 'package:awign_saas/hrms/attendance/features/attendance_dashboard/widget/tile/absent_tile.dart';
import 'package:awign_saas/hrms/attendance/features/attendance_dashboard/widget/tile/leave_attendance_tile.dart';
import 'package:awign_saas/hrms/attendance/features/attendance_dashboard/widget/tile/present_tile.dart';
import 'package:awign_saas/hrms/attendance/features/attendance_dashboard/widget/tile/weekly_off_tile.dart';
import 'package:flutter/material.dart';

enum AttendanceTileAction {
  resolve,
}

class AttendanceTile extends StatelessWidget {
  final AttendanceDetails attendance;
  final BillingCycle? currentBillingCycle;
  final Function(BuildContext, AttendanceDetails, AttendanceTileAction, {AttendanceStatusEntity? attendanceStatusEntity}) onAttendanceAction;

  const AttendanceTile({required this.attendance, required this.currentBillingCycle, required this.onAttendanceAction, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (attendance.attendanceStatus == AttendanceStatus.present) {
      return PresentTile(attendanceDetails: attendance, currentBillingCycle: currentBillingCycle, onAttendanceAction: onAttendanceAction);
    } else if (attendance.attendanceStatus == AttendanceStatus.absent) {
      return AbsentTile(attendanceDetails: attendance, currentBillingCycle: currentBillingCycle, onAttendanceAction: onAttendanceAction);
    } else if (attendance.attendanceStatus == AttendanceStatus.leave) {
      return LeaveAttendanceTile(attendanceDetails: attendance, currentBillingCycle: currentBillingCycle, onAttendanceAction: onAttendanceAction);
    } else if (attendance.attendanceStatus == AttendanceStatus.weeklyOff) {
      return WeeklyOffTile(attendanceDetails: attendance);
    } else {
      return const SizedBox();
    }
  }
}
