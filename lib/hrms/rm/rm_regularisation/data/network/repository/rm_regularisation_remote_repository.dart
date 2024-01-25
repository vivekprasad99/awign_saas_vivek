import 'package:awign_saas/hrms/rm/rm_regularisation/data/model/regularize_search_response.dart';
import 'package:awign_saas/hrms/rm/rm_regularisation/data/network/api/rm_regularisation_api.dart';
import 'package:awign_saas/hrms/rm/rm_regularisation/data/network/data_source/rm_regularisation_remote_data_source.dart';
import 'package:dio/dio.dart';

import '../../../../../../core/data/network/client/rest_client.dart';
import '../../../../../../core/utils/app_log.dart';
import '../../../../../attendance/data/model/date_range_request.dart';

class RMRegularisationRemoteRepository extends RMRegularisationAPI
    implements RMRegularisationRemoteDataSource {
  @override
  Future<List<RmRegularizeSearchResponse>?> searchRegularise(
      DateRangeRequest dateRangeRequest) async {
    try {
      Response response = await bffRestClient.post(searchRmRegulariseAPI
          .replaceFirst('startDateValue', dateRangeRequest.startDate ?? '')
          .replaceFirst('endDateValue', dateRangeRequest.endDate ?? ''),
          body: {'status': 'ALL'});
      List<RmRegularizeSearchResponse>? regularizeSearchResponseList;
      if (response.data != null && response.data is List) {
        regularizeSearchResponseList = <RmRegularizeSearchResponse>[];
        response.data.forEach((v) {
          regularizeSearchResponseList
              ?.add(RmRegularizeSearchResponse.fromJson(v));
        });
      }
      return regularizeSearchResponseList;
    } catch (e) {
      AppLog.e('searchRegularise : ${e.toString()}');
      rethrow;
    }
  }

  @override
  Future approvedRegularisation(Map<String,dynamic> body,String? regularisationId,bool? isApproved) async {
    try {
      Response response = await bffRestClient.put(approveRegulariseAPI.replaceAll('regulariseId', regularisationId!).replaceAll('approvedStatus',isApproved! ? 'approve' : 'reject'),body: body);
    } catch (e) {
      AppLog.e('approvedRegularisation : ${e.toString()}');
      rethrow;
    }
  }
}
