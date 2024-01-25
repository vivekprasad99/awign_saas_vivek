import 'package:awign_saas/core/extension/string_extension.dart';
import 'package:awign_saas/core/utils/constants.dart';
import 'package:awign_saas/core/utils/date_time_helper/date_time_helper.dart';
import 'package:awign_saas/core/widget/theme/color_schemes.g.dart';
import 'package:awign_saas/core/widget/theme/dimens.dart';
import 'package:awign_saas/hrms/rm/rm_regularisation/data/model/regularize_search_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../../regularisation/data/model/regularisation_status_response.dart';



class RmRegularisationTile extends StatelessWidget {
  final Regularization regularisation;
  final int index;

  const RmRegularisationTile({Key? key,
    required this.regularisation,
    required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimens.padding_8),
        color: Get.theme.colorScheme.onPrimary,
        border: Border.all(
          color: Get.theme
              .getCustomColor(context)
              .backgroundgrey400!,
        ),
      ),
      padding: const EdgeInsets.all(Dimens.padding_16),
      child: Column(
        children: [
          buildManagerRegulariseType(),
          const SizedBox(height: Dimens.padding_16),
          buildRegulariseDate(),
        ],
      ),
    );
  }

  Widget buildManagerRegulariseType() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipOval(
          child: Image.network(
            "https://urmstonpartnership.org.uk/wp-content/uploads/2019/01/dummy-profile-image.png",
            width: Dimens.btnWidth_40,
            height: Dimens.btnWidth_40,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: Dimens.margin_12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${regularisation.employeeName}",
                  style: Get.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: Get.theme
                          .getCustomColor(Get.context!)
                          .backgroundgrey900)),
              Text("${regularisation.employeeId}",
                  style: Get.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Get.theme
                          .getCustomColor(Get.context!)
                          .backgroundgrey700)),
            ],
          ),
        ),
        const Spacer(),
        buildStatus(),
      ],
    );
  }

  Widget buildStatus() {
    return Container(
      padding: const EdgeInsets.all(Dimens.padding_4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimens.padding_8),
        color: getColor(regularisation.status!)[Constants.bgColor],
      ),
      child: Text(regularisation.status?.value.toCapitalized() ?? "",
          style: Get.textTheme.titleSmall?.copyWith(
              color: getColor(regularisation.status!)[Constants.statusColor]
          )),
    );
  }

  Widget buildRegulariseDate() {
    String strStartDate = '';
    if(regularisation.date != null) {
      strStartDate = DateTimeHelper.getFormattedDateTime(inputDateTime: DateTime.parse(regularisation.date!), DateTimeHelper.dateFormatDDMMMYYYY);
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Regularise: $strStartDate",
            style: Get.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: Get.theme
                    .getCustomColor(Get.context!)
                    .backgroundgrey900)),

        Container(
          padding: const EdgeInsets.all(Dimens.padding_8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimens.padding_8),
            color: Get.theme
                .getCustomColor(Get.context!)
                .secondary1100!,
          ),
          child: SvgPicture.asset(
            'assets/images/ic_arrow_forward.svg',
          ),
        )
      ],
    );
  }

  Map<String, Color> getColor(RegularisationStatus status) {
    switch (status) {
      case RegularisationStatus.pending:
        return {
          Constants.bgColor:
          Get.theme
              .getCustomColor(Get.context!)
              .sourceWarning200!,
          Constants.statusColor:
          Get.theme
              .getCustomColor(Get.context!)
              .warning250!
        };
      case RegularisationStatus.approved:
        return {
          Constants.bgColor: Get.theme
              .getCustomColor(Get.context!)
              .success100!,
          Constants.statusColor:
          Get.theme
              .getCustomColor(Get.context!)
              .success400!
        };
      case RegularisationStatus.rejected:
        return {
          Constants.bgColor: Get.theme
              .getCustomColor(Get.context!)
              .error100!,
          Constants.statusColor: Get.theme.colorScheme.error
        };
      default:
        return {
          Constants.bgColor:
          Get.theme
              .getCustomColor(Get.context!)
              .sourceWarning200!,
          Constants.statusColor: AppColors.warning300
        };
    }
  }
}

