
import 'package:awign_saas/core/widget/buttons/raised_rect_button.dart';
import 'package:awign_saas/core/widget/theme/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../core/router/router.dart';
import '../../../../../../core/widget/theme/dimens.dart';

void openDeleteDialog(BuildContext context,Function() onYesTap)
{
  showDialog(
      context: context,
      builder: (_) => Container(height: double.infinity,child:  DeleteDialog(onYesTap),)
  );
}

class DeleteDialog extends StatelessWidget {
  final Function() onYesTap;
  const DeleteDialog(this.onYesTap,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AlertDialog(
    backgroundColor: Get.theme.colorScheme.onPrimary,
          contentPadding:  const EdgeInsets.fromLTRB(
              Dimens.padding_32, Dimens.padding_24, Dimens.padding_32, Dimens.padding_32),
        title: Text(
          'are_you_sure'.tr,
          textAlign: TextAlign.center,
          style: Get.textTheme.titleLarge?.copyWith(
              color: Get.theme.getCustomColor(Get.context!).backgroundblack,fontWeight:FontWeight.w700
          ),
        ),
          content: Column(
            children: [
              Text(
                'cancel_reimbursement_request'.tr,
                textAlign: TextAlign.center,
                style: Get.textTheme.titleMedium?.copyWith(
                    color: Get.theme.getCustomColor(Get.context!).backgroundgrey900
                ),
              ),
              const SizedBox(height: Dimens.padding_16,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RaisedRectButton(
                    backgroundColor: AppColors.transparent,
                    borderColor: Get.theme.getCustomColor(context).secondary1300!,
                    textColor: Get.theme.getCustomColor(context).secondary1300!,
                    text: 'yes'.tr,
                    fontSize: Dimens.padding_16,
                    onPressed: () {
                      onYesTap();
                    },
                    width: Dimens.margin_120,
                  ),
                  RaisedRectButton(
                    width: Dimens.margin_120,
                    backgroundColor: AppColors.secondary1300,
                    borderColor: Get.theme.getCustomColor(context).secondary1300!,
                    textColor: Get.theme.colorScheme.onPrimary,
                    text: 'no'.tr,
                    fontSize: Dimens.padding_16,
                    onPressed: () {
                      MRouter.pop(null);
                    },
                  ),
                ],
              ),
            ],
          ),

        ),

      ],
    );
  }
}
