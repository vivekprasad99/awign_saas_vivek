import 'package:awign_saas/core/data/model/advance_search/advance_search_request.dart';
import 'package:awign_saas/hrms/rm/rm_comp_off/data/model/comp_off_approve_reject_request.dart';
import 'package:awign_saas/hrms/rm/rm_comp_off/data/model/rm_comp_off_search_response.dart';

abstract class RMCompOffRemoteDataSource {
  Future<RMCompOffSearchResponse> searchCompOff(AdvancedSearchRequest advancedSearchRequest);
  Future<void> approveOrRejectCompOff(int compOffID, CompOffApproveRejectRequest approveRejectRequest);
}
