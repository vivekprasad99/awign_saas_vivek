import 'package:awign_saas/core/extension/common_extension.dart';
import 'package:awign_saas/core/widget/divider/v_divider.dart';
import 'package:awign_saas/core/widget/theme/theme_manager.dart';
import 'package:awign_saas/hrms/attendance/data/model/attendance_response.dart';
import 'package:awign_saas/hrms/attendance/data/model/billing_cycle.dart';
import 'package:awign_saas/hrms/attendance/features/attendance_dashboard/widget/tile/attendance_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../../core/utils/date_time_helper/date_time_helper.dart';
import '../../../../../../core/widget/buttons/custom_text_button.dart';
import '../common_widget/attendace_date_widget.dart';
import '../common_widget/attendance_vertical_section_indicator_widget.dart';

class WeeklyOffTile extends StatelessWidget {
  final AttendanceDetails attendanceDetails;
  const WeeklyOffTile({required this.attendanceDetails, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          AttendanceVerticalSectionIndicatorWidget(attendanceDetails: attendanceDetails),
          const SizedBox(width: Dimens.padding_12),
          AttendanceDateWidget(attendanceDetails: attendanceDetails),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimens.radius_8),
                border: Border.all(
                  width: Dimens.border_1,
                  color: Get.theme.getCustomColor(context).secondary1200!,
                  style: BorderStyle.solid,
                ),
                color: Get.theme.colorScheme.background,
              ),
              padding: const EdgeInsets.fromLTRB(Dimens.padding_12,
                  Dimens.padding_12, Dimens.padding_12, Dimens.padding_12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('weekly_off'.tr, style: Get.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600, color: Get.theme.getCustomColor(context).secondary1300)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
