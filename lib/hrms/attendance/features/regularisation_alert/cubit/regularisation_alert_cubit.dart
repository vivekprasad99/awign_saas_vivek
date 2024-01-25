import 'package:awign_saas/hrms/attendance/data/model/billing_cycle.dart';
import 'package:awign_saas/hrms/attendance/features/attendance_dashboard/widget/billing_cycle/cubit/billing_cycle_cubit.dart';
import 'package:awign_saas/hrms/leaves/data/model/leave.dart';
import 'package:awign_saas/hrms/regularisation/data/model/regularisation_status_response.dart';
import 'package:bloc/bloc.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import '../../../../../core/data/model/ui_state.dart';
import '../../../../../core/exception/exception.dart';
import '../../../../../core/utils/app_log.dart';
import '../../../../../core/utils/date_time_helper/date_time_helper.dart';
import '../../../data/model/attendance_response.dart';
import '../../../data/model/date_range_request.dart';
import '../../../data/network/repository/attendance_remote_repository.dart';
import 'regularisation_alert_state.dart';

class RegularisationAlertCubit extends Cubit<RegularisationAlertState> {
  final AttendanceRemoteRepository _attendanceRemoteRepository;
  RegularisationAlertCubit(this._attendanceRemoteRepository) : super(const RegularisationAlertState());

  void getAttendanceStatusByDateRange() async {
    try {
      BillingCycleCubit billingCycleCubit = BillingCycleCubit();
      billingCycleCubit.loadBillingCycle(false, null);
      BillingCycle? selectedBillingCycle = billingCycleCubit.getCurrentBillingCycle();
      String strStartDate = DateTimeHelper.getFormattedDateTime(DateTimeHelper.dateFormatYMD, inputDateTime: selectedBillingCycle!.startDate);
      String strEndDate = DateTimeHelper.getFormattedDateTime(DateTimeHelper.dateFormatYMD, inputDateTime: selectedBillingCycle.endDate);
      DateTime now = DateTime.now();
      if(selectedBillingCycle.endDate!.isAfter(now)) {
        strEndDate = DateTimeHelper.getFormattedDateTime(DateTimeHelper.dateFormatYMD, inputDateTime: DateTime(now.year, now.month, now.day - 1));
      }
      emit(state.copyWith(isLoading: true));
      DateRangeRequest dateRangeRequest = DateRangeRequest(
          startDate: strStartDate,
          endDate: strEndDate);
      AttendanceResponse attendanceResponse = await _attendanceRemoteRepository.getAttendanceStatusByDateRange(dateRangeRequest);
      emit(state.copyWith(isLoading: false, pendingRegularisationCount: _getPendingRegularisationCount(attendanceResponse)));
    } on ServerException catch (e) {
      emit(state.copyWith(isLoading: false, pendingRegularisationCount: null, uiState: UIState(event: Event.failed, failedWithoutAlertMessage: e.message!)));
    } on FailureException catch (e) {
      emit(state.copyWith(isLoading: false, pendingRegularisationCount: null, uiState: UIState(event: Event.failed, failedWithoutAlertMessage: e.message!)));
    } catch (e, st) {
      AppLog.e('getAttendanceStatus : ${e.toString()} \n${st.toString()}');
      if(!isClosed) {
        emit(state.copyWith(isLoading: false, pendingRegularisationCount: null, uiState: UIState(event: Event.failed, failedWithoutAlertMessage: 'we_regret_the_technical_error'.tr)));
      }
    }
  }

  int? _getPendingRegularisationCount(AttendanceResponse attendanceResponse) {
    return attendanceResponse.attendanceDetails?.where(_checkIsAbsentAndLeaveOrRegulariseRequested).toList().length;
  }

  bool _checkIsAbsentAndLeaveOrRegulariseRequested(AttendanceDetails attendanceDetails) {
    bool isAbsentInAnySection = attendanceDetails.checkIsAbsentInAnySection();
    bool isLeaveNotInAnySection = false;
    bool isRegularizeNotInAnySection = false;
    if(isAbsentInAnySection) {
      attendanceDetails.attendanceStatus = AttendanceStatus.absent;
      for(AttendanceStatusEntity attendanceStatusEntity in attendanceDetails.status ?? []) {
        if(attendanceStatusEntity.attendanceStatus == AttendanceStatus.leave
            && attendanceStatusEntity.leave != null && (attendanceStatusEntity.leave?.status == LeaveStatus.rejected
            || attendanceStatusEntity.leave?.status == LeaveStatus.withdrawn)) {
          isLeaveNotInAnySection = true;
        }
      }
      for(AttendanceStatusEntity attendanceStatusEntity in attendanceDetails.status ?? []) {
        if(attendanceStatusEntity.regularization != null && (attendanceStatusEntity.regularization?.status == RegularisationStatus.rejected
            || attendanceStatusEntity.regularization?.status == RegularisationStatus.withdrawn)) {
          isRegularizeNotInAnySection = true;
        }
      }
    }
    return (isAbsentInAnySection && !(isLeaveNotInAnySection || isRegularizeNotInAnySection));
  }
}
