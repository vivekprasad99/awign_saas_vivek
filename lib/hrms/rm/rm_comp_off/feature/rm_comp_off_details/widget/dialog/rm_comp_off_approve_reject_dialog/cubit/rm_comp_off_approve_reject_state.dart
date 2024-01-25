import 'package:awign_saas/hrms/comp_off/data/model/comp_off.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../../../../core/data/model/button_state.dart';
import '../../../../../../../../../core/data/model/ui_state.dart';

part 'rm_comp_off_approve_reject_state.g.dart';

@CopyWith()
class RMCompOffApproveRejectState extends Equatable {
  final UIState? uiState;
  final ButtonState? buttonState;
  final String? remarks;
  final CompOff? compOff;

  const RMCompOffApproveRejectState(
      {this.uiState,
        this.buttonState,
        this.remarks,
        this.compOff});

  @override
  List<Object?> get props => [
    uiState,
    buttonState,
    remarks,
  ];
}
