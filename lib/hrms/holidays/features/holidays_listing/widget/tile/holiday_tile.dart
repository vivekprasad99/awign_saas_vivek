import 'package:awign_saas/core/widget/theme/color_schemes.g.dart';
import 'package:awign_saas/core/widget/theme/dimens.dart';
import 'package:awign_saas/hrms/leaves/data/model/leave.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../../core/utils/date_time_helper/date_time_helper.dart';
import '../../../../../../core/widget/buttons/my_ink_well.dart';
import '../../../../data/model/holiday_search_response.dart';

class HolidayTile extends StatelessWidget {
  final BuildContext context;
  final Holiday holiday;
  final Function(BuildContext, Holiday) onApplyLeaveTap;
  const HolidayTile({Key? key, required this.context, required this.holiday, required this.onApplyLeaveTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimens.padding_8),
        color: Get.theme.colorScheme.onPrimary,
        border: Border.all(
          color: AppColors.lightCustomColors.sourceBackgroundgrey400!,
        ),
      ),
      padding: const EdgeInsets.all(Dimens.padding_16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildDateAndHolidayStatusWidgets(),
          const SizedBox(height: Dimens.padding_16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(holiday.name ?? '',
                  style: Get.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600, color: Get.theme.getCustomColor(Get.context!).backgroundgrey900)),
              buildApplyLeaveButton(),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildDateAndHolidayStatusWidgets() {
    String strDate = '';
    if(holiday.date != null) {
      strDate = DateTimeHelper.getFormattedDateTime(DateTimeHelper.dateFormatDDMMMYYYY, inputDateTime: DateTime.parse(holiday.date!));
    }
    String strWeekDay = '';
    if(holiday.date != null) {
      strWeekDay = DateTimeHelper.getFormattedDateTime(DateTimeHelper.dateFormatEEEE, inputDateTime: DateTime.parse(holiday.date!));
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                strDate,
                style: Get.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: Dimens.padding_4),
            Text(
                strWeekDay,
                style: Get.textTheme.bodySmall?.copyWith(color: Get.theme.getCustomColor(Get.context!).backgroundgrey700)),
          ],
        ),
        buildHolidayWidget(),
      ],
    );
  }

  Widget buildHolidayWidget() {
    if (holiday.holidayType == HolidayType.holiday) {
      return Container(
        padding: const EdgeInsets.all(Dimens.padding_8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimens.padding_8),
          color: Get.theme.getCustomColor(Get.context!).backgroundgrey300,
        ),
        child: Text('holiday'.tr, style: Get.textTheme.labelMedium?.copyWith(color: Get.theme.getCustomColor(Get.context!).backgroundgrey700)),
      );
    } else {
      return const SizedBox();
    }
  }

  Widget buildApplyLeaveButton() {
    bool isShowButton = false;
    if (holiday.holidayType == HolidayType.restricted) {
      isShowButton = true;
      if (holiday.holidayTransaction != null && (holiday.holidayTransaction?.leaveStatus != LeaveStatus.rejected
          || holiday.holidayTransaction?.leaveStatus != LeaveStatus.withdrawn)) {
        isShowButton = false;
      }
    }
    if (isShowButton) {
      return MyInkWell(
        onTap: () {
          onApplyLeaveTap(context, holiday);
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('apply_leave'.tr,
                style: Get.textTheme.labelMedium?.copyWith(color: Get.theme
                    .getCustomColor(Get.context!)
                    .secondary1300, fontWeight: FontWeight.w700)),
            const SizedBox(width: Dimens.padding_8,),
            SvgPicture.asset(
              'assets/images/ic_arrow_forward.svg',
            ),
          ],
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}
