import 'package:awign_saas/hrms/regularisation/data/model/regularisation_status_response.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/data/model/button_state.dart';
import '../../../../../core/data/model/ui_state.dart';
import '../../../../attendance/data/model/attendance_response.dart';
import '../../../../holidays/data/model/holiday_search_response.dart';
import '../../../data/model/leave_types_response.dart';

part 'apply_leave_state.g.dart';

@CopyWith()
class ApplyLeaveState extends Equatable {
  final UIState? uiState;
  final ButtonState? buttonState;
  final String? reason;
  final String? reasonError;
  final List<LeaveTypeEntity>? leaves;
  final LeaveTypeEntity? selectedLeaveTypeEntity;
  final DateTime? fromDate, toDate;
  final String? fromDateError;
  final String? toDateError;
  final ShiftType? selectedShiftType;
  final Map<String, dynamic>? leavesBalance;
  final String? leavesBalanceMessage;
  final AttendanceDetails? attendanceDetails;
  final bool? isLeaveBalanceLoading;
  final Regularisation? regularisation;
  final AttendanceStatusEntity? attendanceStatusEntity;

  const ApplyLeaveState(
      {this.uiState,
      this.buttonState,
      this.reason,
      this.reasonError,
      this.leaves,
      this.selectedLeaveTypeEntity,
      this.fromDate,
      this.toDate,
      this.fromDateError,
      this.toDateError,
      this.selectedShiftType,
      this.leavesBalance,
      this.leavesBalanceMessage,
      this.attendanceDetails,
      this.isLeaveBalanceLoading,
      this.regularisation,
      this.attendanceStatusEntity});

  @override
  List<Object?> get props => [
        uiState,
        buttonState,
        reason,
        reasonError,
        leaves,
        selectedLeaveTypeEntity,
        fromDate,
        toDate,
        fromDateError,
        toDateError,
        selectedShiftType,
        leavesBalance,
        leavesBalanceMessage,
        attendanceDetails,
        isLeaveBalanceLoading,
        regularisation,
        attendanceStatusEntity,
      ];
}
