import 'dart:io';

import 'package:awign_saas/core/data/local/database/user_preferences/user_preferences.dart';
import 'package:awign_saas/core/router/router.dart';
import 'package:awign_saas/core/widget/buttons/my_ink_well.dart';
import 'package:awign_saas/core/widget/theme/theme_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../image_loader/network_image_loader.dart';

class TenantAppBar extends StatelessWidget {
  final bool isBackIconVisible;
  final String? title;
  final Function? onBackTap;
  final bool? isTenantLogoVisible;
  final bool? isTenantNameVisible;
  final bool? isShowNotification;
  final Function? onNotificationTap;

  const TenantAppBar(
      {this.isBackIconVisible = false,
        this.title,
        this.onBackTap,
        this.isTenantLogoVisible,
        this.isTenantNameVisible,
        this.isShowNotification,
        this.onNotificationTap,
        Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).extension<CustomColors>()!.secondary1200Container,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: Dimens.padding_16, bottom: Dimens.padding_16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    buildBackIcon(),
                    buildTenantAvatar(),
                    buildTitle(context),
                    buildTenantName(context),
                  ],
                ),
                buildNotificationIcon(),
              ],
            ),
          ),
        ],
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

  Widget buildTenantAvatar() {
    if (isTenantLogoVisible ?? false) {
      String? url = UserPreferences.getInstance().getCurrentUser()?.tenant?.logoUrl;
      if(url != null) {
        return Padding(
          padding: const EdgeInsets.only(left: Dimens.padding_16),
          child: NetworkImageLoader(
            url: url,
            width: Dimens.iconSize_24,
            height: Dimens.iconSize_24,
            filterQuality: FilterQuality.high,
            fit: BoxFit.cover,
          ),
        );
      } else {
        return Padding(
          padding: const EdgeInsets.only(left: Dimens.padding_16),
          child: MyInkWell(
            onTap: () {

            },
            child: SvgPicture.asset(
              'assets/images/ic_circular_profile_place_holder.svg',
              width: Dimens.iconSize_24,
              height: Dimens.iconSize_24,
            ),
          ),
        );
      }
    } else {
      return const SizedBox();
    }
  }

  Widget buildTenantName(BuildContext context) {
    if (isTenantNameVisible ?? false) {
      String? name = UserPreferences.getInstance().getCurrentUser()?.tenant?.name;
      return Padding(
        padding: const EdgeInsets.only(left: Dimens.padding_16),
        child: Text(
          name ?? '',
          style: Get.textTheme.titleMedium
              ?.copyWith(fontSize: Dimens.font_18, color: Theme.of(context).extension<CustomColors>()!.backgroundblack, fontWeight: FontWeight.w600),
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
              ?.copyWith(fontSize: Dimens.font_18, color: Theme.of(context).extension<CustomColors>()!.backgroundblack, fontWeight: FontWeight.w600),
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
}
