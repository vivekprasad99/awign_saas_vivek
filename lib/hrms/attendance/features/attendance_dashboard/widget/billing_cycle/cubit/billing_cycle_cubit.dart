import 'package:awign_saas/core/data/local/database/user_preferences/user_preferences.dart';
import 'package:awign_saas/core/utils/date_time_helper/date_time_helper.dart';
import 'package:awign_saas/hrms/attendance/data/model/billing_cycle.dart';
import 'package:bloc/bloc.dart';

import 'billing_cycle_state.dart';

class BillingCycleCubit extends Cubit<BillingCycleState> {
  BillingCycle? selectedBillingCycle;
  BillingCycleCubit() : super(const BillingCycleState());

  void loadBillingCycle(bool isShowNextBillingCycle, Function(BillingCycle? billingCycle)? onChanged) {
    List<BillingCycle> billingCycleList = [];
    int intBillingCycle = UserPreferences.getInstance().getCurrentUser()?.tenant?.billingCycle ?? 1;
    DateTime now = DateTime.now();

    if(isShowNextBillingCycle) {
      billingCycleList.add(createNextBillingCycle(now, intBillingCycle));
    }
    billingCycleList.add(createCurrentBillingCycle(now, intBillingCycle));
    for (int i = 0; i < 5; i++) {
      DateTime startDate = DateTime(now.year, (now.month - (i + 1)), intBillingCycle);
      DateTime endDate = DateTime(now.year, now.month - i, intBillingCycle - 1);
      BillingCycle billingCycle = BillingCycle(
          startDate,
          endDate,
          DateTimeHelper.getFormattedDateTime(
              DateTimeHelper.dateFormatDDMMMYYYY,
              inputDateTime: startDate),
          DateTimeHelper.getFormattedDateTime(
              DateTimeHelper.dateFormatDDMMMYYYY,
              inputDateTime: endDate));
      billingCycleList.add(billingCycle);
    }

    if(!isClosed) {
      emit(state.copyWith(billingCycleList: billingCycleList));
    }
    selectedBillingCycle = state.billingCycleList?.first;
    if(selectedBillingCycle?.startDate?.isAfter(DateTime.now()) ?? false) {
      selectedBillingCycle = state.billingCycleList?[1];
    }
    if(isShowNextBillingCycle) {
      selectedBillingCycle = state.billingCycleList?[1];
      if(selectedBillingCycle?.startDate?.isAfter(DateTime.now()) ?? false) {
        selectedBillingCycle = state.billingCycleList?[2];
      }
    }
    if(onChanged != null) {
      onChanged(selectedBillingCycle);
    }
    updateSelectedBillingCycle(selectedBillingCycle);
  }

  BillingCycle createCurrentBillingCycle(DateTime now, int intBillingCycle) {
    DateTime startDate = DateTime(now.year, now.month, intBillingCycle);
    DateTime endDate = DateTime(now.year, now.month + 1, intBillingCycle - 1);
    BillingCycle billingCycle = BillingCycle(
        startDate,
        endDate,
        DateTimeHelper.getFormattedDateTime(
            DateTimeHelper.dateFormatDDMMMYYYY,
            inputDateTime: startDate),
        DateTimeHelper.getFormattedDateTime(
            DateTimeHelper.dateFormatDDMMMYYYY,
            inputDateTime: endDate));
    return billingCycle;
  }

  BillingCycle createNextBillingCycle(DateTime now, int intBillingCycle) {
    DateTime startDate = DateTime(now.year, now.month + 1, intBillingCycle);
    DateTime endDate = DateTime(now.year, now.month + 2, intBillingCycle - 1);
    BillingCycle billingCycle = BillingCycle(
        startDate,
        endDate,
        DateTimeHelper.getFormattedDateTime(
            DateTimeHelper.dateFormatDDMMMYYYY,
            inputDateTime: startDate),
        DateTimeHelper.getFormattedDateTime(
            DateTimeHelper.dateFormatDDMMMYYYY,
            inputDateTime: endDate));
    return billingCycle;
  }

  void updateSelectedBillingCycle(BillingCycle? selectedBillingCycle) {
    emit(state.copyWith(selectedBillingCycle: selectedBillingCycle));
  }

  BillingCycle? getCurrentBillingCycle() {
    return selectedBillingCycle;
  }
}
