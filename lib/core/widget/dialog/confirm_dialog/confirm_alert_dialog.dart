import 'package:awign_saas/core/router/router.dart';
import 'package:awign_saas/core/widget/buttons/custom_text_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../buttons/raised_rect_button.dart';
import '../../theme/theme_manager.dart';

class ConfirmAlertDialog extends StatelessWidget {
  String? title;
  String? message;
  final Function? onYesTap;
  final Function? onNoTap;
  final bool isYesPrimaryButton;

  ConfirmAlertDialog({this.title, this.message, this.isYesPrimaryButton = false, this.onYesTap, this.onNoTap, super.key}) {
    title ??= 'are_you_sure'.tr;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: Dimens.elevation_8,
      insetAnimationCurve: Curves.easeInOut,
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      insetPadding: const EdgeInsets.all(Dimens.padding_20),
      child: buildDialogContent(context),
    );
  }

  Widget buildDialogContent(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Dimens.padding_16),
      decoration: BoxDecoration(
        color: Get.theme.colorScheme.background,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(Dimens.radius_8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // To make the card compact
        children: <Widget>[
          const SizedBox(height: Dimens.margin_16),
          Text(
            title ?? '',
            textAlign: TextAlign.center,
            style: Get.textTheme.bodyLarge?.copyWith(fontSize: Dimens.font_20, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: Dimens.margin_16),
          Text(
            message ?? '',
            textAlign: TextAlign.center,
            style: Get.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w400),
          ),
          const SizedBox(height: Dimens.margin_16),
          Row(
            children: [
              buildYesButton(context),
              const SizedBox(width: Dimens.margin_16),
              buildNoButton(context),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildYesButton(BuildContext context) {
    return Expanded(
      child: CustomTextButton(
        text: 'yes'.tr,
        backgroundColor: isYesPrimaryButton ? Get.theme.colorScheme.primary : AppColors.transparent,
        borderColor: isYesPrimaryButton ? AppColors.transparent : Get.theme.colorScheme.primary,
        textColor: isYesPrimaryButton ? Get.theme.getCustomColor(context).backgroundwhite : Get.theme.colorScheme.primary,
        onPressed: () {
          MRouter.pop(null);
          if(onYesTap != null) {
            onYesTap!();
          }
        },
      ),
    );
  }

  Widget buildNoButton(BuildContext context) {
    return Expanded(
      child: CustomTextButton(
        text: 'no'.tr,
        backgroundColor: isYesPrimaryButton ? AppColors.transparent : Get.theme.colorScheme.primary,
        borderColor: isYesPrimaryButton ? Get.theme.colorScheme.primary : AppColors.transparent ,
        textColor: isYesPrimaryButton ? Get.theme.colorScheme.primary : Get.theme.getCustomColor(context).backgroundwhite,
        onPressed: () {
          MRouter.pop(null);
          // onYesTap();
        },
      ),
    );
  }
}
