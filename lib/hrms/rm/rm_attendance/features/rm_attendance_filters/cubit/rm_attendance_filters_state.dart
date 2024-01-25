import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import '../../../../../../core/data/model/button_state.dart';
import '../../../../../../core/data/model/ui_state.dart';
import '../../../data/model/filter_option.dart';

part 'rm_attendance_filters_state.g.dart';

@CopyWith()
class RMAttendanceFiltersState extends Equatable {
  final UIState? uiState;
  final List<FilterOption>? filterOptionList;
  final FilterOption? lastSelectedFilter;
  final int? lastSelectedFilterIndex;
  final ButtonState? buttonState;

  const RMAttendanceFiltersState(
      {this.uiState, this.filterOptionList, this.lastSelectedFilter, this.lastSelectedFilterIndex, this.buttonState});

  @override
  List<Object?> get props => [uiState, filterOptionList, lastSelectedFilter, lastSelectedFilterIndex, buttonState];
}
