import 'package:awign_saas/core/extension/string_extension.dart';
import 'package:awign_saas/core/widget/buttons/my_ink_well.dart';
import 'package:awign_saas/core/widget/theme/color_schemes.g.dart';
import 'package:awign_saas/core/widget/theme/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../../core/utils/date_time_helper/date_time_helper.dart';
import '../../../../data/model/regularisation_status_response.dart';

class RegularisationTile extends StatelessWidget {
  final Regularisation regularisation;
  final Function(BuildContext, Regularisation) onRegularisationTap;
  final Function(BuildContext, Regularisation) onApplyLeaveTap;
  const RegularisationTile({required this.regularisation, required this.onRegularisationTap, required this.onApplyLeaveTap, Key? key}) : super(key: key);

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
        children: [
          MyInkWell(
            onTap: () {
              onRegularisationTap(context, regularisation);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                buildDateAndLeaveStatusWidgets(context),
                const SizedBox(height: Dimens.padding_4),
                buildLeaveType(context),
              ],
            ),
          ),
          const SizedBox(height: Dimens.padding_16),
          buildApplyLeaveButton(context),
        ],
      ),
    );
  }

  Widget buildDateAndLeaveStatusWidgets(BuildContext context) {
    String strStartDate = '';
    if(regularisation.date != null) {
      strStartDate = DateTimeHelper.getFormattedDateTime(inputDateTime: DateTime.parse(regularisation.date!), DateTimeHelper.dateFormatDDMMMYYYY);
    }
    String strDayApplication = '';
    // if(regularisation.numberOfDays != null && regularisation.numberOfDays == 1) {
    //   strDayApplication = '${regularisation.numberOfDays?.round()} ${'day_application'.tr}';
    // } else if(regularisation.numberOfDays != null && regularisation.numberOfDays! > 1) {
    //   strDayApplication = '${regularisation.numberOfDays?.round()} ${'days_application'.tr}';
    // }
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
    switch (regularisation.status) {
      RegularisationStatus.pending => (RegularisationStatus.pending.value, Get.theme.getCustomColor(context).warning250,
      Get.theme.getCustomColor(context).warning200),
      RegularisationStatus.approved => (RegularisationStatus.approved.value, Get.theme.getCustomColor(context).skirretgreen,
      Get.theme.getCustomColor(context).success100),
      RegularisationStatus.rejected => (RegularisationStatus.rejected.value, Get.theme.getCustomColor(context).warning250,
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

  Widget buildLeaveType(BuildContext context) {
    String strInitiatedDate = DateTimeHelper.getFormattedDateTime(inputDateTime: DateTime.parse(regularisation.createdAt!), DateTimeHelper.dateFormatDDMMMYYYY);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '${'regularisation_initiated'.tr} $strInitiatedDate',
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

  Widget buildApplyLeaveButton(BuildContext context) {
    if (regularisation.status == RegularisationStatus.rejected) {
      return MyInkWell(
        onTap: () {
          onApplyLeaveTap(context, regularisation);
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
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
