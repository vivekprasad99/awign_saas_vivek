import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/data/model/button_state.dart';
import '../../../../../core/data/model/ui_state.dart';

part 'apply_comp_off_state.g.dart';

@CopyWith()
class ApplyCompOffState extends Equatable {
  final UIState? uiState;
  final ButtonState? buttonState;
  final String? reason;
  final String? reasonError;
  final DateTime? date;
  final String? dateError;

  const ApplyCompOffState(
      {this.uiState,
      this.buttonState,
      this.reason,
      this.reasonError,
      this.date,
      this.dateError});

  @override
  List<Object?> get props => [
        uiState,
        buttonState,
        reason,
        reasonError,
        date,
        dateError,
      ];
}
