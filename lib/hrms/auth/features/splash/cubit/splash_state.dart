import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/data/model/ui_state.dart';

part 'splash_state.g.dart';

@CopyWith()
class SplashState extends Equatable {
  final UIState? uiState;
  final bool? isTimerCompleted;

  const SplashState({this.uiState, this.isTimerCompleted});

  @override
  List<Object?> get props => [uiState, isTimerCompleted];
}
