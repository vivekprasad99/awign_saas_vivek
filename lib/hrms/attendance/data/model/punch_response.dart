import 'package:awign_saas/hrms/attendance/data/model/punch_request.dart';

import 'attendance_response.dart';

class PunchResponse {
  String? date;
  List<Punch>? punches;
  bool? isWeekOff;
  String? shiftVersionId;
  String? showToUser;
  String? id;
  String? employeeShiftMappingId;
  String? message;
  List<AttendanceStatusEntity>? status;

  PunchResponse(
      {this.date,
        this.punches,
        this.isWeekOff,
        this.shiftVersionId,
        this.showToUser,
        this.id,
        this.employeeShiftMappingId,
        this.message,
        this.status});

  PunchResponse.fromJson(Map<String, dynamic> json) {
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
    message = json['message'];
    if (json['status'] != null) {
      status = <AttendanceStatusEntity>[];
      json['status'].forEach((v) {
        status!.add(AttendanceStatusEntity.fromJson(v));
      });
    }
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
    data['message'] = message;
    if (status != null) {
      data['status'] = status!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Punch {
  int? punchConfigId;
  String? punchTime;
  PunchType? punchType;
  Geolocation? geolocation;
  String? selfieUrl;

  Punch(
      {this.punchConfigId,
        this.punchTime,
        this.punchType,
        this.geolocation,
        this.selfieUrl});

  Punch.fromJson(Map<String, dynamic> json) {
    punchConfigId = json['punch_config_id'];
    punchTime = json['punch_time'];
    punchType = PunchType.get(json['punch_type']);
    geolocation = json['geolocation'] != null
        ? Geolocation.fromJson(json['geolocation'])
        : null;
    selfieUrl = json['selfie_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['punch_config_id'] = punchConfigId;
    data['punch_time'] = punchTime;
    data['punch_type'] = punchType;
    if (geolocation != null) {
      data['geolocation'] = geolocation!.toJson();
    }
    data['selfie_url'] = selfieUrl;
    return data;
  }

  String? getPunchInTime() {
    if(punchType == PunchType.punchIn) {
      return punchTime;
    } else {
      return null;
    }
  }

  String? getPunchOutTime() {
    if(punchType == PunchType.punchOut) {
      return punchTime;
    } else {
      return null;
    }
  }
}