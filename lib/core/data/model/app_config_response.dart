class AppConfigResponse {
  String? key;
  Data? data;

  AppConfigResponse({this.key, this.data});

  AppConfigResponse.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  VersionInfo? versionInfo;
  EndPoints? endPoints;
  PrimaryContact? primaryContact;
  TdsRules? tdsRules;
  TdsDeducationPercentage? tdsDeducationPercentage;
  String? tdsNote;
  String? tenant;

  Data(
      {this.versionInfo,
      this.endPoints,
      this.primaryContact,
      this.tdsRules,
      this.tdsDeducationPercentage,
      this.tdsNote,
      this.tenant});

  Data.fromJson(Map<String, dynamic> json) {
    versionInfo = json['version_info'] != null
        ? new VersionInfo.fromJson(json['version_info'])
        : null;
    endPoints = json['end_points'] != null
        ? new EndPoints.fromJson(json['end_points'])
        : null;
    primaryContact = json['primary_contact'] != null
        ? new PrimaryContact.fromJson(json['primary_contact'])
        : null;
    tdsRules = json['tds_rules'] != null
        ? new TdsRules.fromJson(json['tds_rules'])
        : null;
    tdsDeducationPercentage = json['tds_deducation_percentage'] != null
        ? new TdsDeducationPercentage.fromJson(
            json['tds_deducation_percentage'])
        : null;
    tdsNote = json['tds_note'];
    tenant = json['tenant'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.versionInfo != null) {
      data['version_info'] = this.versionInfo!.toJson();
    }
    if (this.endPoints != null) {
      data['end_points'] = this.endPoints!.toJson();
    }
    if (this.primaryContact != null) {
      data['primary_contact'] = this.primaryContact!.toJson();
    }
    if (this.tdsRules != null) {
      data['tds_rules'] = this.tdsRules!.toJson();
    }
    if (this.tdsDeducationPercentage != null) {
      data['tds_deducation_percentage'] =
          this.tdsDeducationPercentage!.toJson();
    }
    data['tds_note'] = this.tdsNote;
    data['tenant'] = this.tenant;
    return data;
  }
}

class VersionInfo {
  String? versionName;
  int? versionNumber;
  String? releaseType;

  VersionInfo({this.versionName, this.versionNumber, this.releaseType});

  VersionInfo.fromJson(Map<String, dynamic> json) {
    versionName = json['version_name'];
    versionNumber = json['version_number'];
    releaseType = json['release_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['version_name'] = this.versionName;
    data['version_number'] = this.versionNumber;
    data['release_type'] = this.releaseType;
    return data;
  }
}

class EndPoints {
  String? newCas;
  String? ims;
  String? cas;
  String? pms;
  String? core;
  String? pts;
  String? pds;
  String? ssOms;

  EndPoints(
      {this.newCas,
      this.ims,
      this.cas,
      this.pms,
      this.core,
      this.pts,
      this.pds,
      this.ssOms});

  EndPoints.fromJson(Map<String, dynamic> json) {
    newCas = json['new-cas'];
    ims = json['ims'];
    cas = json['cas'];
    pms = json['pms'];
    core = json['core'];
    pts = json['pts'];
    pds = json['pds'];
    ssOms = json['ss-oms'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['new-cas'] = this.newCas;
    data['ims'] = this.ims;
    data['cas'] = this.cas;
    data['pms'] = this.pms;
    data['core'] = this.core;
    data['pts'] = this.pts;
    data['pds'] = this.pds;
    data['ss-oms'] = this.ssOms;
    return data;
  }
}

class PrimaryContact {
  String? name;
  String? phone;
  String? whatsappNumber;
  String? email;
  String? designation;
  String? photoUrl;

  PrimaryContact(
      {this.name,
      this.phone,
      this.whatsappNumber,
      this.email,
      this.designation,
      this.photoUrl});

  PrimaryContact.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    whatsappNumber = json['whatsapp_number'];
    email = json['email'];
    designation = json['designation'];
    photoUrl = json['photo_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['whatsapp_number'] = this.whatsappNumber;
    data['email'] = this.email;
    data['designation'] = this.designation;
    data['photo_url'] = this.photoUrl;
    return data;
  }
}

class TdsRules {
  List<String>? withPan;
  List<String>? withoutPan;

  TdsRules({this.withPan, this.withoutPan});

  TdsRules.fromJson(Map<String, dynamic> json) {
    withPan = json['with_pan'].cast<String>();
    withoutPan = json['without_pan'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['with_pan'] = this.withPan;
    data['without_pan'] = this.withoutPan;
    return data;
  }
}

class TdsDeducationPercentage {
  int? panVerified;
  int? panUnverified;

  TdsDeducationPercentage({this.panVerified, this.panUnverified});

  TdsDeducationPercentage.fromJson(Map<String, dynamic> json) {
    panVerified = json['pan_verified'];
    panUnverified = json['pan_unverified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pan_verified'] = this.panVerified;
    data['pan_unverified'] = this.panUnverified;
    return data;
  }
}
