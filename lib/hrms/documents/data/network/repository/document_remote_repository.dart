import 'package:awign_saas/core/data/model/advance_search/advance_search_request.dart';
import 'package:awign_saas/core/data/network/client/rest_client.dart';
import 'package:awign_saas/core/utils/app_log.dart';
import 'package:awign_saas/hrms/documents/data/model/document_search_response.dart';
import 'package:awign_saas/hrms/documents/data/network/api/document_api.dart';
import 'package:awign_saas/hrms/documents/data/network/data_source/document_remote_data_source.dart';
import 'package:dio/dio.dart';

class DocumentRemoteRepository extends DocumentAPI
    implements DocumentRemoteDataSource {

  @override
  Future<DocumentSearchResponse> searchDocument(AdvancedSearchRequest advancedSearchRequest) async {
    try {
      Response response = await bffRestClient
          .post(searchDocumentAPI,body: advancedSearchRequest.toJson(),);
      return DocumentSearchResponse.fromJson(response.data);
    } catch (e) {
      AppLog.e('searchDocument : ${e.toString()}');
      rethrow;
    }
  }
}