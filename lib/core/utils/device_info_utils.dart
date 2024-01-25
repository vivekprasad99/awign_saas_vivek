import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:package_info_plus/package_info_plus.dart';

import '../../hrms/auth/data/model/device_info.dart';
import 'app_log.dart';

class DeviceInfoUtils {
  static Future<DeviceInfo?> getDeviceInfoData() async {
    try {
      DeviceInfo deviceInfoData = DeviceInfo();
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      deviceInfoData.versionName = packageInfo.version;
      deviceInfoData.versionNumber = packageInfo.buildNumber;

      final deviceInfoPlugin = DeviceInfoPlugin();
      // final allInfo = deviceInfo.data;
      if (kIsWeb) {
      } else if (Platform.isAndroid) {

      } else if (Platform.isIOS) {

      }
      return deviceInfoData;
    } catch (e, st) {
      AppLog.e('getDeviceInfoData : ${e.toString()} \n${st.toString()}');
      return null;
    }
  }
}
