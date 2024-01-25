import 'package:awign_saas/core/data/model/ui_state.dart';
import 'package:awign_saas/core/exception/exception.dart';
import 'package:awign_saas/core/utils/app_log.dart';
import 'package:awign_saas/hrms/holidays/data/model/holiday_search_response.dart';
import 'package:awign_saas/hrms/holidays/data/network/repository/holiday_remote_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:get/get.dart';

import '../../../../leaves/data/model/leave.dart';
import 'holiday_listing_state.dart';

class HolidayListingCubit extends Cubit<HolidayListingState> {
  final HolidayRemoteRepository _holidayRemoteRepository;

  HolidayListingCubit(this._holidayRemoteRepository) : super(const HolidayListingState(currentTabIndex: 0));

  void updateCurrentTabIndex(int currentTabIndex) {
    emit(state.copyWith(currentTabIndex: currentTabIndex));
  }

  void searchHoliday() async {
    try {
      emit(state.copyWith(isLoading: true));
      HolidaySearchResponse holidaySearchResponse = await _holidayRemoteRepository.searchHoliday();
      emit(state.copyWith(allHolidayList: holidaySearchResponse.holidays,
          regularHolidayList: getRegularHolidayList(holidaySearchResponse.holidays),
          restrictedHolidayList: getRestrictedHolidayList(holidaySearchResponse.holidays),
          isLoading: false));
    } on ServerException catch (e) {
      emit(state.copyWith(isLoading: false, allHolidayList: null, uiState: UIState(failedWithoutAlertMessage: e.message!)));
    } on FailureException catch (e) {
      emit(state.copyWith(isLoading: false, allHolidayList: null, uiState: UIState(failedWithoutAlertMessage: e.message!)));
    } catch (e, st) {
      AppLog.e('searchHoliday : ${e.toString()} \n${st.toString()}');
      emit(state.copyWith(uiState: UIState(failedWithoutAlertMessage: 'we_regret_the_technical_error'.tr)));
    }
  }

  List<Holiday>? getRegularHolidayList(List<Holiday>? allHolidayList) {
    return allHolidayList?.where((element) => element.holidayType == HolidayType.holiday).toList();
  }

  List<Holiday>? getRestrictedHolidayList(List<Holiday>? allHolidayList) {
    return allHolidayList?.where((element) => element.holidayType == HolidayType.restricted).toList();
  }
}
