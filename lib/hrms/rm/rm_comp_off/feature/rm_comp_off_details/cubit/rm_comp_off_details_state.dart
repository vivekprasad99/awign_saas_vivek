import 'package:awign_saas/hrms/comp_off/data/model/comp_off.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../core/data/model/button_state.dart';
import '../../../../../../core/data/model/ui_state.dart';

part 'rm_comp_off_details_state.g.dart';

@CopyWith()
class RMCompOffDetailsState extends Equatable {
  final UIState? uiState;
  final ButtonState? approveButtonState;
  final ButtonState? rejectButtonState;
  final CompOff? compOff;

  const RMCompOffDetailsState(
      {this.uiState, this.approveButtonState, this.rejectButtonState, this.compOff});

  @override
  List<Object?> get props => [uiState, approveButtonState, rejectButtonState, compOff];
}
