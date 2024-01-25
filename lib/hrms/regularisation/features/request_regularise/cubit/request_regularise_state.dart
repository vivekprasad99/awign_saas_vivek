import 'package:awign_saas/hrms/attendance/data/model/attendance_response.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../../core/data/model/button_state.dart';
import '../../../../../core/data/model/ui_state.dart';
import '../../../../reimbursements/data/model/manager_response.dart';

part 'request_regularise_state.g.dart';

@CopyWith()
class RequestRegulariseState extends Equatable {
  final UIState? uiState;
  final ButtonState? buttonState;
  final String? reason;
  final String? reasonError;
  final DateTime? date;
  final TimeOfDay? punchInTimeOfDay;
  final String? punchInTimeError;
  final TimeOfDay? punchOutTimeOfDay;
  final String? punchOutTimeError;
  final List<Manager>? managers;
  final Manager? selectedManager;
  final AttendanceDetails? attendanceDetails;
  final AttendanceStatusEntity? attendanceStatusEntity;

  const RequestRegulariseState(
      {this.uiState,
      this.buttonState,
      this.reason,
      this.reasonError,
      this.date,
      this.punchInTimeOfDay,
      this.punchOutTimeOfDay,
      this.managers,
      this.selectedManager,
      this.punchInTimeError,
      this.punchOutTimeError,
      this.attendanceDetails,
      this.attendanceStatusEntity,
      });

  @override
  List<Object?> get props => [
        uiState,
        buttonState,
        reason,
        reasonError,
        date,
        punchInTimeOfDay,
        punchOutTimeOfDay,
        managers,
        selectedManager,
        punchInTimeError,
        punchOutTimeError,
        attendanceDetails,
        attendanceStatusEntity,
      ];
}
