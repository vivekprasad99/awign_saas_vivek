import 'package:awign_saas/core/data/model/button_state.dart';
import 'package:awign_saas/core/data/model/ui_state.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

part 'rm_approved_dialog_state.g.dart';

@CopyWith()
class RmApprovedDialogState extends Equatable {
  final UIState? uiState;
  final ButtonState? buttonState;
  final String? amount;
  final String? amountError;
  final String? remark;
  final String? remarkError;

  const RmApprovedDialogState({
    this.uiState,
    this.buttonState = const ButtonState(isEnable: false),
    this.amount,
    this.amountError,
    this.remark,
    this.remarkError,
  });

  @override
  List<Object?> get props => [
        uiState,
        buttonState,
        amount,
        amountError,
        remark,
        remarkError,
      ];
}
