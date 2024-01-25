import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../../../../core/data/model/button_state.dart';
import '../../../../../../../../../core/data/model/ui_state.dart';
import '../../../../../../../../leaves/data/model/leave.dart';

part 'rm_leave_approve_state.g.dart';

@CopyWith()
class RMLeaveApproveState extends Equatable {
  final UIState? uiState;
  final ButtonState? buttonState;
  final String? remarks;
  final Leave? leave;

  const RMLeaveApproveState(
      {this.uiState,
        this.buttonState,
        this.remarks,
        this.leave});

  @override
  List<Object?> get props => [
    uiState,
    buttonState,
    remarks,
  ];
}
