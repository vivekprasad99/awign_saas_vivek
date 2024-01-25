import 'package:awign_saas/hrms/regularisation/data/model/regularisation_request.dart';
import 'package:awign_saas/hrms/regularisation/data/model/regularisation_status_response.dart';

import '../../../../attendance/data/model/punch_request.dart';
import '../../../../attendance/data/model/punch_response.dart';
import 'package:awign_saas/core/extension/common_extension.dart';

class RmRegularizeSearchResponse {
  String? employeeUuid;
  String? employeeName;
  String? employeeId;
  List<Regularization>? regularization;

  RmRegularizeSearchResponse(
      {this.employeeUuid,
      this.employeeName,
      this.employeeId,
      this.regularization});

  RmRegularizeSearchResponse.fromJson(Map<String, dynamic> json) {
    employeeUuid = json['employee_uuid'];
    employeeName = json['employee_name'];
    employeeId = json['employee_id'];
    if (json['regularization'] != null) {
      regularization = <Regularization>[];
      json['regularization'].forEach((v) {
        regularization!.add(
            Regularization.fromJson(v, employeeUuid, employeeName, employeeId));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['employee_uuid'] = employeeUuid;
    data['employee_name'] = employeeName;
    data['employee_id'] = employeeId;
    if (regularization != null) {
      data['regularization'] =
          regularization!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Regularization {
  String? id;
  String? employeeShiftMappingId;
  String? date;
  List<Punch>? punches;
  String? reason;
  String? reasonComment;
  RegularisationStatus? status;
  String? createdAt;
  String? employeeUuid;
  String? employeeName;
  String? employeeId;
  String? shiftName;
  Approval? approval;

  Regularization(
      {this.id,
      this.employeeShiftMappingId,
      this.date,
      this.punches,
      this.reason,
      this.reasonComment,
      this.status,
      this.createdAt,
      this.employeeUuid,
      this.employeeName,
      this.employeeId,
      this.shiftName,
      this.approval});

  Regularization.fromJson(Map<String, dynamic> json, String? employeeUuidValue,
      String? employeeNameValue, String? employeeIdValue) {
    id = json['id'];
    employeeShiftMappingId = json['employee_shift_mapping_id'];
    date = json['date'];
    if (json['punches'] != null) {
      punches = <Punch>[];
      json['punches'].forEach((v) {
        punches!.add(Punch.fromJson(v));
      });
    }
    reason = json['reason'];
    reasonComment = json['reason_comment'];
    status = RegularisationStatus.get(json['status']);
    createdAt = json['created_at'];
    shiftName = json['shift_name'];
    approval = json['approval'] != null
        ? Approval.fromJson(json['approval'])
        : null;
    employeeUuid = employeeUuidValue;
    employeeName = employeeNameValue;
    employeeId = employeeIdValue;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['employee_shift_mapping_id'] = employeeShiftMappingId;
    data['date'] = date;
    if (punches != null) {
      data['punches'] = punches!.map((v) => v.toJson()).toList();
    }
    data['reason'] = reason;
    data['reason_comment'] = reasonComment;
    data['status'] = status?.value;
    data['created_at'] = createdAt;
    return data;
  }

  String? getPunchInTime() {
    if (!punches.isNullOrEmpty) {
      Punch? punch = punches!
          .where((element) => element.punchType == PunchType.punchIn)
          .lastOrNull;
      return punch?.getPunchInTime();
    }
    return null;
  }

  String? getPunchOutTime() {
    if (!punches.isNullOrEmpty) {
      Punch? punch = punches!
          .where((element) => element.punchType == PunchType.punchOut)
          .lastOrNull;
      return punch?.getPunchOutTime();
    }
    return null;
  }
}
