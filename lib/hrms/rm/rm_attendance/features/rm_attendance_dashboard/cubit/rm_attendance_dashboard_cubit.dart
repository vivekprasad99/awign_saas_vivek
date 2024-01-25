import 'package:awign_saas/hrms/rm/rm_attendance/data/model/employee_attendance.dart';
import 'package:bloc/bloc.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import '../../../../../../core/data/model/ui_state.dart';
import '../../../../../../core/exception/exception.dart';
import '../../../../../../core/utils/app_log.dart';
import '../../../../../../core/utils/date_time_helper/date_time_helper.dart';
import '../../../../../attendance/data/model/billing_cycle.dart';
import '../../../../../attendance/data/model/date_range_request.dart';
import '../../../data/network/repository/rm_attendance_remote_repository.dart';
import 'rm_attendance_dashboard_state.dart';

class RMAttendanceDashboardCubit extends Cubit<RMAttendanceDashboardState> {
  final RMAttendanceRemoteRepository _rmAttendanceRemoteRepository;
  RMAttendanceDashboardCubit(this._rmAttendanceRemoteRepository) : super(const RMAttendanceDashboardState(currentTabIndex: 0));

  void updateCurrentTabIndex(int currentTabIndex) {
    emit(state.copyWith(currentTabIndex: currentTabIndex));
  }

  void updateSelectedBillingCycle(BillingCycle? selectedBillingCycle) {
    emit(state.copyWith(selectedBillingCycle: selectedBillingCycle));
    getAttendanceStatusByDateRange();
  }

  void getAttendanceStatusByDateRange() async {
    try {
      if(state.selectedBillingCycle == null) {
        return;
      }
      emit(state.copyWith(isLoading: true));
      DateRangeRequest dateRangeRequest = DateRangeRequest(
          startDate: DateTimeHelper.getFormattedDateTime(DateTimeHelper.dateFormatYMD, inputDateTime: DateTime.now()),
          endDate: DateTimeHelper.getFormattedDateTime(DateTimeHelper.dateFormatYMD, inputDateTime: DateTime.now()));
      List<EmployeeAttendance>? employeeAttendanceList = await _rmAttendanceRemoteRepository.getEmployeesAttendanceStatus(dateRangeRequest);
      emit(state.copyWith(isLoading: false, presentList: getPresentEmployeeList(employeeAttendanceList), absentList: getAbsentEmployeeList(employeeAttendanceList),
          leaveList: getLeaveEmployeeList(employeeAttendanceList), allAttendanceList: employeeAttendanceList));
    } on ServerException catch (e) {
      emit(state.copyWith(isLoading: false, presentList: null, absentList: null,
          leaveList: null, allAttendanceList: null, uiState: UIState(event: Event.failed, failedWithoutAlertMessage: e.message!)));
    } on FailureException catch (e) {
      emit(state.copyWith(isLoading: false, presentList: null, absentList: null,
          leaveList: null, allAttendanceList: null, uiState: UIState(event: Event.failed, failedWithoutAlertMessage: e.message!)));
    } catch (e, st) {
      AppLog.e('getAttendanceStatus : ${e.toString()} \n${st.toString()}');
      emit(state.copyWith(isLoading: false, presentList: null, absentList: null,
          leaveList: null, allAttendanceList: null, uiState: UIState(event: Event.failed, failedWithoutAlertMessage: 'we_regret_the_technical_error'.tr)));
    }
  }

  List<EmployeeAttendance>? getAbsentEmployeeList(List<EmployeeAttendance>? allEmployeeAttendanceList) {
    return allEmployeeAttendanceList?.where(_checkIsEmployeeAbsent).toList();
  }

  bool _checkIsEmployeeAbsent(EmployeeAttendance employeeAttendance) {
    if(employeeAttendance.attendanceDetails != null && (employeeAttendance.attendanceDetails?.firstOrNull?.checkIsAbsentInAnySection() ?? false)) {
      return true;
    } else {
      return false;
    }
  }

  List<EmployeeAttendance>? getPresentEmployeeList(List<EmployeeAttendance>? allEmployeeAttendanceList) {
    return allEmployeeAttendanceList?.where(_checkIsEmployeePresent).toList();
  }

  bool _checkIsEmployeePresent(EmployeeAttendance employeeAttendance) {
    if(employeeAttendance.attendanceDetails != null && (employeeAttendance.attendanceDetails?.firstOrNull?.checkIsPresentInAnySection() ?? false)) {
      return true;
    } else {
      return false;
    }
  }

  List<EmployeeAttendance>? getLeaveEmployeeList(List<EmployeeAttendance>? allEmployeeAttendanceList) {
    return allEmployeeAttendanceList?.where(_checkIsEmployeeOnLeave).toList();
  }

  bool _checkIsEmployeeOnLeave(EmployeeAttendance employeeAttendance) {
    if(employeeAttendance.attendanceDetails != null && (employeeAttendance.attendanceDetails?.firstOrNull?.checkIsLeaveInAnySection() ?? false)) {
      return true;
    } else {
      return false;
    }
  }
}
