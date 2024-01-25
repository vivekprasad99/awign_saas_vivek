import 'package:awign_saas/core/utils/constants.dart';
import 'package:awign_saas/core/widget/theme/color_schemes.g.dart';
import 'package:awign_saas/core/widget/theme/dimens.dart';
import 'package:awign_saas/hrms/reimbursements/data/model/reimbursement_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:awign_saas/core/extension/string_extension.dart';

import '../../../../../../core/widget/common/form_label_widget.dart';

class AllTile extends StatelessWidget {
  final Reimbursement reimbursement;
  final int index;

  const AllTile({Key? key, required this.reimbursement, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimens.padding_8),
        color: Get.theme.colorScheme.onPrimary,
        border: Border.all(
          color: Get.theme.getCustomColor(context).backgroundgrey400!,
        ),
      ),
      padding: const EdgeInsets.all(Dimens.padding_16),
      child: Column(
        children: [
          buildReimbursementType(context),
          const SizedBox(height: Dimens.padding_8),
          buildReimbursementReason(),
        ],
      ),
    );
  }

  Widget buildReimbursementType(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FormLabelWidget(labelText: 'requested_amount'.tr, textColor: Theme.of(context).getCustomColor(context).backgroundgrey700),
            Text("${Constants.rs}${reimbursement.amount}",
                style: Get.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: Get.theme
                        .getCustomColor(Get.context!)
                        .backgroundgrey900)),
            buildApprovedAmountWidget(context),
            const SizedBox(height: Dimens.padding_8),
            Text(reimbursement.createdAt?.getDateWithDDMMMYYYYFormat().reverse('-') ?? '',
                style: Get.textTheme.titleSmall?.copyWith(
                    color: Get.theme
                        .getCustomColor(Get.context!)
                        .backgroundgrey700)),
          ],
        ),
        buildStatus(),
      ],
    );
  }

  Widget buildApprovedAmountWidget(BuildContext context) {
    if(reimbursement.approvedAmount != null) {
      return  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: Dimens.padding_8),
          FormLabelWidget(labelText: 'approved_amount'.tr, textColor: Theme.of(context).getCustomColor(context).backgroundgrey700),
          const SizedBox(height: Dimens.padding_4),
          buildAnswerValueWidget(context, reimbursement.approvedAmount ?? ''),
        ],
      );
    } else {
      return const SizedBox();
    }
  }

  Widget buildAnswerValueWidget(BuildContext context, String answerValue) {
    return Text(answerValue, style: Get.textTheme.bodyMedium?.copyWith(
        color: Theme.of(context)
            .extension<CustomColors>()!
            .backgroundgrey900,
        fontWeight: FontWeight.w600));
  }

  Widget buildStatus() {
    return Container(
      padding: const EdgeInsets.all(Dimens.padding_4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimens.padding_8),
        color: getColor(reimbursement.status!)[Constants.bgColor],
      ),
      child: Text(reimbursement.status?.toCapitalized() ?? "",
          style: Get.textTheme.titleSmall?.copyWith(
              color: getColor(reimbursement.status!)[Constants.statusColor])),
    );
  }

  Widget buildReimbursementReason() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          reimbursement.reimbursementType?.toCapitalized() ?? "",
          style: Get.textTheme.titleSmall?.copyWith(
              color: Get.theme.getCustomColor(Get.context!).backgroundgrey900,
              fontWeight: FontWeight.w700),
        ),
        Container(
          padding: const EdgeInsets.all(Dimens.padding_8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimens.padding_8),
            color: Get.theme.getCustomColor(Get.context!).secondary1100!,
          ),
          child: SvgPicture.asset(
            'assets/images/ic_arrow_forward.svg',
          ),
        )
      ],
    );
  }

  Map<String, Color> getColor(String status) {
    switch (status) {
      case "PENDING":
        return {
          Constants.bgColor:
              Get.theme.getCustomColor(Get.context!).sourceWarning200!,
          Constants.statusColor:
              Get.theme.getCustomColor(Get.context!).warning250!
        };
      case "APPROVED":
        return {
          Constants.bgColor: Get.theme.getCustomColor(Get.context!).success100!,
          Constants.statusColor:
              Get.theme.getCustomColor(Get.context!).success400!
        };
      case "REJECTED":
        return {
          Constants.bgColor: Get.theme.getCustomColor(Get.context!).error100!,
          Constants.statusColor: Get.theme.colorScheme.error
        };
      default:
        return {
          Constants.bgColor:
              Get.theme.getCustomColor(Get.context!).sourceWarning200!,
          Constants.statusColor: AppColors.warning300
        };
    }
  }
}
