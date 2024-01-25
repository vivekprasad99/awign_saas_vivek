import 'dart:collection';

import 'package:awign_saas/core/data/local/database/user_preferences/user_preferences.dart';

import '../../../utils/app_log.dart';

class HeadersUtils {
  static const contentType = 'Content-Type';
  static const xMOBILE = 'X_MOBILE';
  static const authorization = 'Authorization';
  static const tenantID = 'tenant_id';

  static Future<Map<String, dynamic>> getHeaders() async {
    Map<String, dynamic> headers = HashMap();
    try {
      UserPreferences userPreferences = UserPreferences.getInstance();
      if(userPreferences.getXAuthToken() != null) {
        headers.putIfAbsent(authorization, () => 'Bearer ${userPreferences.getXAuthToken()}');
      }
      headers.putIfAbsent(contentType, () => 'application/json');
    } catch (e, stacktrace) {
      AppLog.e('getHeaders : ${e.toString()} \n${stacktrace.toString()}');
    }
    return headers;
  }
}
