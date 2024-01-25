import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../../core/data/model/ui_state.dart';

part 'banner_state.g.dart';

@CopyWith()
class BannerState extends Equatable {
  final UIState? uiState;
  final int? currentPageIndex;

  const BannerState(
      {this.uiState, this.currentPageIndex});

  @override
  List<Object?> get props => [uiState, currentPageIndex];
}
