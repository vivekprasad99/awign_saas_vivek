import 'package:awign_saas/hrms/attendance/data/model/attendance_response.dart';
import 'package:awign_saas/hrms/attendance/data/model/date_range_request.dart';
import 'package:awign_saas/hrms/attendance/data/model/billing_cycle.dart';
import 'package:awign_saas/hrms/attendance/data/network/repository/attendance_remote_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import '../../../../../core/data/model/ui_state.dart';
import '../../../../../core/exception/exception.dart';
import '../../../../../core/utils/app_log.dart';
import '../../../../../core/utils/date_time_helper/date_time_helper.dart';
import 'attendance_dashboard_state.dart';

class AttendanceDashboardCubit extends Cubit<AttendanceDashboardState> {
  final AttendanceRemoteRepository _attendanceRemoteRepository;
  AttendanceDashboardCubit(this._attendanceRemoteRepository) : super(const AttendanceDashboardState(currentTabIndex: 0));

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
      String strStartDate = DateTimeHelper.getFormattedDateTime(DateTimeHelper.dateFormatYMD,
          inputDateTime: state.selectedBillingCycle!.startDate);
      String strEndDate = DateTimeHelper.getFormattedDateTime(DateTimeHelper.dateFormatYMD,
          inputDateTime: state.selectedBillingCycle!.endDate);
      DateTime now = DateTime.now();
      if(state.selectedBillingCycle!.endDate!.isAfter(now)) {
        strEndDate = DateTimeHelper.getFormattedDateTime(DateTimeHelper.dateFormatYMD,
            inputDateTime: DateTime(now.year, now.month, now.day));
      }
      DateRangeRequest dateRangeRequest = DateRangeRequest(
          startDate: strStartDate,
          endDate: strEndDate);
      AttendanceResponse attendanceResponse = await _attendanceRemoteRepository.getAttendanceStatusByDateRange(dateRangeRequest);
      emit(state.copyWith(isLoading: false, absentList: getAbsentList(attendanceResponse),
        leaveList: getLeaveList(attendanceResponse),
          presentList: getPresentList(attendanceResponse),
          allAttendanceList: getAllAttendanceList(attendanceResponse)));
    } on ServerException catch (e) {
      emit(state.copyWith(isLoading: false, presentList: null, absentList: null,
          leaveList: null, allAttendanceList: null, uiState: UIState(event: Event.failed,
              failedWithoutAlertMessage: e.message!)));
    } on FailureException catch (e) {
      emit(state.copyWith(isLoading: false, presentList: null, absentList: null,
          leaveList: null, allAttendanceList: null, uiState: UIState(event: Event.failed,
              failedWithoutAlertMessage: e.message!)));
    } catch (e, st) {
      AppLog.e('getAttendanceStatus : ${e.toString()} \n${st.toString()}');
      emit(state.copyWith(isLoading: false, presentList: null, absentList: null,
          leaveList: null, allAttendanceList: null, uiState: UIState(event: Event.failed,
              failedWithoutAlertMessage: 'we_regret_the_technical_error'.tr)));
    }
  }

  List<AttendanceDetails>? getAbsentList(AttendanceResponse attendanceResponse) {
    List<AttendanceDetails> absentList = [];
    for(AttendanceDetails attendanceDetails in attendanceResponse.attendanceDetails ?? []) {
      if(attendanceDetails.checkIsAbsentInAnySection()) {
        attendanceDetails.attendanceStatus = AttendanceStatus.absent;
        absentList.add(attendanceDetails);
      }
    }
    return absentList.isEmpty ? null : absentList;
  }

  List<AttendanceDetails>? getPresentList(AttendanceResponse attendanceResponse) {
    List<AttendanceDetails> presentList = [];
    for(AttendanceDetails attendanceDetails in attendanceResponse.attendanceDetails ?? []) {
      if(attendanceDetails.checkIsPresentInAnySection()) {
        attendanceDetails.attendanceStatus = AttendanceStatus.present;
        presentList.add(attendanceDetails);
      }
    }
    return presentList.isEmpty ? null : presentList;
  }

  List<AttendanceDetails>? getLeaveList(AttendanceResponse attendanceResponse) {
    List<AttendanceDetails> leaveList = [];
    for(AttendanceDetails attendanceDetails in attendanceResponse.attendanceDetails ?? []) {
      if(attendanceDetails.checkIsLeaveInAnySection()) {
        attendanceDetails.attendanceStatus = AttendanceStatus.leave;
        leaveList.add(attendanceDetails);
      }
    }
    return leaveList.isEmpty ? null : leaveList;
  }

  List<AttendanceDetails>? getAllAttendanceList(AttendanceResponse attendanceResponse) {
    List<AttendanceDetails> allAttendanceList = [];
    for(AttendanceDetails attendanceDetails in attendanceResponse.attendanceDetails ?? []) {
      if(attendanceDetails.checkIsShiftAssignedInAllSection()) {
        if(attendanceDetails.checkIsAbsentInAnySection()) {
          attendanceDetails.attendanceStatus = AttendanceStatus.absent;
        } else if(attendanceDetails.checkIsLeaveInAnySection()) {
          attendanceDetails.attendanceStatus = AttendanceStatus.leave;
        } else if(attendanceDetails.checkIsWeeklyOffInAnySection()) {
          attendanceDetails.attendanceStatus = AttendanceStatus.weeklyOff;
        } else if(attendanceDetails.checkIsPresentInAnySection()) {
          attendanceDetails.attendanceStatus = AttendanceStatus.present;
        }
        allAttendanceList.add(attendanceDetails);
      }
    }
    return allAttendanceList.isEmpty ? null : allAttendanceList;
  }
}
