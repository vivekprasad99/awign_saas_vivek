import 'package:awign_saas/core/data/local/database/model/current_user/permissions.dart';
import 'package:awign_saas/core/data/local/database/model/current_user/tenant.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'boxes.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'model/current_user/user.dart';
import 'model/current_user/work_location.dart';
import 'user_preferences/user_preferences.dart';

class HiveHelper {
  static Future hiveInit() async {
    if (kIsWeb) {
      await Hive.initFlutter();
    } else {
      final appDocumentDirectory = await getApplicationDocumentsDirectory();
      await Hive.initFlutter(appDocumentDirectory.path);
    }
    if (!Hive.isAdapterRegistered(Boxes.currentUserHoTypeID)) {
      Hive.registerAdapter(UserAdapter());
    }
    if (!Hive.isAdapterRegistered(Boxes.permissionTypeID)) {
      Hive.registerAdapter(PermissionsAdapter());
    }
    if (!Hive.isAdapterRegistered(Boxes.tenantTypeID)) {
      Hive.registerAdapter(TenantAdapter());
    }
    if (!Hive.isAdapterRegistered(Boxes.workLocationTypeID)) {
      Hive.registerAdapter(WorkLocationAdapter());
    }
    await UserPreferences.init();
  }
}
