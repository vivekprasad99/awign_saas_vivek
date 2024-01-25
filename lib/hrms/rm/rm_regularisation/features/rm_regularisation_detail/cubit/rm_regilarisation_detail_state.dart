import 'package:awign_saas/core/data/model/ui_state.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

import '../../../data/model/regularize_search_response.dart';

part 'rm_regilarisation_detail_state.g.dart';

@CopyWith()
class RmRegilarisationDetailState extends Equatable {
  final UIState? uiState;
  final bool? isLoading;
  final RmRegularizeSearchResponse? rmRegularizeSearchResponse;

  const RmRegilarisationDetailState({this.uiState, this.isLoading,
     this.rmRegularizeSearchResponse,});

  @override
  List<Object?> get props => [uiState, isLoading,rmRegularizeSearchResponse];
}
