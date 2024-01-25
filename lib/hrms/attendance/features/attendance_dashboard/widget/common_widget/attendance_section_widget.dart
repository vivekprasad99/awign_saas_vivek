import 'package:awign_saas/core/extension/common_extension.dart';
import 'package:awign_saas/core/extension/string_extension.dart';
import 'package:awign_saas/core/widget/buttons/my_ink_well.dart';
import 'package:awign_saas/core/widget/divider/v_divider.dart';
import 'package:awign_saas/core/widget/theme/theme_manager.dart';
import 'package:awign_saas/hrms/attendance/data/model/attendance_response.dart';
import 'package:awign_saas/hrms/attendance/data/model/billing_cycle.dart';
import 'package:awign_saas/hrms/attendance/features/attendance_dashboard/widget/tile/attendance_tile.dart';
import 'package:awign_saas/hrms/leaves/data/model/leave.dart';
import 'package:awign_saas/hrms/leaves/data/model/leave_types_response.dart';
import 'package:awign_saas/hrms/regularisation/data/model/regularisation_status_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../../core/utils/date_time_helper/date_time_helper.dart';
import '../../../../../../core/widget/buttons/custom_text_button.dart';
import '../../../../../../core/widget/divider/h_divider.dart';

class AttendanceSectionWidget extends StatelessWidget {
  final AttendanceDetails attendanceDetails;
  final BillingCycle? currentBillingCycle;
  final Function(BuildContext, AttendanceDetails, AttendanceTileAction, {AttendanceStatusEntity? attendanceStatusEntity}) onAttendanceAction;
  const AttendanceSectionWidget({required this.attendanceDetails, required this.currentBillingCycle, required this.onAttendanceAction, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildSectionWidgets(context);
  }

  Widget buildSectionWidgets(BuildContext context) {
    if((attendanceDetails.status?.length ?? 0) > 1) {
      List<Widget> sectionWidgets = [];
      for(int i = 0; i < attendanceDetails.status!.length; i++) {
        AttendanceStatusEntity attendanceStatusEntity = attendanceDetails.status![i];
        if(attendanceStatusEntity.attendanceStatus == AttendanceStatus.absent) {
          sectionWidgets.add(buildAbsentSectionWidget(context, attendanceStatusEntity, ShiftType.getShiftByIndex(attendanceStatusEntity.section)));
        } else if(attendanceStatusEntity.attendanceStatus == AttendanceStatus.present) {
          sectionWidgets.add(buildPresentSectionWidget(context, ShiftType.getShiftByIndex(attendanceStatusEntity.section)));
        } else if(attendanceStatusEntity.attendanceStatus == AttendanceStatus.leave) {
          sectionWidgets.add(buildLeaveSectionWidget(context, ShiftType.getShiftByIndex(attendanceStatusEntity.section)));
        }
        if(sectionWidgets.isNotEmpty && i != attendanceDetails.status!.length - 1) {
          sectionWidgets.add(const SizedBox(width: Dimens.padding_8));
        }
      }
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: sectionWidgets,
      );
    } else {
      return const SizedBox();
    }
  }

  Widget buildAbsentSectionWidget(BuildContext context, AttendanceStatusEntity attendanceStatusEntity, ShiftType? shiftType) {
    String? strLeaveOrRegularisationRequested;
    if(attendanceStatusEntity.regularization?.status == RegularisationStatus.pending) {
      strLeaveOrRegularisationRequested = 'regularisation_requested'.tr;
    } else if(attendanceStatusEntity.leave?.status == LeaveStatus.pending) {
      strLeaveOrRegularisationRequested = 'leave_requested'.tr;
    }
    return Expanded(child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildLeaveOrRegularisationRequestedWidget(context, strLeaveOrRegularisationRequested),
        Text(shiftType?.value.replaceAll('_', ' ').toTitleCase() ?? '', style: Get.textTheme.bodySmall),
        const SizedBox(height: Dimens.padding_4),
        Row(
          children: [
            Text('absent'.tr, style: Get.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w500)),
            const SizedBox(width: Dimens.padding_8),
            buildResolveButton(context, attendanceStatusEntity, strLeaveOrRegularisationRequested),
          ],
        ),
        const SizedBox(height: Dimens.padding_8),
        HDivider(dividerThickness: Dimens.dividerHeight_4,
            dividerColor: Get.theme.colorScheme.error),
      ],
    ));
  }

  Widget buildPresentSectionWidget(BuildContext context, ShiftType? shiftType) {
    return Expanded(child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(shiftType?.value.replaceAll('_', ' ').toTitleCase() ?? '', style: Get.textTheme.bodySmall),
        const SizedBox(height: Dimens.padding_4),
        Text('present'.tr, style: Get.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w500)),
        const SizedBox(height: Dimens.padding_8),
        HDivider(dividerThickness: Dimens.dividerHeight_4,
            dividerColor: Theme.of(context).getCustomColor(context).success300),
      ],
    ));
  }

  Widget buildLeaveSectionWidget(BuildContext context, ShiftType? shiftType) {
    return Expanded(child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(shiftType?.value.replaceAll('_', ' ').toTitleCase() ?? '', style: Get.textTheme.bodySmall),
        const SizedBox(height: Dimens.padding_4),
        Text('leave'.tr, style: Get.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w500)),
        const SizedBox(height: Dimens.padding_8),
        HDivider(dividerThickness: Dimens.dividerHeight_4,
            dividerColor: Theme.of(context).getCustomColor(context).link400),
      ],
    ));
  }

  Widget buildResolveButton(BuildContext context, AttendanceStatusEntity attendanceStatusEntity, String? strLeaveOrRegularisationRequested) {
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
          onAttendanceAction(context, attendanceDetails, AttendanceTileAction.resolve, attendanceStatusEntity: attendanceStatusEntity);
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
      return Padding(
        padding: const EdgeInsets.only(bottom: Dimens.padding_8),
        child: Text(strLeaveOrRegularisationRequested,
            style: Get.textTheme.labelMedium?.copyWith(color: Get.theme.getCustomColor(context)
                .secondary1200, fontWeight: FontWeight.w700)),
      );
    } else {
      return const SizedBox();
    }
  }
}
