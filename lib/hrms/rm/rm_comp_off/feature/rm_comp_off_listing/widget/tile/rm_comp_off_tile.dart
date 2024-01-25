import 'package:awign_saas/core/extension/string_extension.dart';
import 'package:awign_saas/core/widget/buttons/my_ink_well.dart';
import 'package:awign_saas/core/widget/theme/color_schemes.g.dart';
import 'package:awign_saas/core/widget/theme/dimens.dart';
import 'package:awign_saas/hrms/comp_off/data/model/comp_off.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../../../core/utils/date_time_helper/date_time_helper.dart';

class RMCompOffTile extends StatelessWidget {
  final CompOff compOff;
  final Function(BuildContext, CompOff) onCompOffTap;
  const RMCompOffTile({required this.compOff, required this.onCompOffTap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyInkWell(
      onTap: () {
        onCompOffTap(context, compOff);
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
            buildDateAndCompOffStatusWidgets(context),
            const SizedBox(height: Dimens.padding_4),
            buildLeaveType(context),
          ],
        ),
      ),
    );
  }

  Widget buildDateAndCompOffStatusWidgets(BuildContext context) {
    String strStartDate = '';
    String strDay = '';
    if(compOff.workDate != null) {
      strStartDate = DateTimeHelper.getFormattedDateTime(inputDateTime: DateTime.parse(compOff.workDate!), DateTimeHelper.dateFormatDDMMMYYYY);
      strDay = DateTimeHelper.getFormattedDateTime(inputDateTime: DateTime.parse(compOff.workDate!), DateTimeHelper.prettyDateTimeFormatE);
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
                Text(strDay,
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
    switch (compOff.status) {
      CompOffStatus.pending => (CompOffStatus.pending.value, Get.theme.getCustomColor(context).warning250,
      Get.theme.getCustomColor(context).warning200),
      CompOffStatus.accepted => (CompOffStatus.accepted.value, Get.theme.getCustomColor(context).skirretgreen,
      Get.theme.getCustomColor(context).success100),
      CompOffStatus.rejected => (CompOffStatus.rejected.value, Get.theme.getCustomColor(context).warning250,
      Get.theme.getCustomColor(context).error100),
      CompOffStatus.withdraw => ('cancelled'.tr, Get.theme.getCustomColor(context).backgroundwhite,
      Get.theme.getCustomColor(context).backgroundgrey800),
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
        Flexible(
          child: Text(
            compOff.employeeRemark ?? '',
            overflow: TextOverflow.ellipsis,
            style: Get.textTheme.labelMedium?.copyWith(
                color: Get.theme.getCustomColor(context).backgroundgrey900,
                fontWeight: FontWeight.w600),
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(Dimens.padding_8, 0, 0, 0),
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
