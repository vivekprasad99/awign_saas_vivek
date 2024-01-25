class ReimbursementTypeResponse {
  List<ReimbursementType>? reimbursementTypes;
  String? message;
  String? status;

  ReimbursementTypeResponse({this.reimbursementTypes, this.message, this.status});

  ReimbursementTypeResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      reimbursementTypes = <ReimbursementType>[];
      json['data'].forEach((v) {
        reimbursementTypes!.add(ReimbursementType.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (reimbursementTypes != null) {
      data['data'] = reimbursementTypes!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    data['status'] = status;
    return data;
  }
}

class ReimbursementType {
  int? id;
  String? type;
  List<ReimbursementSubType>? reimbursementSubTypes;

  ReimbursementType({this.id, this.type, this.reimbursementSubTypes});

  ReimbursementType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    if (json['reimbursement_sub_type_responses'] != null) {
      reimbursementSubTypes = <ReimbursementSubType>[];
      json['reimbursement_sub_type_responses'].forEach((v) {
        reimbursementSubTypes!
            .add(ReimbursementSubType.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    if (reimbursementSubTypes != null) {
      data['reimbursement_sub_type_responses'] =
          reimbursementSubTypes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ReimbursementSubType {
  int? id;
  String? subType;
  String? createdAt;
  Metadata? metadata;

  ReimbursementSubType(
      {this.id, this.subType, this.createdAt, this.metadata});

  ReimbursementSubType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subType = json['sub_type'];
    createdAt = json['created_at'];
    metadata = json['metadata'] != null
        ? Metadata.fromJson(json['metadata'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['sub_type'] = subType;
    data['created_at'] = createdAt;
    if (metadata != null) {
      data['metadata'] = metadata!.toJson();
    }
    return data;
  }
}

class Metadata {
  String? vendorName;
  String? stayDate;
  String? fromDestination;
  String? stayLocation;
  String? toDestination;
  String? dateOfTravel;
  String? distanceTravelled;

  Metadata(
      {this.vendorName,
        this.stayDate,
        this.fromDestination,
        this.stayLocation,
        this.toDestination,
        this.dateOfTravel,
        this.distanceTravelled});

  Metadata.fromJson(Map<String, dynamic> json) {
    vendorName = json['vendor name'];
    stayDate = json['stay_date'];
    fromDestination = json['from_destination'];
    stayLocation = json['stay_location'];
    toDestination = json['to_destination'];
    dateOfTravel = json['date_of_travel'];
    distanceTravelled = json['distance_travelled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if(vendorName != null) {
      data['vendor name'] = vendorName;
    }
    if(stayDate != null) {
      data['stay_date'] = stayDate;
    }
    if(fromDestination != null) {
      data['from_destination'] = fromDestination;
    }
    if(stayLocation != null) {
      data['stay_location'] = stayLocation;
    }
    if(toDestination != null) {
      data['to_destination'] = toDestination;
    }
    if(dateOfTravel != null) {
      data['date_of_travel'] = dateOfTravel;
    }
    if(distanceTravelled != null) {
      data['distance_travelled'] = distanceTravelled;
    }
    return data;
  }

  bool isMetadataFieldsAvailable() {
    if(vendorName != null || stayDate != null || fromDestination != null || stayLocation != null
      || toDestination != null || dateOfTravel != null) {
      return true;
    } else {
      return false;
    }
  }
}