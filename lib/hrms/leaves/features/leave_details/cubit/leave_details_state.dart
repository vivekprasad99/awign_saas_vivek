import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/data/model/button_state.dart';
import '../../../../../core/data/model/ui_state.dart';
import '../../../data/model/leave.dart';

part 'leave_details_state.g.dart';

@CopyWith()
class LeaveDetailsState extends Equatable {
  final UIState? uiState;
  final ButtonState? buttonState;
  final Leave? leave;

  const LeaveDetailsState(
      {this.uiState, this.buttonState, this.leave});

  @override
  List<Object?> get props => [uiState, buttonState, leave];
}
