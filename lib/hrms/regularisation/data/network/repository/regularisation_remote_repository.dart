import 'package:awign_saas/hrms/regularisation/data/model/regularisation_request.dart';
import 'package:awign_saas/hrms/regularisation/data/model/regularisation_status_response.dart';
import 'package:awign_saas/hrms/regularisation/data/network/api/regularisation_api.dart';
import 'package:awign_saas/hrms/regularisation/data/network/data_source/regularisation_remote_data_source.dart';
import 'package:dio/dio.dart';

import '../../../../../core/data/network/client/rest_client.dart';
import '../../../../../core/utils/app_log.dart';
import '../../../../attendance/data/model/date_range_request.dart';

class RegularisationRemoteRepository extends RegularisationAPI
    implements RegularisationRemoteDataSource {
  @override
  Future<Regularisation> requestRegularisation(RegularisationRequest regularisationRequest) async {
    try {
      Response response = await bffRestClient.post(requestRegularisationAPI,
          body: regularisationRequest.toJson());
      return Regularisation.fromJson(response.data);
    } catch (e) {
      AppLog.e('requestRegularisation : ${e.toString()}');
      rethrow;
    }
  }

  @override
  Future<List<Regularisation>?> getRegularisationStatus(DateRangeRequest dateRangeRequest) async {
    try {
      Response response = await bffRestClient.get(getRegularisationStatusAPI, queryParams: dateRangeRequest.toJson());
      List<Regularisation>? regularisationList;
      if (response.data != null && response.data is List) {
        regularisationList = <Regularisation>[];
        response.data.forEach((v) {
          regularisationList?.add(Regularisation.fromJson(v));
        });
      }
      return regularisationList;
    } catch (e) {
      AppLog.e('getRegularisationStatus : ${e.toString()}');
      rethrow;
    }
  }

  @override
  Future<void> withdrawRegularisation(String regularisationID) async {
    try {
      Response response = await bffRestClient.put(withdrawRegularisationAPI.replaceFirst('regularisationID', regularisationID));
      AppLog.e('getRegularisationStatus : ${response.toString()}');
    } catch (e) {
      AppLog.e('withdrawRegularisation : ${e.toString()}');
      rethrow;
    }
  }
}
