import 'package:awign_saas/hrms/reimbursements/data/model/appy_reimbursement_data.dart';
import 'package:awign_saas/hrms/reimbursements/data/model/category_response.dart';
import 'package:awign_saas/hrms/reimbursements/data/model/manager_response.dart';
import 'package:awign_saas/hrms/reimbursements/data/model/reimbursement_detail_response.dart';
import 'package:awign_saas/hrms/reimbursements/data/model/reimbursement_response.dart';
import 'package:awign_saas/hrms/reimbursements/data/model/reimbursement_type_response.dart';

abstract class ReimbursementRemoteDataSource {
  Future<ReimbursementResponse> getAllReimbursement(String status,String startDate,String endDate);
  Future createReimbursement(ApplyReimbursementData applyReimbursementData);
  Future<ReimbursementCategoryResponse> getReimbursementCategory();
  Future<ReimbursementDetailResponse> getReimbursement(String uuid);
  Future<ManagerResponse> getManager(String id);
  Future<ReimbursementTypeResponse> getReimbursementTypes();
}