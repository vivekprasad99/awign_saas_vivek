import 'package:awign_saas/core/extension/common_extension.dart';
import 'package:awign_saas/core/widget/divider/v_divider.dart';
import 'package:awign_saas/core/widget/theme/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../../core/utils/date_time_helper/date_time_helper.dart';
import '../../../../data/model/attendance_response.dart';
import '../../../../data/model/billing_cycle.dart';
import '../common_widget/attendace_date_widget.dart';
import '../common_widget/attendance_section_widget.dart';
import '../common_widget/attendance_vertical_section_indicator_widget.dart';
import 'attendance_tile.dart';

class PresentTile extends StatelessWidget {
  final AttendanceDetails attendanceDetails;
  final BillingCycle? currentBillingCycle;
  final Function(BuildContext, AttendanceDetails, AttendanceTileAction, {AttendanceStatusEntity? attendanceStatusEntity}) onAttendanceAction;
  const PresentTile({required this.attendanceDetails, required this.currentBillingCycle, required this.onAttendanceAction, Key? key}) : super(key: key);

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
              child: buildSingleSectionOrMultiSectionWidget(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSingleSectionOrMultiSectionWidget(BuildContext context) {
    if((attendanceDetails.status?.length ?? 0) > 1) {
      return AttendanceSectionWidget(attendanceDetails: attendanceDetails, currentBillingCycle: currentBillingCycle,
          onAttendanceAction: onAttendanceAction);
    } else {
      return buildSingleSectionWidgets(context);
    }
  }

  Widget buildSingleSectionWidgets(BuildContext context) {
    String punchInTime = '--:--';
    if(attendanceDetails.getPunchInTime() != null) {
      String strTime = DateTimeHelper.getFormattedDateTime(inputDateTime: DateFormat(DateTimeHelper.timeFormatHMS).parse(attendanceDetails.getPunchInTime()!),
          DateTimeHelper.timeFormatHMA);
      punchInTime = strTime;
    }
    String punchOutTime = '';
    if(attendanceDetails.getPunchOutTime() != null) {
      String strTime = DateTimeHelper.getFormattedDateTime(inputDateTime: DateFormat(DateTimeHelper.timeFormatHMS).parse(attendanceDetails.getPunchOutTime()!),
          DateTimeHelper.timeFormatHMA);
      punchOutTime = ' - $strTime';
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('present'.tr, style: Get.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(punchInTime, style: Get.textTheme.bodySmall),
            Text(punchOutTime, style: Get.textTheme.bodySmall),
          ],
        ),
      ],
    );
  }
}
