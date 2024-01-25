import 'dart:async';

import 'package:awign_saas/hrms/attendance/data/model/today_attendance_status.dart';
import 'package:awign_saas/hrms/attendance/data/network/repository/attendance_remote_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:intl/intl.dart';
import '../../../../../../../core/data/local/database/model/current_user/work_location.dart';
import '../../../../../../../core/data/local/database/user_preferences/user_preferences.dart';
import '../../../../../../../core/data/model/button_state.dart';
import '../../../../../../../core/data/model/ui_state.dart';
import '../../../../../../../core/exception/exception.dart';
import '../../../../../../../core/location/location_helper.dart';
import '../../../../../../../core/utils/app_log.dart';
import '../../../../../../../core/utils/date_time_helper/date_time_helper.dart';
import '../../../../../../attendance/data/model/punch_request.dart';
import '../../../../../../attendance/data/model/punch_response.dart';
import 'mark_attendance_state.dart';

class MarkAttendanceCubit extends Cubit<MarkAttendanceState> {
  final AttendanceRemoteRepository _attendanceRemoteRepository;
  Timer? timer;
  MarkAttendanceCubit(this._attendanceRemoteRepository) : super(const MarkAttendanceState());

  void doPunchInPunchOut() async {
    try {
      emit(state.copyWith(buttonState: const ButtonState(isLoading: true)));
      Position? position;
      Geolocation? geolocation;
      if(state.attendanceType != null) {
        switch(state.attendanceType!) {
          case AttendanceType.normal:
            break;
          case AttendanceType.selfieAndGeo:
            break;
          case AttendanceType.geo:
            try {
              position = await LocationHelper.getCurrentLocation();
              if(state.workLocation?.punchRadius != null && state.workLocation?.latitude != null && state.workLocation?.longitude != null) {
                double distance = Geolocator.distanceBetween(state.workLocation!.latitude!, state.workLocation!.longitude!,
                    position.latitude, position.longitude);
                if(distance > state.workLocation!.punchRadius!.toDouble()) {
                  emit(state.copyWith(buttonState: const ButtonState(isEnable: true), uiState: UIState(event: Event.failed, failedWithoutAlertMessage: 'you_are_not_in_your_work_location'.tr)));
                  return;
                }
              }
              geolocation = Geolocation(latitude: position.latitude, longitude: position.longitude);
            } catch (e, st) {
              AppLog.e('doPunchInPunchOut : ${e.toString()} \n${st.toString()}');
              emit(state.copyWith(buttonState: const ButtonState(isEnable: false), uiState: UIState(event: Event.locationSetting)));
            }
            break;
          case AttendanceType.selfie:
            break;
        }
      }
      PunchRequest punchRequest = PunchRequest(punchType: state.punchType?.value, geolocation: geolocation);
      PunchResponse punchResponse = await _attendanceRemoteRepository.doPunchInPunchOut(punchRequest);
      emit(state.copyWith(buttonState: const ButtonState(isEnable: true)));
      getAttendanceStatus(null);
      await Future.delayed(const Duration(milliseconds: 500));
      emit(state.copyWith(uiState: UIState(event: Event.updated, successWithAlertMessage: punchResponse.message ?? '')));
    } on ServerException catch (e) {
      emit(state.copyWith(buttonState: const ButtonState(isEnable: true), uiState: UIState(event: Event.failed, failedWithoutAlertMessage: e.message!)));
    } on FailureException catch (e) {
      emit(state.copyWith(buttonState: const ButtonState(isEnable: true), uiState: UIState(event: Event.failed, failedWithoutAlertMessage: e.message!)));
    } catch (e, st) {
      AppLog.e('doPunchInPunchOut : ${e.toString()} \n${st.toString()}');
      if(!isClosed) {
        emit(state.copyWith(buttonState: const ButtonState(isEnable: true), uiState: UIState(event: Event.failed, failedWithoutAlertMessage: 'we_regret_the_technical_error'.tr)));
      }
    }
  }

  void getAttendanceStatus(Function? onLoadingComplete) async {
    try {
      TodayAttendanceStatus todayAttendanceStatus = await _attendanceRemoteRepository.getAttendanceStatus();
      String? lastPunchInTime = todayAttendanceStatus.getPunchInTime();
      String? lastPunchOutTime = todayAttendanceStatus.getPunchOutTime();
      Duration? duration = getDuration(lastPunchInTime, lastPunchOutTime);
      emit(state.copyWith(attendanceType: todayAttendanceStatus.attendanceType, lastPunchInTime: lastPunchInTime,
          lastPunchOutTime: lastPunchOutTime, duration: duration, punchType: todayAttendanceStatus.getNextPunchType(), workLocation: todayAttendanceStatus.workLocation));
      if(duration != null && lastPunchInTime != null) {
        if(lastPunchOutTime != null) {
          timer?.cancel();
        } else {
          startDurationTimer();
        }
      }
    } on ServerException catch (e) {
      emit(state.copyWith(buttonState: const ButtonState(isEnable: true),
          uiState: UIState(event: Event.failed, failedWithoutAlertMessage: e.message!)));
    } on FailureException catch (e) {
      emit(state.copyWith(buttonState: const ButtonState(isEnable: true),
          uiState: UIState(event: Event.failed, failedWithoutAlertMessage: e.message!)));
    } catch (e, st) {
      AppLog.e('getAttendanceStatus : ${e.toString()} \n${st.toString()}');
      if(!isClosed) {
        emit(state.copyWith(buttonState: const ButtonState(isEnable: true),
            uiState: UIState(event: Event.failed, failedWithoutAlertMessage: 'we_regret_the_technical_error'.tr)));
      }
    }
    if(onLoadingComplete != null) {
      onLoadingComplete();
    }
  }

  Duration? getDuration(String? lastPunchInTime, String? lastPunchOutTime) {
    if(lastPunchInTime != null) {
      DateTime punchInTime = DateFormat(DateTimeHelper.timeFormatHMS).parse(lastPunchInTime);
      DateTime now = DateTime.now();
      DateTime punchInDateTime = DateTime(now.year, now.month, now.day, punchInTime.hour, punchInTime.minute, punchInTime.second);
      if(lastPunchOutTime != null) {
        DateTime punchOutTime = DateFormat(DateTimeHelper.timeFormatHMS).parse(lastPunchOutTime);
        DateTime punchOutDateTime = DateTime(now.year, now.month, now.day, punchOutTime.hour, punchOutTime.minute, punchOutTime.second);
        Duration duration = punchOutDateTime.difference(punchInDateTime);
        return duration;
      } else {
        Duration duration = DateTime.now().difference(punchInDateTime);
        return duration;
      }
    } else {
      return null;
    }
  }

  startDurationTimer() {
    var interval = const Duration(seconds: 1);
    timer = Timer.periodic(interval, (timer) {
      int seconds = (state.duration?.inSeconds ?? 0) + 1;
      Duration duration = Duration(seconds: seconds);
      if(!isClosed) {
        emit(state.copyWith(duration: duration));
      }
    });
  }
}
