import 'package:awign_saas/core/widget/theme/color_schemes.g.dart';
import 'package:awign_saas/core/widget/theme/dimens.dart';
import 'package:awign_saas/hrms/dashboard/data/notification_filter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../core/widget/buttons/my_ink_well.dart';

class NotificationFilterTile extends StatelessWidget {
  final int index;
  final NotificationFilter notificationFilter;
  final Function(BuildContext context, int index, NotificationFilter notificationFilter)
      onNotificationFilterTapped;

  const NotificationFilterTile(
      {Key? key,
      required this.notificationFilter,
      required this.index,
      required this.onNotificationFilterTapped})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyInkWell(
      onTap: () {
        onNotificationFilterTapped(context, index, notificationFilter);
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(
          Dimens.padding_16,
          Dimens.padding_8,
          Dimens.padding_16,
          Dimens.padding_8,
        ),
        margin: const EdgeInsets.symmetric(horizontal: Dimens.padding_4),
        decoration: BoxDecoration(
            color: notificationFilter.isSelected
                ? Get.theme.getCustomColor(context).secondary1300!
                : Get.theme.getCustomColor(context).sourceBackgroundwhite!,
            borderRadius: BorderRadius.circular(Dimens.radius_32),
            border: Border.all(
              color: Get.theme.getCustomColor(context).secondary1300!,
              width: 2,
            )),
        child: Center(
          child: Text(
            notificationFilter.getTitle() ?? "",
            style: Get.context?.textTheme.titleMedium?.copyWith(
                color: notificationFilter.isSelected
                    ? Get.theme.getCustomColor(context).sourceBackgroundwhite!
                    : Get.theme.getCustomColor(context).secondary1300!,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
