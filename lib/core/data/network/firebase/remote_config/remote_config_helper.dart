import 'dart:convert';

import 'package:awign_saas/core/data/model/app_upgrade_data.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

import '../../../../utils/app_log.dart';

class RemoteConfigHelper {
  static RemoteConfigHelper? _instance;
  AppUpgradeData? appUpgradeData;

  RemoteConfigHelper._() {
    FirebaseRemoteConfig.instance.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 3),
      minimumFetchInterval: const Duration(minutes: 3),
    )).then((value) {
      fetchConfiguration();
    });
    // fetchConfiguration();
  }

  static RemoteConfigHelper instance() {
    _instance ??= RemoteConfigHelper._();
    return _instance!;
  }

  fetchConfiguration() async {
    try {
      // final List<Future<void>> setupFutures = [
      //   FirebaseRemoteConfig.instance.setConfigSettings(
      //     RemoteConfigSettings(
      //       fetchTimeout: const Duration(minutes: 3),
      //       minimumFetchInterval: const Duration(minutes: 3),
      //     ),
      //   ),
      //   FirebaseRemoteConfig.instance.fetchAndActivate(),
      // ];
      // await Future.wait(setupFutures);
      await FirebaseRemoteConfig.instance.fetchAndActivate();
      appUpgradeData = AppUpgradeData.fromJson(jsonDecode(FirebaseRemoteConfig.instance.getString('app_upgrade_data')));
    } catch (e, st) {
      AppLog.e('RemoteConfigHelper.instance : ${e.toString()} \n${st.toString()}');
    }
  }
}
