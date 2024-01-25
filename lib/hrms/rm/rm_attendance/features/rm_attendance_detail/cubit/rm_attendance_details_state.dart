import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:geocoding/geocoding.dart';

import '../../../../../../core/data/model/button_state.dart';
import '../../../../../../core/data/model/ui_state.dart';
import '../../../data/model/employee_attendance.dart';

part 'rm_attendance_details_state.g.dart';

@CopyWith()
class RMAttendanceDetailsState extends Equatable {
  final UIState? uiState;
  final ButtonState? buttonState;
  final EmployeeAttendance? employeeAttendance;
  final Placemark? placeMark;
  final bool? isAddressLoading;

  const RMAttendanceDetailsState(
      {this.uiState, this.buttonState, this.employeeAttendance, this.placeMark, this.isAddressLoading});

  @override
  List<Object?> get props => [uiState, buttonState, employeeAttendance, placeMark, isAddressLoading];
}
