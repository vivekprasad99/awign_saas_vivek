import 'package:awign_saas/core/extension/common_extension.dart';
import 'package:awign_saas/hrms/attendance/data/model/punch_request.dart';

import '../../../attendance/data/model/punch_response.dart';
import 'regularisation_request.dart';

enum RegularisationStatus {
  pending('PENDING'),
  approved('APPROVED'),
  rejected('REJECTED'),
  withdrawn('WITHDRAWN'),
  all('ALL');

  const RegularisationStatus(this.value);

  final String value;

  static RegularisationStatus? get(strPunchType) {
    switch(strPunchType) {
      case 'PENDING':
        return RegularisationStatus.pending;
      case 'APPROVED':
        return RegularisationStatus.approved;
      case 'REJECTED':
        return RegularisationStatus.rejected;
      case 'WITHDRAWN':
        return RegularisationStatus.withdrawn;
      case 'ALL':
        return RegularisationStatus.all;
      default:
        return RegularisationStatus.all;
    }
  }
}

class RegularisationResponse {
  List<Regularisation>? absentList;

  RegularisationResponse({this.absentList});

  RegularisationResponse.fromJson(Map<String, dynamic> json) {
    if (json['absent'] != null) {
      absentList = <Regularisation>[];
      json['absent'].forEach((v) {
        absentList!.add(Regularisation.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (absentList != null) {
      data['absent'] = absentList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Regularisation {
  String? id;
  String? employeeShiftMappingId;
  String? date;
  List<Punch>? punches;
  String? reason;
  String? reasonComment;
  RegularisationStatus? status;
  String? createdAt;
  String? updatedAt;
  Approval? approval;

  Regularisation(
      {this.id,
        this.employeeShiftMappingId,
        this.date,
        this.punches,
        this.reason,
        this.reasonComment,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.approval});

  Regularisation.fromJson(Map<String, dynamic> json) {
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
    updatedAt = json['updated_at'];
    approval = json['approval'] != null
        ? Approval.fromJson(json['approval'])
        : null;
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
    data['updated_at'] = updatedAt;
    if (approval != null) {
      data['approval'] = approval!.toJson();
    }
    return data;
  }

  String? getPunchInTime() {
    if(!punches.isNullOrEmpty) {
      Punch? punch = punches!.where((element) => element.punchType == PunchType.punchIn).firstOrNull;
      return punch?.punchTime;
    }
    return null;
  }

  String? getPunchOutTime() {
    if(!punches.isNullOrEmpty) {
      Punch? punch = punches!.where((element) => element.punchType == PunchType.punchOut).firstOrNull;
      return punch?.punchTime;
    }
    return null;
  }
}