import 'package:awign_saas/hrms/comp_off/data/model/comp_off.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/data/model/button_state.dart';
import '../../../../../core/data/model/ui_state.dart';

part 'comp_off_details_state.g.dart';

@CopyWith()
class CompOffDetailsState extends Equatable {
  final UIState? uiState;
  final ButtonState? buttonState;
  final CompOff? compOff;

  const CompOffDetailsState(
      {this.uiState, this.buttonState, this.compOff});

  @override
  List<Object?> get props => [uiState, buttonState, compOff];
}
