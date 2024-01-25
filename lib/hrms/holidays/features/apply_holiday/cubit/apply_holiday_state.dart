import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/data/model/button_state.dart';
import '../../../../../core/data/model/ui_state.dart';
import '../../../../reimbursements/data/model/manager_response.dart';
import '../../../data/model/holiday_search_response.dart';

part 'apply_holiday_state.g.dart';

@CopyWith()
class ApplyHolidayState extends Equatable {
  final UIState? uiState;
  final ButtonState? buttonState;
  final String? reason;
  final String? reasonError;
  final DateTime? date;
  final String? dateError;
  final Holiday? holiday;
  final List<Manager>? managerList;
  final Manager? selectedManager;

  const ApplyHolidayState(
      {this.uiState,
        this.buttonState,
        this.reason,
        this.reasonError,
        this.date,
        this.dateError,
        this.holiday,
        this.managerList,
        this.selectedManager});

  @override
  List<Object?> get props => [
    uiState,
    buttonState,
    reason,
    reasonError,
    date,
    dateError,
    holiday,
    managerList,
    selectedManager,
  ];
}
