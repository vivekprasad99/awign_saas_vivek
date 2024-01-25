import 'package:awign_saas/core/extension/common_extension.dart';
import 'package:awign_saas/hrms/attendance/data/model/punch_request.dart';
import 'package:awign_saas/hrms/attendance/data/model/punch_response.dart';

import '../../../../core/data/local/database/model/current_user/work_location.dart';
import 'attendance_response.dart';

enum AttendanceType {
  normal('NORMAL'),
  selfieAndGeo('SELFIE_AND_GEO'),
  geo('GEO'),
  selfie('SELFIE');

  const AttendanceType(this.value);

  final String value;

  static AttendanceType? get(type) {
    switch(type) {
      case 'NORMAL':
        return AttendanceType.normal;
      case 'SELFIE_AND_GEO':
        return AttendanceType.selfieAndGeo;
      case 'GEO':
        return AttendanceType.geo;
      case 'SELFIE':
        return AttendanceType.selfie;
      default:
        return null;
    }
  }
}

class TodayAttendanceStatus {
  String? date;
  List<Punch>? punches;
  bool? isWeekOff;
  String? shiftVersionId;
  String? showToUser;
  String? id;
  String? employeeShiftMappingId;
  List<AttendanceStatusEntity>? status;
  AttendanceType? attendanceType;
  WorkLocation? workLocation;

  TodayAttendanceStatus(
      {this.date,
        this.punches,
        this.isWeekOff,
        this.shiftVersionId,
        this.showToUser,
        this.id,
        this.employeeShiftMappingId,
        this.status,
        this.attendanceType,
        this.workLocation});

  TodayAttendanceStatus.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    if (json['punches'] != null) {
      punches = <Punch>[];
      json['punches'].forEach((v) {
        punches!.add(Punch.fromJson(v));
      });
    }
    isWeekOff = json['is_week_off'];
    shiftVersionId = json['shift_version_id'];
    showToUser = json['show_to_user'];
    id = json['id'];
    employeeShiftMappingId = json['employee_shift_mapping_id'];
    if (json['status'] != null) {
      status = <AttendanceStatusEntity>[];
      json['status'].forEach((v) {
        status!.add(AttendanceStatusEntity.fromJson(v));
      });
    }
    attendanceType = AttendanceType.get(json['attendance_type']);
    workLocation = json['work_location'] != null
        ? WorkLocation.fromJson(json['work_location'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    if (punches != null) {
      data['punches'] = punches!.map((v) => v.toJson()).toList();
    }
    data['is_week_off'] = isWeekOff;
    data['shift_version_id'] = shiftVersionId;
    data['show_to_user'] = showToUser;
    data['id'] = id;
    data['employee_shift_mapping_id'] = employeeShiftMappingId;
    if (status != null) {
      data['status'] = status!.map((v) => v.toJson()).toList();
    }
    data['attendance_type'] = attendanceType?.value;
    if (workLocation != null) {
      data['work_location'] = workLocation!.toJson();
    }
    return data;
  }

  String? getPunchInTime() {
    if(!punches.isNullOrEmpty) {
      Punch? punch =  punches!.where((element) => element.punchType == PunchType.punchIn).lastOrNull;
      return punch?.getPunchInTime();
    }
    return null;
  }

  String? getPunchOutTime() {
    if(!punches.isNullOrEmpty) {
      Punch? punch =  punches!.where((element) => element.punchType == PunchType.punchOut).lastOrNull;
      return punch?.getPunchOutTime();
    }
    return null;
  }

  PunchType getNextPunchType() {
    return PunchType.get(showToUser);
  }
}