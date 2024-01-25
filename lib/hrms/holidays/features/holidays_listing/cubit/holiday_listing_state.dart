import 'package:awign_saas/core/data/model/button_state.dart';
import 'package:awign_saas/core/data/model/ui_state.dart';
import 'package:awign_saas/hrms/holidays/data/model/holiday_search_response.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

import '../../../../leaves/data/model/leave.dart';

part 'holiday_listing_state.g.dart';

@CopyWith()
class HolidayListingState extends Equatable {
  final UIState? uiState;
  final ButtonState? buttonState;
  final int? currentTabIndex;
  final bool? isLoading;
  final List<Holiday>? allHolidayList;
  final List<Holiday>? regularHolidayList;
  final List<Holiday>? restrictedHolidayList;

  const HolidayListingState({
    this.uiState,
    this.buttonState,
    this.currentTabIndex,
    this.isLoading,
    this.allHolidayList,
    this.regularHolidayList,
    this.restrictedHolidayList,
  });

  @override
  List<Object?> get props => [
        uiState,
        buttonState,
        currentTabIndex,
        isLoading,
        allHolidayList,
        regularHolidayList,
        restrictedHolidayList
      ];
}
