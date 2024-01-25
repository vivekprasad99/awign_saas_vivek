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

class AttendanceVerticalSectionIndicatorWidget extends StatelessWidget {
  final AttendanceDetails attendanceDetails;
  const AttendanceVerticalSectionIndicatorWidget({required this.attendanceDetails, Key? key}) : super(key: key);

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
          sectionWidgets.add(buildAbsentSectionIndicatorWidget(context));
        } else if(attendanceStatusEntity.attendanceStatus == AttendanceStatus.present) {
          sectionWidgets.add(buildPresentSectionIndicatorWidget(context));
        } else if(attendanceStatusEntity.attendanceStatus == AttendanceStatus.leave) {
          sectionWidgets.add(buildLeaveSectionIndicatorWidget(context));
        } else if(attendanceStatusEntity.attendanceStatus == AttendanceStatus.weeklyOff) {
          sectionWidgets.add(buildWeeklyOffSectionIndicatorWidget(context));
        }
        if(sectionWidgets.isNotEmpty && i != attendanceDetails.status!.length - 1) {
          sectionWidgets.add(const SizedBox(height: Dimens.padding_8));
        }
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: sectionWidgets,
      );
    } else {
      List<Widget> sectionWidgets = [];
      if(sectionWidgets.isEmpty) {
        if(attendanceDetails.attendanceStatus == AttendanceStatus.absent) {
          sectionWidgets.add(buildAbsentSectionIndicatorWidget(context));
        } else if(attendanceDetails.attendanceStatus == AttendanceStatus.present) {
          sectionWidgets.add(buildPresentSectionIndicatorWidget(context));
        } else if(attendanceDetails.attendanceStatus == AttendanceStatus.leave) {
          sectionWidgets.add(buildLeaveSectionIndicatorWidget(context));
        } else if(attendanceDetails.attendanceStatus == AttendanceStatus.weeklyOff) {
          sectionWidgets.add(buildWeeklyOffSectionIndicatorWidget(context));
        }
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: sectionWidgets,
      );
    }
  }

  Widget buildAbsentSectionIndicatorWidget(BuildContext context) {
    return Expanded(child: VDivider(dividerThickness: Dimens.dividerHeight_4,
        dividerColor: Get.theme.colorScheme.error));
  }

  Widget buildPresentSectionIndicatorWidget(BuildContext context) {
    return Expanded(child: VDivider(dividerThickness: Dimens.dividerHeight_4,
        dividerColor: Theme.of(context).getCustomColor(context).success300));
  }

  Widget buildLeaveSectionIndicatorWidget(BuildContext context) {
    return Expanded(child: VDivider(dividerThickness: Dimens.dividerHeight_4,
        dividerColor: Theme.of(context).getCustomColor(context).link400));
  }

  Widget buildWeeklyOffSectionIndicatorWidget(BuildContext context) {
    return Expanded(child: VDivider(dividerThickness: Dimens.dividerHeight_4,
        dividerColor: Theme.of(context).getCustomColor(context).secondary1200));
  }
}
