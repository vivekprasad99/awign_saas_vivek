import 'package:awign_saas/core/data/network/client/rest_client.dart';
import 'package:awign_saas/core/utils/app_log.dart';
import 'package:awign_saas/hrms/holidays/data/network/api/holiday_api.dart';
import 'package:awign_saas/hrms/holidays/data/network/data_source/holiday_remote_data_source.dart';
import 'package:dio/dio.dart';

import '../../../../leaves/data/model/apply_leave_request.dart';
import '../../../../leaves/data/model/apply_leave_response.dart';
import '../../model/apply_holiday_request.dart';
import '../../model/holiday_search_response.dart';

class HolidayRemoteRepository extends HolidayAPI
    implements HolidayRemoteDataSource {

  @override
  Future<HolidaySearchResponse> searchHoliday() async{
    try {
      Response response = await bffRestClient.get(getHolidayListAPI);
      return HolidaySearchResponse.fromJson(response.data);
    } catch (e) {
      AppLog.e('searchHoliday : ${e.toString()}');
      rethrow;
    }
  }

  @override
  Future<ApplyLeaveResponse> applyHolidayLeave(ApplyHolidayRequest applyHolidayRequest) async {
    try {
      Response response = await bffRestClient.post(applyHolidayAPI, body: applyHolidayRequest.toJson());
      return ApplyLeaveResponse.fromJson(response.data);
    } catch (e) {
      AppLog.e('applyHolidayLeave : ${e.toString()}');
      rethrow;
    }
  }

  @override
  Future<void> withdrawHolidayLeave(int holidayLeaveID) async {
    try {
      Response response = await bffRestClient
          .patch(withdrawHolidayAPI.replaceFirst('HOLIDAY_LEAVE_ID', holidayLeaveID.toString()));
    } catch (e) {
      AppLog.e('withdrawHolidayLeave : ${e.toString()}');
      rethrow;
    }
  }
}