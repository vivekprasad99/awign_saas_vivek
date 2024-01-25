import 'package:awign_saas/core/utils/constants.dart';
import 'package:awign_saas/core/widget/theme/color_schemes.g.dart';
import 'package:awign_saas/core/widget/theme/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:awign_saas/core/extension/string_extension.dart';

import '../../../../data/model/rm_reimbursement_search_response.dart';

class RmReimbursementTile extends StatelessWidget {
  final Reimbursements reimbursement;
  final int index;

  const RmReimbursementTile(
      {Key? key,
      required this.reimbursement,
      required this.index})
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
          buildManagerReimbursementType(),
          const SizedBox(height: Dimens.padding_16),
          buildReimbursementReason(),
        ],
      ),
    );
  }

  Widget buildManagerReimbursementType() {
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
              Text(reimbursement.userName ?? "",
                  overflow: TextOverflow.ellipsis,
                  style: Get.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: Get.theme
                          .getCustomColor(Get.context!)
                          .backgroundgrey900)),
              Text(reimbursement.employeeId ?? "",
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
      children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text:  TextSpan(
                    text: 'claim_no'.tr,
                    style:  TextStyle(
                        color: Get.theme.getCustomColor(Get.context!).sourceBackgroundgrey900),
                    children: <TextSpan>[
                      TextSpan(text: reimbursement.invoiceNumber!,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                      )
                    ]
                ),
              ),
              const SizedBox(height: Dimens.margin_4),
              RichText(
                text:  TextSpan(
                    text: 'claim'.tr,
                    style:  TextStyle(
                        color: Get.theme.getCustomColor(Get.context!).sourceBackgroundgrey900),
                    children: <TextSpan>[
                      TextSpan(text: ' ₹ ${reimbursement.amount!}',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      )
                    ]
                ),
              ),
            ],
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
