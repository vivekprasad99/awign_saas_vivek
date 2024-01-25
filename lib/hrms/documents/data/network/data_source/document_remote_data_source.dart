
import 'package:awign_saas/core/data/model/advance_search/advance_search_request.dart';
import 'package:awign_saas/hrms/documents/data/model/document_search_response.dart';

abstract class DocumentRemoteDataSource {
  Future<DocumentSearchResponse> searchDocument(AdvancedSearchRequest advancedSearchRequest);
}