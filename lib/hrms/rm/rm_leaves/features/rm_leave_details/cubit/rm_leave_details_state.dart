import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../core/data/model/button_state.dart';
import '../../../../../../core/data/model/ui_state.dart';
import '../../../../../leaves/data/model/leave.dart';

part 'rm_leave_details_state.g.dart';

@CopyWith()
class RMLeaveDetailsState extends Equatable {
  final UIState? uiState;
  final ButtonState? approveButtonState;
  final ButtonState? rejectButtonState;
  final Leave? leave;

  const RMLeaveDetailsState(
      {this.uiState, this.approveButtonState, this.rejectButtonState, this.leave});

  @override
  List<Object?> get props => [uiState, approveButtonState, rejectButtonState, leave];
}
