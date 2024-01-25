import 'package:awign_saas/core/extension/common_extension.dart';
import 'package:awign_saas/core/widget/divider/v_divider.dart';
import 'package:awign_saas/core/widget/theme/theme_manager.dart';
import 'package:awign_saas/hrms/attendance/data/model/attendance_response.dart';
import 'package:awign_saas/hrms/attendance/data/model/billing_cycle.dart';
import 'package:awign_saas/hrms/attendance/features/attendance_dashboard/widget/tile/attendance_tile.dart';
import 'package:awign_saas/hrms/leaves/data/model/leave.dart';
import 'package:awign_saas/hrms/regularisation/data/model/regularisation_status_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../../core/utils/date_time_helper/date_time_helper.dart';
import '../../../../../../core/widget/buttons/custom_text_button.dart';
import '../../../../../../core/widget/buttons/my_ink_well.dart';
import '../../../../../../core/widget/divider/h_divider.dart';
import '../common_widget/attendace_date_widget.dart';
import '../common_widget/attendance_section_widget.dart';
import '../common_widget/attendance_vertical_section_indicator_widget.dart';

class AbsentTile extends StatelessWidget {
  final AttendanceDetails attendanceDetails;
  final BillingCycle? currentBillingCycle;
  final Function(BuildContext, AttendanceDetails, AttendanceTileAction, {AttendanceStatusEntity? attendanceStatusEntity}) onAttendanceAction;
  const AbsentTile({required this.attendanceDetails, required this.currentBillingCycle, required this.onAttendanceAction, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? strLeaveOrRegularisationRequested;
    if(attendanceDetails.getRegularization()?.status == RegularisationStatus.pending) {
      strLeaveOrRegularisationRequested = 'regularisation_requested'.tr;
    } else if(attendanceDetails.getLeave()?.status == LeaveStatus.pending) {
      strLeaveOrRegularisationRequested = 'leave_requested'.tr;
    }
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
              child: buildSingleSectionOrMultiSectionWidget(context, strLeaveOrRegularisationRequested),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSingleSectionOrMultiSectionWidget(BuildContext context, String? strLeaveOrRegularisationRequested) {
    if((attendanceDetails.status?.length ?? 0) > 1) {
      return AttendanceSectionWidget(attendanceDetails: attendanceDetails, currentBillingCycle: currentBillingCycle,
          onAttendanceAction: onAttendanceAction);
    } else {
      return buildSingleSectionWidgets(context, strLeaveOrRegularisationRequested);
    }
  }

  Widget buildSingleSectionWidgets(BuildContext context, String? strLeaveOrRegularisationRequested) {
    String punchInTime = '--:--';
    if(attendanceDetails.getPunchInTime() != null) {
      String strTime = DateTimeHelper.getFormattedDateTime(
          inputDateTime: DateFormat(DateTimeHelper.timeFormatHMS).parse(attendanceDetails.getPunchInTime()!),
          DateTimeHelper.timeFormatHMA);
      punchInTime = strTime;
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('absent'.tr, style: Get.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
            Text(punchInTime, style: Get.textTheme.bodySmall),
          ],
        ),
        const Spacer(),
        buildResolveButton(context, strLeaveOrRegularisationRequested),
        buildLeaveOrRegularisationRequestedWidget(context, strLeaveOrRegularisationRequested),
      ],
    );
  }

  Widget buildResolveButton(BuildContext context, String? strLeaveOrRegularisationRequested) {
    bool isShowResolveButton = false;
    String text = 'resolve'.tr;
    if(currentBillingCycle != null && attendanceDetails.date != null && !(strLeaveOrRegularisationRequested != null)) {
      DateTime absentDate = DateTime.parse(attendanceDetails.date!);
      if(currentBillingCycle!.startDate != null && currentBillingCycle!.startDate!.isBefore(absentDate)
          && currentBillingCycle!.endDate != null && currentBillingCycle!.endDate!.isAfter(absentDate)) {
        isShowResolveButton = true;
      } else if((currentBillingCycle!.startDate != null && currentBillingCycle!.startDate!.isAtSameMomentAs(absentDate))
          || (currentBillingCycle!.endDate != null && currentBillingCycle!.endDate!.isAtSameMomentAs(absentDate))) {
        isShowResolveButton = true;
      }
    }
    if(isShowResolveButton) {
      if(attendanceDetails.getRegularization()?.status == RegularisationStatus.rejected
          || attendanceDetails.getLeave()?.status == LeaveStatus.rejected) {
        text = 're_request'.tr;
      }
      return MyInkWell(
        onTap: () {
          onAttendanceAction(context, attendanceDetails, AttendanceTileAction.resolve);
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(text,
                style: Get.textTheme.labelMedium?.copyWith(color: Get.theme
                    .getCustomColor(Get.context!)
                    .secondary1300, fontWeight: FontWeight.w700)),
            const SizedBox(width: Dimens.padding_8,),
            SvgPicture.asset(
              'assets/images/ic_arrow_forward.svg',
            ),
          ],
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  Widget buildLeaveOrRegularisationRequestedWidget(BuildContext context, String? strLeaveOrRegularisationRequested) {
    if(strLeaveOrRegularisationRequested != null) {
      return Text(strLeaveOrRegularisationRequested,
          style: Get.textTheme.labelMedium?.copyWith(color: Get.theme.getCustomColor(context)
              .secondary1200, fontWeight: FontWeight.w700));
    } else {
      return const SizedBox();
    }
  }
}
