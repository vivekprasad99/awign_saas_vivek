import 'package:awign_saas/hrms/holidays/data/model/holiday_search_response.dart';

import '../../../../leaves/data/model/apply_leave_response.dart';
import '../../model/apply_holiday_request.dart';

abstract class HolidayRemoteDataSource {
  Future<HolidaySearchResponse> searchHoliday();
  Future<ApplyLeaveResponse> applyHolidayLeave(ApplyHolidayRequest applyHolidayRequest);
  Future<void> withdrawHolidayLeave(int holidayLeaveID);
}