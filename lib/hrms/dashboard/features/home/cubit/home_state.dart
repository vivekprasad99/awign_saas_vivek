import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/data/model/button_state.dart';
import '../../../../../core/data/model/ui_state.dart';
import '../../../../attendance/data/model/punch_request.dart';

part 'home_state.g.dart';

@CopyWith()
class HomeState extends Equatable {
  final UIState? uiState;
  final ButtonState? buttonState;

  const HomeState({this.uiState, this.buttonState});

  @override
  List<Object?> get props => [uiState, buttonState];
}
