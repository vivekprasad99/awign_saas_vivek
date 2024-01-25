import 'package:awign_saas/core/extension/common_extension.dart';
import 'package:awign_saas/core/widget/divider/v_divider.dart';
import 'package:awign_saas/core/widget/theme/theme_manager.dart';
import 'package:awign_saas/hrms/attendance/data/model/attendance_response.dart';
import 'package:awign_saas/hrms/attendance/data/model/billing_cycle.dart';
import 'package:awign_saas/hrms/attendance/features/attendance_dashboard/widget/tile/attendance_tile.dart';
import 'package:awign_saas/hrms/dashboard/data/search_notification_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../../core/utils/date_time_helper/date_time_helper.dart';
import '../../../../../../core/widget/buttons/custom_text_button.dart';
import '../../../../../../core/widget/buttons/my_ink_well.dart';

class NotificationTile extends StatelessWidget {
  final int index;
  final NotificationEntity notificationEntity;
  final Function(BuildContext context, int index, NotificationEntity notificationEntity) onNotificationTapped;
  const NotificationTile({required this.index, required this.notificationEntity, required this.onNotificationTapped, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyInkWell(
      onTap: () {
        onNotificationTapped(context, index, notificationEntity);
      },
      child: Container(
        padding: const EdgeInsets.all(Dimens.padding_16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimens.radius_16),
          border: Border.all(
            width: Dimens.border_1,
            color: Get.theme.getCustomColor(context).backgroundgrey400!,
            style: BorderStyle.solid,
          ),
          color: index.isEven ? Get.theme.colorScheme.background : Get.theme.getCustomColor(context).backgroundgrey200,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildNotificationIcon(context),
            const SizedBox(width: Dimens.padding_16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  buildTitle(),
                  buildMessage(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildNotificationIcon(BuildContext context) {
    return SvgPicture.asset(
      'assets/images/ic_notification_selected.svg',
      color: Get.theme.getCustomColor(context).backgroundgrey700,
      width: Dimens.iconSize_40,
      height: Dimens.iconSize_40,
    );
  }

  Widget buildTitle() {
    return Text(notificationEntity.title ?? '', style: Get.textTheme.titleMedium);
  }

  Widget buildMessage() {
    return Text(notificationEntity.message ?? '', style: Get.textTheme.labelLarge);
  }
}
