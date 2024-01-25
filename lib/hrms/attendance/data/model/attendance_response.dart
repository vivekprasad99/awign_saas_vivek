import 'package:awign_saas/core/extension/common_extension.dart';
import 'package:awign_saas/hrms/attendance/data/model/punch_request.dart';

import '../../../leaves/data/model/leave.dart';
import '../../../rm/rm_regularisation/data/model/regularize_search_response.dart';
import 'punch_response.dart';

enum AttendanceStatus {
  present('PRESENT'),
  working('WORKING'),
  absent('ABSENT'),
  notStartedWorking('NOT_STARTED_WORKING'),
  leave('LEAVE'),
  weeklyOff('WEEKLY_OFF'),
  holiday('HOLIDAY'),
  shiftNotAssigned('SHIFT_NOT_ASSIGNED');

  const AttendanceStatus(this.value);

  final String value;

  static AttendanceStatus? get(String strStatus) {
    return switch (strStatus) {
      'PRESENT' => present,
      'WORKING' => working,
      'ABSENT' => absent,
      'NOT_STARTED_WORKING' => notStartedWorking,
      'LEAVE' => leave,
      'WEEKLY_OFF' => weeklyOff,
      'HOLIDAY' => holiday,
      'SHIFT_NOT_ASSIGNED' => shiftNotAssigned,
      _ => null
    };
  }
}

class AttendanceResponse {
  List<AttendanceDetails>? attendanceDetails;

  AttendanceResponse({this.attendanceDetails});

  AttendanceResponse.fromJson(Map<String, dynamic> json) {
    if (json['attendance_status'] != null) {
      attendanceDetails = <AttendanceDetails>[];
      json['attendance_status'].forEach((v) {
        attendanceDetails!.add(AttendanceDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (attendanceDetails != null) {
      data['attendance_status'] =
          attendanceDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AttendanceDetails {
  List<AttendanceStatusEntity>? status;
  String? date;
  List<Punch>? punches;
  String? id;
  AttendanceStatus? attendanceStatus;

  AttendanceDetails(
      {this.status,
        this.date,
        this.punches,
        this.id});

  AttendanceDetails.fromJson(Map<String, dynamic> json) {
    if (json['status'] != null) {
      status = <AttendanceStatusEntity>[];
      json['status'].forEach((v) {
        status!.add(AttendanceStatusEntity.fromJson(v));
      });
      status?.sort((a, b) {
        if(a.section != null && b.section != null && a.section! > b.section!) {
          return 1;
        } else if(a.section != null && b.section != null && a.section! < b.section!) {
          return -1;
        } else {
          return 0;
        }
      });
    }
    date = json['date'];
    if (json['punches'] != null) {
      punches = <Punch>[];
      json['punches'].forEach((v) {
        punches!.add(Punch.fromJson(v));
      });
    }
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (status != null) {
      data['status'] = status!.map((v) => v.toJson()).toList();
    }
    data['date'] = date;
    if (punches != null) {
      data['punches'] = punches!.map((v) => v.toJson()).toList();
    }
    data['id'] = id;
    return data;
  }

  bool checkIsAbsentInAnySection() {
    bool isAbsentInAnySection = false;
    for(AttendanceStatusEntity attendanceStatusEntity in status ?? []) {
      if(attendanceStatusEntity.attendanceStatus == AttendanceStatus.absent) {
        isAbsentInAnySection = true;
      }
    }
    return isAbsentInAnySection;
  }

  bool checkIsLeaveInAnySection() {
    bool isLeaveInAnySection = false;
    for(AttendanceStatusEntity attendanceStatusEntity in status ?? []) {
      if(attendanceStatusEntity.attendanceStatus == AttendanceStatus.leave) {
        isLeaveInAnySection = true;
      }
    }
    return isLeaveInAnySection;
  }

  bool checkIsPresentInAnySection() {
    bool isPresentInAnySection = false;
    for(AttendanceStatusEntity attendanceStatusEntity in status ?? []) {
      if(attendanceStatusEntity.attendanceStatus == AttendanceStatus.present) {
        isPresentInAnySection = true;
      }
    }
    return isPresentInAnySection;
  }

  bool checkIsShiftAssignedInAllSection() {
    bool isShiftAssignedInAllSection = true;
    for(AttendanceStatusEntity attendanceStatusEntity in status ?? []) {
      if(attendanceStatusEntity.attendanceStatus == AttendanceStatus.shiftNotAssigned) {
        isShiftAssignedInAllSection = false;
        break;
      }
    }
    return isShiftAssignedInAllSection;
  }

  bool checkIsWeeklyOffInAnySection() {
    bool isWeeklyOffInAnySection = false;
    for(AttendanceStatusEntity attendanceStatusEntity in status ?? []) {
      if(attendanceStatusEntity.attendanceStatus == AttendanceStatus.weeklyOff) {
        isWeeklyOffInAnySection = true;
        break;
      }
    }
    return isWeeklyOffInAnySection;
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

  Leave? getLeave() {
    for(AttendanceStatusEntity attendanceStatusEntity in status ?? []) {
      if(attendanceStatusEntity.leave != null) {
        return attendanceStatusEntity.leave;
      }
    }
    return null;
  }

  Regularization? getRegularization() {
    for(AttendanceStatusEntity attendanceStatusEntity in status ?? []) {
      if(attendanceStatusEntity.regularization != null) {
        return attendanceStatusEntity.regularization;
      }
    }
    return null;
  }
}

class AttendanceStatusEntity {
  AttendanceStatus? attendanceStatus;
  int? section;
  Leave? leave;
  Regularization? regularization;

  AttendanceStatusEntity({this.attendanceStatus, this.section, this.leave, this.regularization});

  AttendanceStatusEntity.fromJson(Map<String, dynamic> json) {
    attendanceStatus = AttendanceStatus.get(json['attendance']);
    section = json['section'];
    leave = json['leave'] != null ? Leave.fromJson(json['leave']) : null;
    regularization = json['regularization'] != null
        ? Regularization.fromJson(json['regularization'], null, null, null)
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['attendance'] = attendanceStatus?.value;
    data['section'] = section;
    if (leave != null) {
      data['leave'] = leave!.toJson();
    }
    if (regularization != null) {
      data['regularization'] = regularization!.toJson();
    }
    return data;
  }
}