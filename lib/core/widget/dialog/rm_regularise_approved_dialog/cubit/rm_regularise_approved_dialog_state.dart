import 'package:awign_saas/core/data/model/button_state.dart';
import 'package:awign_saas/core/data/model/ui_state.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

part 'rm_regularise_approved_dialog_state.g.dart';

@CopyWith()
class RmRegulariseApprovedDialogState extends Equatable {
  final UIState? uiState;
  final ButtonState? buttonState;
  final String? punchInTime;
  final String? punchInTimeError;
  final String? punchOutTime;
  final String? punchOutTimeError;
  final String? remark;
  final String? remarkError;

  const RmRegulariseApprovedDialogState({
    this.uiState,
    this.buttonState = const ButtonState(),
    this.punchInTime,
    this.punchInTimeError,
    this.remark,
    this.remarkError,
    this.punchOutTime,
    this.punchOutTimeError
  });

  @override
  List<Object?> get props => [
    uiState,
    buttonState,
    punchInTime,
    punchInTimeError,
    remark,
    remarkError,
    punchOutTime,
    punchOutTimeError
  ];
}