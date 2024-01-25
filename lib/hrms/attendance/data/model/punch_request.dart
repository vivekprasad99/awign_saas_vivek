enum PunchType {
  punchIn('PUNCH_IN'),
  punchOut('PUNCH_OUT'),
  disabled('DISABLED');

  const PunchType(this.value);

  final String value;

  static PunchType get(strPunchType) {
    switch(strPunchType) {
      case 'PUNCH_IN':
        return PunchType.punchIn;
      case 'PUNCH_OUT':
        return PunchType.punchOut;
      case 'DISABLED':
        return PunchType.disabled;
      default:
        return PunchType.punchIn;
    }
  }
}

class PunchRequest {
  String? punchType;
  Geolocation? geolocation;
  String? selfieUrl;

  PunchRequest({this.punchType, this.geolocation, this.selfieUrl});

  PunchRequest.fromJson(Map<String, dynamic> json) {
    punchType = json['punch_type'];
    geolocation = json['geolocation'] != null
        ? Geolocation.fromJson(json['geolocation'])
        : null;
    selfieUrl = json['selfie_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['punch_type'] = punchType;
    if (geolocation != null) {
      data['geolocation'] = geolocation!.toJson();
    }
    data['selfie_url'] = selfieUrl;
    return data;
  }
}

class Geolocation {
  double? latitude;
  double? longitude;

  Geolocation({this.latitude, this.longitude});

  Geolocation.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}