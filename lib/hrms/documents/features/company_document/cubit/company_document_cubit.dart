import 'package:awign_saas/core/data/model/advance_search/advance_search_request.dart';
import 'package:awign_saas/core/data/model/advance_search/operator.dart';
import 'package:awign_saas/core/exception/exception.dart';
import 'package:awign_saas/core/utils/app_log.dart';
import 'package:awign_saas/hrms/documents/data/model/document_search_response.dart';
import 'package:awign_saas/hrms/documents/data/network/repository/document_remote_repository.dart';
import 'package:awign_saas/hrms/documents/features/company_document/cubit/company_document_state.dart';
import 'package:bloc/bloc.dart';
import 'package:get/get.dart';

import '../../../../../core/data/model/ui_state.dart';

class CompanyDocumentCubit extends Cubit<CompanyDocumentState> {
  final DocumentRemoteRepository _documentRemoteRepository;
  CompanyDocumentCubit(this._documentRemoteRepository) : super(const CompanyDocumentState());

  void searchDocument(String documentType,String userId) async {
    try {
      emit(state.copyWith(isSearchDocumentLoading: true));
    var advancedSearchRequest = AdvanceSearchRequestBuilder();
    advancedSearchRequest
        .putPropertyToCondition(AdvancedSearchRequest.type, Operator.equal,documentType == 'payslips'
        ? 'PAYSLIP'
        : documentType == 'policies'
        ? 'POLICY'
        : documentType == 'personal' ? 'PERSONAL' : 'FORM_16');
    if(documentType != 'policies')
      {
        advancedSearchRequest
            .putPropertyToCondition(AdvancedSearchRequest.employeeUuid, Operator.equal, userId);
      }
    DocumentSearchResponse documentSearchResponse = await _documentRemoteRepository.searchDocument(advancedSearchRequest.build());
    emit(state.copyWith(isSearchDocumentLoading: false,documents: documentSearchResponse.documents));
    } on ServerException catch (e) {
    emit(state.copyWith(isSearchDocumentLoading: false, documents: null, uiState: UIState(failedWithoutAlertMessage: e.message!)));
    } on FailureException catch (e) {
    emit(state.copyWith(isSearchDocumentLoading: false, documents: null, uiState: UIState(failedWithoutAlertMessage: e.message!)));
    } catch (e, st) {
    AppLog.e('searchDocument : ${e.toString()} \n${st.toString()}');
    emit(state.copyWith(isSearchDocumentLoading: false, documents: null, uiState: UIState(failedWithoutAlertMessage: 'we_regret_the_technical_error'.tr)));
    }
  }
}
