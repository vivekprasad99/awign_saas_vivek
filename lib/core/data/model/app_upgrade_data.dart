enum ReleaseType {
  recommended('recommended'),
  force('force');

  const ReleaseType(this.value);

  final String value;

  static ReleaseType? get(strPunchType) {
    switch(strPunchType) {
      case 'recommended':
        return ReleaseType.recommended;
      case 'force':
        return ReleaseType.force;
      default:
        return null;
    }
  }
}

class AppUpgradeData {
  AndroidAppUpgradeData? androidAppUpgradeData;
  IOSAppUpgradeData? iosAppUpgradeData;

  AppUpgradeData({this.androidAppUpgradeData, this.iosAppUpgradeData});

  AppUpgradeData.fromJson(Map<String, dynamic> json) {
    androidAppUpgradeData = json['android_app_upgrade_data'] != null
        ? AndroidAppUpgradeData.fromJson(json['android_app_upgrade_data'])
        : null;
    iosAppUpgradeData = json['ios_app_upgrade_data'] != null
        ? IOSAppUpgradeData.fromJson(json['ios_app_upgrade_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (androidAppUpgradeData != null) {
      data['android_app_upgrade_data'] = androidAppUpgradeData!.toJson();
    }
    if (iosAppUpgradeData != null) {
      data['ios_app_upgrade_data'] = iosAppUpgradeData!.toJson();
    }
    return data;
  }
}

class AndroidAppUpgradeData {
  String? title;
  String? subTitle;
  String? versionName;
  int? versionNumber;
  ReleaseType? releaseType;
  String? releaseInfo;

  AndroidAppUpgradeData(
      {
      this.title,
      this.subTitle,
      this.versionName,
      this.versionNumber,
      this.releaseType,
      this.releaseInfo});

  AndroidAppUpgradeData.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    subTitle = json['sub_title'];
    versionName = json['version_name'];
    versionNumber = json['version_number'];
    releaseType = ReleaseType.get(json['release_type']);
    releaseInfo = json['release_info'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['sub_title'] = subTitle;
    data['version_name'] = versionName;
    data['version_number'] = versionNumber;
    data['release_type'] = releaseType?.value;
    data['release_info'] = releaseInfo;
    return data;
  }
}

class IOSAppUpgradeData {
  String? title;
  String? subTitle;
  String? versionName;
  int? versionNumber;
  ReleaseType? releaseType;
  String? releaseInfo;

  IOSAppUpgradeData(
      {
        this.title,
        this.subTitle,
        this.versionName,
        this.versionNumber,
        this.releaseType,
        this.releaseInfo});

  IOSAppUpgradeData.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    subTitle = json['sub_title'];
    versionName = json['version_name'];
    versionNumber = json['version_number'];
    releaseType = ReleaseType.get(json['release_type']);
    releaseInfo = json['release_info'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['sub_title'] = subTitle;
    data['version_name'] = versionName;
    data['version_number'] = versionNumber;
    data['release_type'] = releaseType?.value;
    data['release_info'] = releaseInfo;
    return data;
  }
}