import 'package:awign_saas/hrms/rm/rm_attendance/data/model/filter_option.dart';
import 'package:bloc/bloc.dart';
import 'package:get/get.dart';

import '../../../data/model/date_filter_option.dart';
import '../../../data/model/shift_filter_option.dart';
import '../../../data/model/work_location_filter_option.dart';
import 'rm_attendance_filters_state.dart';

class RMAttendanceFiltersCubit extends Cubit<RMAttendanceFiltersState> {
  RMAttendanceFiltersCubit() : super(const RMAttendanceFiltersState()) {
    loadFilters();
  }
  
  void loadFilters() {
    List<FilterOption> filterOptionList = [];
    FilterOption dateFilterOption = DateFilterOption('date'.tr, true, null, null);
    filterOptionList.add(dateFilterOption);
    filterOptionList.add(ShiftFilterOption('shift'.tr, false));
    filterOptionList.add(WorkLocationFilterOption('work_location'.tr, false));
    emit(state.copyWith(filterOptionList: filterOptionList, lastSelectedFilter: dateFilterOption, lastSelectedFilterIndex: 0));
  }

  void updateMainFilterList(int index, FilterOption filterOption) {
    List<FilterOption> filterOptionList = List.from(state.filterOptionList!);
    List<FilterOption> tempFilterOptionList = [];
    tempFilterOptionList.addAll(filterOptionList);
    for(int i = 0; i < filterOptionList.length; i++) {
      FilterOption lFilterOption = filterOptionList[i];
      if(i == state.lastSelectedFilterIndex && state.lastSelectedFilter != null) {
        lFilterOption = updateFilterOption(state.lastSelectedFilter!, false);
        tempFilterOptionList[i] = lFilterOption;
      } else {
        lFilterOption = updateFilterOption(lFilterOption, false);
        tempFilterOptionList[i] = lFilterOption;
      }
    }
    filterOption = updateFilterOption(filterOption, true);
    tempFilterOptionList[index] = filterOption;
    emit(state.copyWith(filterOptionList: tempFilterOptionList, lastSelectedFilter: filterOption, lastSelectedFilterIndex: index));
  }

  FilterOption updateFilterOption(FilterOption filterOption, bool isSelected) {
    if(filterOption is DateFilterOption) {
      filterOption = filterOption.copyWith(isSelected: isSelected);
    } else if(filterOption is ShiftFilterOption) {
      filterOption = filterOption.copyWith(isSelected: isSelected);
    } else if(filterOption is WorkLocationFilterOption) {
      filterOption = filterOption.copyWith(isSelected: isSelected);
    }
    return filterOption;
  }

  void updateCustomDate(DateTime dateTime) {
    DateFilterOption dateFilterOption = state.lastSelectedFilter as DateFilterOption;
    dateFilterOption = dateFilterOption.copyWith(customDateTime: dateTime);
    emit(state.copyWith(lastSelectedFilter: dateFilterOption));
  }

  void updateDateOption(int groupValue) {
    DateFilterOption dateFilterOption = state.lastSelectedFilter as DateFilterOption;
    dateFilterOption = dateFilterOption.copyWith(groupValue: groupValue);
    emit(state.copyWith(lastSelectedFilter: dateFilterOption));
  }
}
