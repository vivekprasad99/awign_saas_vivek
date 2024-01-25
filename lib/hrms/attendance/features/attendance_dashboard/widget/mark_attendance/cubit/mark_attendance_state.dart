import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../../core/data/local/database/model/current_user/work_location.dart';
import '../../../../../../../core/data/model/button_state.dart';
import '../../../../../../../core/data/model/ui_state.dart';
import '../../../../../../attendance/data/model/punch_request.dart';
import '../../../../../data/model/today_attendance_status.dart';

part 'mark_attendance_state.g.dart';

@CopyWith()
class MarkAttendanceState extends Equatable {
  final UIState? uiState;
  final ButtonState? buttonState;
  final PunchType? punchType;
  final String? lastPunchInTime;
  final String? lastPunchOutTime;
  final Duration? duration;
  final AttendanceType? attendanceType;
  final WorkLocation? workLocation;

  const MarkAttendanceState(
      {this.uiState, this.buttonState, this.punchType, this.lastPunchInTime,
        this.lastPunchOutTime, this.duration, this.attendanceType, this.workLocation});

  @override
  List<Object?> get props => [uiState, buttonState, punchType, lastPunchInTime,
    lastPunchOutTime, duration, attendanceType, workLocation];
}
