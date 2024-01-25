import 'package:awign_saas/core/data/model/advance_search/advance_search_request.dart';
import 'package:awign_saas/hrms/auth/data/model/device_info.dart';
import 'package:awign_saas/hrms/dashboard/data/search_notification_response.dart';

import '../../../../../core/data/model/api_response.dart';
import '../../model/employee_details.dart';
import '../../model/user_response.dart';

abstract class AuthRemoteDataSource {
  Future<(String, String)> sendOTP(String mobileNumber);
  Future<(UserResponse, String)> validateOTP(String otp);
  Future<(ApiResponse, String)> getAuthTokenByTenantID(String tenantID);
  Future<EmployeeDetails> getEmployeeDetails(String userID);
  Future<void> updateDeviceInfo(DeviceInfo deviceInfo);
  Future<SearchNotificationResponse> searchNotifications(AdvancedSearchRequest advancedSearchRequest);
}
