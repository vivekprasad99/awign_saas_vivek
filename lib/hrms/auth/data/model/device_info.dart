class DeviceInfo {
  String? fcmToken;
  String? versionName;
  String? versionNumber;

  DeviceInfo({this.fcmToken});

  DeviceInfo.fromJson(Map<String, dynamic> json) {
    fcmToken = json['fcm_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fcm_token'] = fcmToken;
    return data;
  }
}