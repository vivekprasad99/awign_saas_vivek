import 'package:awign_saas/hrms/attendance/data/model/date_range_request.dart';
import '../../model/regularize_search_response.dart';

abstract class RMRegularisationRemoteDataSource {
  Future<List<RmRegularizeSearchResponse>?> searchRegularise(DateRangeRequest dateRangeRequest);
}
