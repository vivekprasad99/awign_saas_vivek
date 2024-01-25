import 'dart:convert';

import 'package:awign_saas/core/data/network/client/rest_client.dart';
import 'package:awign_saas/core/utils/app_log.dart';
import 'package:awign_saas/hrms/faq/data/model/faq_navbar_data.dart';
import 'package:awign_saas/hrms/faq/data/model/faq_response.dart';
import 'package:awign_saas/hrms/faq/data/network/api/faq_api.dart';
import 'package:awign_saas/hrms/faq/data/network/data_source/faq_remote_data_source.dart';
import 'package:dio/dio.dart';

class FaqRemoteRepository extends FaqAPI implements FaqRemoteDataSource {
  @override
  Future<FaqResponse> getFaq(String type) async {
    try {
      Response response =
          await bffRestClient.get(getFaqListAPI, queryParams: {'type': type});
      return FaqResponse.fromJson(response.data);
    } catch (e) {
      AppLog.e('getFaq : ${e.toString()}');
      rethrow;
    }
  }

  @override
  Future<FaqsTypeResponse> getFaqType() async {
    try {
      Response response =
      await bffRestClient.get(getFaqTypeAPI);
      return FaqsTypeResponse.fromJson(response.data);
    } catch (e) {
      AppLog.e('getFaq : ${e.toString()}');
      rethrow;
    }
  }
}
