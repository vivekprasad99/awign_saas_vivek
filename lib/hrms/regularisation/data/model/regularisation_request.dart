class RegularisationRequest {
  String? date;
  List<PunchData>? punches;
  Approval? approval;
  String? reasonComment;
  int? totalSections;
  int? section;

  RegularisationRequest(
      {this.date, this.punches, this.approval, this.reasonComment, this.totalSections, this.section});

  RegularisationRequest.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    if (json['punches'] != null) {
      punches = <PunchData>[];
      json['punches'].forEach((v) {
        punches!.add(PunchData.fromJson(v));
      });
    }
    approval = json['approval'] != null
        ? Approval.fromJson(json['approval'])
        : null;
    reasonComment = json['reason_comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    if (punches != null) {
      data['punches'] = punches!.map((v) => v.toJson()).toList();
    }
    if (approval != null) {
      data['approval'] = approval!.toJson();
    }
    data['reason_comment'] = reasonComment;
    if (totalSections != null) {
      data['total_sections'] = totalSections;
    }
    if (section != null) {
      data['section'] = section;
    }
    return data;
  }
}

class PunchData {
  String? punchTime;
  String? punchType;

  PunchData({this.punchTime, this.punchType});

  PunchData.fromJson(Map<String, dynamic> json) {
    punchTime = json['punch_time'];
    punchType = json['punch_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['punch_time'] = punchTime;
    data['punch_type'] = punchType;
    return data;
  }
}

class Approval {
  String? managerUUID;
  String? managerName;

  Approval({this.managerUUID, this.managerName});

  Approval.fromJson(Map<String, dynamic> json) {
    managerUUID = json['manager_uuid'];
    managerName = json['manager_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['manager_uuid'] = managerUUID;
    data['manager_name'] = managerName;
    return data;
  }
}