import 'package:awign_saas/core/router/router.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../buttons/raised_rect_button.dart';
import '../../theme/theme_manager.dart';

class SuccessAlertDialog extends StatelessWidget {
  final String message;
  final Function() onOKTap;

  const SuccessAlertDialog(this.message, this.onOKTap, {super.key});

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
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(Dimens.radius_8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // To make the card compact
        children: <Widget>[
          Image.asset(
            'assets/images/ic_success_alert.png',
            width: Dimens.iconSize_70,
            height: Dimens.iconSize_70,
          ),
          const SizedBox(height: Dimens.margin_24),
          Text(
            message,
            textAlign: TextAlign.center,
            style: Get.textTheme.bodyLarge?.copyWith(fontSize: Dimens.font_20, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: Dimens.margin_16),
          buildOKButton(context),
        ],
      ),
    );
  }

  Widget buildOKButton(BuildContext context) {
    return SizedBox(
      width: Dimens.btnWidth_90,
      child: RaisedRectButton(
        text: 'okay'.tr.toUpperCase(),
        onPressed: () {
          MRouter.pop(null);
          onOKTap();
        },
      ),
    );
  }
}
