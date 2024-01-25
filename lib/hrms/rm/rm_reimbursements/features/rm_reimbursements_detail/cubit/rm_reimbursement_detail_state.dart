import 'package:awign_saas/core/data/model/button_state.dart';
import 'package:awign_saas/core/data/model/ui_state.dart';
import 'package:awign_saas/hrms/reimbursements/data/model/reimbursement_detail_response.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

part 'rm_reimbursement_detail_state.g.dart';

@CopyWith()
class RMReimbursementDetailState extends Equatable {
  final UIState? uiState;
  final ButtonState? buttonState;
  final ReimbursementDetailResponse? reimbursementDetailResponse;
  final bool? isLoading;

  const RMReimbursementDetailState(
      {this.uiState, this.buttonState,this.reimbursementDetailResponse,this.isLoading});

  @override
  List<Object?> get props => [uiState, buttonState,reimbursementDetailResponse,isLoading];
}