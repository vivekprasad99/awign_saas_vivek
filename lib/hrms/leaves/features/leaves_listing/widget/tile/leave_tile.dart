import 'package:awign_saas/core/extension/string_extension.dart';
import 'package:awign_saas/core/widget/buttons/my_ink_well.dart';
import 'package:awign_saas/core/widget/theme/color_schemes.g.dart';
import 'package:awign_saas/core/widget/theme/dimens.dart';
import 'package:awign_saas/hrms/leaves/data/model/leave.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../../core/utils/date_time_helper/date_time_helper.dart';

class LeaveTile extends StatelessWidget {
  final Leave leave;
  final Function(BuildContext, Leave) onLeaveTap;
  const LeaveTile({required this.leave, required this.onLeaveTap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyInkWell(
      onTap: () {
        onLeaveTap(context, leave);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimens.padding_8),
          color: Get.theme.colorScheme.onPrimary,
          border: Border.all(
            color: AppColors.lightCustomColors.sourceBackgroundgrey400!,
          ),
        ),
        padding: const EdgeInsets.all(Dimens.padding_16),
        child: Column(
          children: [
            buildDateAndLeaveStatusWidgets(context),
            const SizedBox(height: Dimens.padding_4),
            buildLeaveType(context),
          ],
        ),
      ),
    );
  }

  Widget buildDateAndLeaveStatusWidgets(BuildContext context) {
    String strStartDate = '';
    if(leave.startDate != null) {
      strStartDate = DateTimeHelper.getFormattedDateTime(inputDateTime: DateTime.parse(leave.startDate!), DateTimeHelper.dateFormatDDMMMYYYY);
    }
    String strDayApplication = '';
    if(leave.numberOfDays != null && leave.numberOfDays! <= 1) {
      strDayApplication = '${leave.numberOfDays} ${'day_application'.tr}';
    } else if(leave.numberOfDays != null && leave.numberOfDays! > 1) {
      strDayApplication = '${leave.numberOfDays} ${'days_application'.tr}';
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(strStartDate,
                    style: Get.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700)),
                const SizedBox(height: Dimens.padding_4),
                Text(strDayApplication,
                    style: Get.textTheme.labelMedium?.copyWith(color: Get.theme.getCustomColor(context).backgroundgrey700, fontWeight: FontWeight.w400)),
              ],
            ),
          ],
        ),
        buildStatus(context),
      ],
    );
  }

  Widget buildStatus(BuildContext context) {
    var (String text, Color? textColor, Color? bgColor) =
    switch (leave.status) {
      LeaveStatus.pending => (LeaveStatus.pending.value, Get.theme.getCustomColor(context).warning250,
        Get.theme.getCustomColor(context).warning200),
      LeaveStatus.approved => (LeaveStatus.approved.value, Get.theme.getCustomColor(context).skirretgreen,
        Get.theme.getCustomColor(context).success100),
      LeaveStatus.rejected => (LeaveStatus.rejected.value, Get.theme.getCustomColor(context).warning250,
        Get.theme.getCustomColor(context).error100),
      LeaveStatus.withdrawn => ('cancelled'.tr, Get.theme.getCustomColor(context).warning250,
      Get.theme.getCustomColor(context).warning200),
      _ => ('', Get.theme.getCustomColor(context).warning250,
        Get.theme.getCustomColor(context).warning200),
    };
    return Container(
      padding: const EdgeInsets.fromLTRB(Dimens.padding_8, Dimens.padding_4, Dimens.padding_8, Dimens.padding_4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimens.padding_8),
        color: bgColor,
      ),
      child: Text(text.toLowerCase().toTitleCase(),
          style: Get.textTheme.labelMedium
              ?.copyWith(color: textColor)),
    );
  }

  Widget buildLeaveType(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          leave.leaveType ?? '',
          style: Get.textTheme.labelMedium?.copyWith(
              color: Get.theme.getCustomColor(context).backgroundgrey900,
              fontWeight: FontWeight.w600),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(Dimens.padding_12, Dimens.padding_8, Dimens.padding_12, Dimens.padding_8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimens.padding_8),
            color: Get.theme.getCustomColor(context).secondary1200!,
          ),
          child: SvgPicture.asset(
            'assets/images/ic_right_arrow_purple.svg',
          ),
        )
      ],
    );
  }
}
