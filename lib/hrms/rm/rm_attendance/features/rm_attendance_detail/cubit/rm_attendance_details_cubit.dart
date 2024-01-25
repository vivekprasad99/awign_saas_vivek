import 'package:awign_saas/core/data/model/button_state.dart';
import 'package:awign_saas/hrms/attendance/data/model/punch_request.dart';
import 'package:awign_saas/hrms/rm/rm_attendance/data/model/employee_attendance.dart';
import 'package:bloc/bloc.dart';
import 'package:geocoding/geocoding.dart';

import 'rm_attendance_details_state.dart';


class RMAttendanceDetailsCubit extends Cubit<RMAttendanceDetailsState> {
  RMAttendanceDetailsCubit() : super(const RMAttendanceDetailsState(buttonState: ButtonState()));

  updateEmployeeAttendance(EmployeeAttendance employeeAttendance) {
    // emit(state.copyWith(employeeAttendance: employeeAttendance));
  }

  getAddressFromLatLong(Geolocation geolocation) async {
    emit(state.copyWith(isAddressLoading: true));
    List<Placemark> placeMarks = await placemarkFromCoordinates(geolocation.latitude ?? 0, geolocation.longitude ?? 0);
    emit(state.copyWith(placeMark: placeMarks[0], isAddressLoading: false));
  }
}
