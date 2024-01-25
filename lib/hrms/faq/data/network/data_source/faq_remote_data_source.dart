
import 'package:awign_saas/hrms/faq/data/model/faq_navbar_data.dart';
import 'package:awign_saas/hrms/faq/data/model/faq_response.dart';

abstract class FaqRemoteDataSource {
  Future<FaqResponse> getFaq(String type);
  Future<FaqsTypeResponse> getFaqType();
}