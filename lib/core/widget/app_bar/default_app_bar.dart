import 'dart:io';

import 'package:awign_saas/core/router/router.dart';
import 'package:awign_saas/core/widget/buttons/my_ink_well.dart';
import 'package:awign_saas/core/widget/theme/theme_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class DefaultAppBar extends StatelessWidget {
  final bool isBackIconVisible;
  final String? title;
  final Function? onBackTap;
  final bool? isNavDrawerMenuVisible;
  final Function? onNavDrawerTap;
  final bool? isShowNotification;
  final bool? isShowClearAll;
  final Function? onNotificationTap;
  final Function? onClearAllTap;
  Color? backgroundColor;
  Color? textColor;

  DefaultAppBar(
      {this.isBackIconVisible = false,
      this.title,
      this.onBackTap,
      this.isNavDrawerMenuVisible,
      this.onNavDrawerTap,
      this.isShowNotification,
      this.isShowClearAll,
      this.onNotificationTap,
      this.onClearAllTap,
      this.backgroundColor,
      this.textColor,
      Key? key})
      : super(key: key) {
    backgroundColor ??= AppColors.transparent;
    textColor ??= Theme.of(Get.context!).extension<CustomColors>()!.backgroundblack!;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.only(top: Dimens.padding_16, bottom: Dimens.padding_16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                buildBackIcon(),
                buildNavDrawerMenuVisible(),
                buildTitle(context),
              ],
            ),
            buildNotificationIcon(),
            buildClearAllText(),
          ],
        ),
      ),
    );
  }

  Widget buildBackIcon() {
    if (isBackIconVisible) {
      return Padding(
        padding: const EdgeInsets.only(left: Dimens.padding_16),
        child: MyInkWell(
          onTap: () {
            if (onBackTap != null) {
              onBackTap!();
            } else {
              MRouter.pop(null);
            }
          },
          child: const Icon(Icons.arrow_back_sharp),
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  Widget buildTitle(BuildContext context) {
    if (title != null) {
      return Padding(
        padding: const EdgeInsets.only(left: Dimens.padding_16),
        child: Text(
          title!,
          style: Get.textTheme.titleMedium
              ?.copyWith(fontSize: Dimens.font_18, fontWeight: FontWeight.w600, color: textColor),
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  Widget buildNavDrawerMenuVisible() {
    if (isNavDrawerMenuVisible ?? false) {
      return Padding(
        padding: const EdgeInsets.only(left: Dimens.padding_16),
        child: MyInkWell(
          onTap: () {
            if (onNavDrawerTap != null) {
              onNavDrawerTap!();
            } else {
              // MRouter.pop(null);
            }
          },
          child: SvgPicture.asset(
            'assets/images/ic_nav_drawer.svg',
          ),
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  Widget buildNotificationIcon() {
    if (isShowNotification ?? false) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.padding_16),
        child: MyInkWell(
          onTap: () {
            if (onNotificationTap != null) {
              onNotificationTap!();
            }
          },
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(Dimens.padding_8),
                child: SvgPicture.asset(
                  'assets/images/ic_notification_blue.svg',
                ),
              ),
              buildNotificationBadge(),
            ],
          ),
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  Widget buildNotificationBadge() {
    return Positioned(
      right: 0,
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: Get.theme.colorScheme.error,
          borderRadius: BorderRadius.circular(Dimens.radius_12),
          border: Border.all(
            width: Dimens.border_1,
            color: Get.theme.colorScheme.background,
            style: BorderStyle.solid,
          ),
        ),
        constraints: const BoxConstraints(
          minWidth: Dimens.badgeIconWidth_16,
          minHeight: Dimens.badgeIconWidth_16,
        ),
        child: Text(
          '0',
          style: Get.textTheme.labelSmall?.copyWith(fontSize: Dimens.font_10, color: Get.theme.colorScheme.background),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget buildClearAllText() {
    if (isShowClearAll ?? false) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.padding_16),
        child: MyInkWell(
          onTap: () {
            if (onClearAllTap != null) {
              onClearAllTap!();
            }
          },
          child: Text(
            'clear_all'.tr.toUpperCase(),
            style: Get.textTheme.bodyMedium
                ?.copyWith(fontWeight: FontWeight.w600, color: Get.theme.colorScheme.error),
          ),
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}
