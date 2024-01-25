import 'package:awign_saas/hrms/regularisation/data/model/regularisation_request.dart';
import 'package:awign_saas/hrms/regularisation/data/model/regularisation_status_response.dart';

import '../../../../attendance/data/model/date_range_request.dart';

abstract class RegularisationRemoteDataSource {
  Future<Regularisation> requestRegularisation(RegularisationRequest regularisationRequest);
  Future<List<Regularisation>?> getRegularisationStatus(DateRangeRequest dateRangeRequest);
  Future<void> withdrawRegularisation(String regularisationID);
}
