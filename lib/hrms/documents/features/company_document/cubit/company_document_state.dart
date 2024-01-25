import 'package:awign_saas/core/data/model/button_state.dart';
import 'package:awign_saas/core/data/model/ui_state.dart';
import 'package:awign_saas/hrms/documents/data/model/document_search_response.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

part 'company_document_state.g.dart';

@CopyWith()
class CompanyDocumentState extends Equatable {
  final UIState? uiState;
  final ButtonState? buttonState;
  final bool? isSearchDocumentLoading;
  final List<Documents>? documents;

  const CompanyDocumentState({this.uiState, this.buttonState,this.isSearchDocumentLoading,this.documents});

  @override
  List<Object?> get props => [uiState, buttonState,isSearchDocumentLoading,documents];
}
