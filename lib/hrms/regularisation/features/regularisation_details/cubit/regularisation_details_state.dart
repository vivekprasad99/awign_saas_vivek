import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/data/model/button_state.dart';
import '../../../../../core/data/model/ui_state.dart';
import '../../../data/model/regularisation_status_response.dart';

part 'regularisation_details_state.g.dart';

@CopyWith()
class RegularisationDetailsState extends Equatable {
  final UIState? uiState;
  final ButtonState? buttonState;
  final Regularisation? regularisation;

  const RegularisationDetailsState(
      {this.uiState, this.buttonState, this.regularisation});

  @override
  List<Object?> get props => [uiState, buttonState, regularisation];
}
