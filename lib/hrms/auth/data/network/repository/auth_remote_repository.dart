import 'package:awign_saas/core/data/model/advance_search/advance_search_request.dart';
import 'package:awign_saas/core/data/model/api_response.dart';
import 'package:awign_saas/core/data/network/helper/headers_utils.dart';
import 'package:awign_saas/hrms/auth/data/model/device_info.dart';
import 'package:awign_saas/hrms/auth/data/network/api/auth_api.dart';
import 'package:awign_saas/hrms/dashboard/data/search_notification_response.dart';
import 'package:dio/dio.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import '../../../../../core/data/network/client/rest_client.dart';
import '../../../../../core/exception/exception.dart';
import '../../../../../core/utils/app_log.dart';
import '../../model/employee_details.dart';
import '../../model/user_response.dart';
import '../data_source/auth_remote_data_source.dart';


class AuthRemoteRepository extends AuthAPI implements AuthRemoteDataSource {

  @override
  Future<(String, String)> sendOTP(String mobileNumber) async {
    try {
      Response response = await bffRestClient.get(sendOTPAPI, header: {HeadersUtils.xMOBILE: mobileNumber});
      String? resendTime = (response.data as Map)['resend'];
      String? xAuthToken = response.headers['x_auth_token']?[0];
      if(resendTime != null && xAuthToken != null) {
        return (resendTime, xAuthToken);
      } else {
        throw FailureException(0, 'we_regret_the_technical_error'.tr);
      }
    } catch (e) {
      AppLog.e('sendOTP : ${e.toString()}');
      rethrow;
    }
  }

  @override
  Future<(UserResponse, String)> validateOTP(String otp) async {
    try {
      Response response = await bffRestClient.get(validateOTPAPI.replaceFirst('OTP', otp));
      UserResponse userResponse = UserResponse.fromJson(response.data);
      String? xAuthToken = response.headers['x_auth_token']?[0];
      if(xAuthToken != null) {
        return (userResponse, xAuthToken);
      } else {
        throw FailureException(0, 'we_regret_the_technical_error'.tr);
      }
    } catch (e) {
      AppLog.e('sendOTP : ${e.toString()}');
      rethrow;
    }
  }

  @override
  Future<(ApiResponse, String)> getAuthTokenByTenantID(String tenantID) async {
    try {
      Response response = await bffRestClient.get(getAuthTokenByTenantAPI.replaceFirst('tenantID', tenantID));
      ApiResponse apiResponse = ApiResponse.fromJson(response.data);
      String? xAuthToken = response.headers['x_auth_token']?[0];
      if(xAuthToken != null && apiResponse.status == Status.success) {
        return (apiResponse, xAuthToken);
      } else {
        throw FailureException(0, 'we_regret_the_technical_error'.tr);
      }
    } catch (e) {
      AppLog.e('getAuthTokenByTenantID : ${e.toString()}');
      rethrow;
    }
  }

  @override
  Future<EmployeeDetails> getEmployeeDetails(String userID) async {
    try {
      Response response = await bffRestClient.get(getEmployeeDetailsAPI.replaceFirst('userID', userID));
      EmployeeDetails employeeDetails = EmployeeDetails.fromJson(response.data);
      return employeeDetails;
    } catch (e) {
      AppLog.e('getEmployeeDetails : ${e.toString()}');
      rethrow;
    }
  }

  @override
  Future<void> updateDeviceInfo(DeviceInfo deviceInfo) async {
    try {
      Response response = await bffRestClient.post(updateDeviceInfoAPI, body: deviceInfo.toJson());
      return;
    } catch (e) {
      AppLog.e('updateDeviceInfo : ${e.toString()}');
      rethrow;
    }
  }

  @override
  Future<SearchNotificationResponse> searchNotifications(AdvancedSearchRequest advancedSearchRequest) async {
    try {
      Response response = await bffRestClient.post(searchNotificationsAPI, body: advancedSearchRequest.toJson());
      SearchNotificationResponse notificationResponse = SearchNotificationResponse.fromJson(response.data);
      return notificationResponse;
    } catch (e) {
      AppLog.e('searchNotifications : ${e.toString()}');
      rethrow;
    }
  }
}
