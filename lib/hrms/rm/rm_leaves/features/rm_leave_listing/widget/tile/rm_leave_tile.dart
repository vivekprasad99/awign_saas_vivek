import 'package:awign_saas/core/extension/string_extension.dart';
import 'package:awign_saas/core/widget/buttons/my_ink_well.dart';
import 'package:awign_saas/core/widget/theme/color_schemes.g.dart';
import 'package:awign_saas/core/widget/theme/dimens.dart';
import 'package:awign_saas/hrms/leaves/data/model/leave.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class RMLeaveTile extends StatelessWidget {
  final Leave leave;
  final Function(BuildContext, Leave) onLeaveTap;
  const RMLeaveTile({required this.leave, required this.onLeaveTap, Key? key}) : super(key: key);

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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildAvatar(),
                const SizedBox(width: Dimens.padding_8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildName(context),
                      buildEmployeeID(context),
                    ],
                  ),
                ),
                buildStatus(context),
              ],
            ),
            const SizedBox(height: Dimens.padding_16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildNoOfDays(context),
                      const SizedBox(height: Dimens.padding_4),
                      buildReason(context),
                    ],
                  ),
                ),
                buildRightArrow(context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAvatar() {
    return SvgPicture.asset(
      'assets/images/ic_circular_profile_place_holder.svg',
    );
  }

  Widget buildName(BuildContext context) {
    String name = leave.employeeName ?? '';
    return Text(name,
        style: Get.textTheme.labelLarge?.copyWith(color: Get.theme.getCustomColor(context).backgroundgrey900, fontWeight: FontWeight.w700));
  }

  Widget buildEmployeeID(BuildContext context) {
    String employeeID = leave.employeeUid ?? '';
    return Text(employeeID,
        style: Get.textTheme.labelMedium?.copyWith(color: Get.theme.getCustomColor(context).backgroundgrey700, fontWeight: FontWeight.w400));
  }

  Widget buildStatus(BuildContext context) {
    var (String text, Color? textColor, Color? bgColor) =
    switch (leave.leaveStatus) {
      LeaveStatus.pending => (LeaveStatus.pending.value, Get.theme.getCustomColor(context).warning250,
      Get.theme.getCustomColor(context).warning200),
      LeaveStatus.approved => (LeaveStatus.approved.value, Get.theme.getCustomColor(context).skirretgreen,
      Get.theme.getCustomColor(context).success100),
      LeaveStatus.rejected => (LeaveStatus.rejected.value, Get.theme.getCustomColor(context).warning250,
      Get.theme.getCustomColor(context).error100),
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

  Widget buildNoOfDays(BuildContext context) {
    String strDayApplication = '';
    if(leave.numberOfDays != null && leave.numberOfDays! <= 1) {
      strDayApplication = '${leave.numberOfDays} ${'day_application'.tr}';
    } else if(leave.numberOfDays != null && leave.numberOfDays! > 1) {
      strDayApplication = '${leave.numberOfDays} ${'days_application'.tr}';
    }
    return buildLabelWithAnswerWidget(context, '${'no_of_days'.tr}:', strDayApplication);
  }

  Widget buildReason(BuildContext context) {
    return buildLabelWithAnswerWidget(context, '${'reason'.tr}:', leave.reason ?? '');
  }

  Widget buildLabelWithAnswerWidget(BuildContext context, String label, String answer) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: Get.textTheme.labelMedium?.copyWith(color: Get.theme.getCustomColor(context).backgroundgrey900)),
        const SizedBox(width: Dimens.padding_4),
        Flexible(
          child: Text(answer,
              style: Get.textTheme.labelMedium?.copyWith(color: Get.theme.getCustomColor(context).backgroundgrey900, fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }

  Widget buildRightArrow(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(Dimens.padding_12, Dimens.padding_8, Dimens.padding_12, Dimens.padding_8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimens.padding_8),
        color: Get.theme.getCustomColor(context).secondary1200!,
      ),
      child: SvgPicture.asset(
        'assets/images/ic_right_arrow_purple.svg',
      ),
    );
  }
}
