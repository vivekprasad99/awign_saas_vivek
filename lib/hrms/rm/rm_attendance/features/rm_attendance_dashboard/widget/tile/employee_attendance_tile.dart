import 'package:awign_saas/core/widget/buttons/my_ink_well.dart';
import 'package:awign_saas/core/widget/theme/color_schemes.g.dart';
import 'package:awign_saas/core/widget/theme/dimens.dart';
import 'package:awign_saas/hrms/attendance/data/model/attendance_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../../../core/utils/date_time_helper/date_time_helper.dart';
import '../../../../data/model/employee_attendance.dart';

class EmployeeAttendanceTile extends StatelessWidget {
  final EmployeeAttendance employeeAttendance;
  final Function(BuildContext, EmployeeAttendance) onEmployeeAttendanceTap;
  const EmployeeAttendanceTile({required this.employeeAttendance, required this.onEmployeeAttendanceTap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyInkWell(
      onTap: () {
        onEmployeeAttendanceTap(context, employeeAttendance);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimens.padding_8),
          color: Get.theme.colorScheme.onPrimary,
          border: Border.all(
            color: AppColors.lightCustomColors.sourceBackgroundgrey400!,
          ),
        ),
        padding: const EdgeInsets.all(Dimens.padding_16),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildAvatar(),
                const SizedBox(width: Dimens.padding_8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildName(context),
                      buildEmployeeID(context),
                    ],
                  ),
                ),
                buildStatus(context),
              ],
            ),
            const SizedBox(height: Dimens.padding_4),
            buildEmployeeAttendanceType(context),
          ],
        ),
      ),
    );
  }

  Widget buildAvatar() {
    return SvgPicture.asset(
      'assets/images/ic_circular_profile_place_holder.svg',
    );
  }

  Widget buildName(BuildContext context) {
    String name = employeeAttendance.employeeName ?? '';
    return Text(name,
        style: Get.textTheme.labelLarge?.copyWith(color: Get.theme.getCustomColor(context).backgroundgrey900, fontWeight: FontWeight.w700));
  }

  Widget buildEmployeeID(BuildContext context) {
    String employeeID = employeeAttendance.employeeId ?? '';
    return Text(employeeID,
        style: Get.textTheme.labelMedium?.copyWith(color: Get.theme.getCustomColor(context).backgroundgrey700, fontWeight: FontWeight.w400));
  }

  Widget buildStatus(BuildContext context) {
    String? text; Color? textColor; Color? bgColor;
    if(employeeAttendance.attendanceDetails?.firstOrNull?.status == AttendanceStatus.absent) {
      text = 'absent'.tr;
      textColor = Get.theme.getCustomColor(context).warning250;
      bgColor = Get.theme.getCustomColor(context).error100;
    } else if(employeeAttendance.attendanceDetails?.firstOrNull?.status == AttendanceStatus.present) {
      text = 'present'.tr;
      textColor = Get.theme.getCustomColor(context).skirretgreen;
      bgColor = Get.theme.getCustomColor(context).success100;
    } else if(employeeAttendance.attendanceDetails?.firstOrNull?.status == AttendanceStatus.leave) {
      text = 'leave'.tr;
      textColor = Get.theme.getCustomColor(context).link400;
      bgColor = Get.theme.getCustomColor(context).link200;
    }
    return Container(
      padding: const EdgeInsets.fromLTRB(Dimens.padding_8, Dimens.padding_4, Dimens.padding_8, Dimens.padding_4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimens.padding_8),
        color: bgColor,
      ),
      child: Text(text ?? '',
          style: Get.textTheme.labelMedium
              ?.copyWith(color: textColor)),
    );
  }

  Widget buildEmployeeAttendanceType(BuildContext context) {
    String? strDate;
    if(employeeAttendance.attendanceDetails?.firstOrNull?.date != null) {
      strDate = DateTimeHelper.getFormattedDateTime(inputDateTime: DateTime.parse(employeeAttendance.attendanceDetails!.first.date!), DateTimeHelper.dateFormatDDMMMYYYY);
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          strDate ?? '',
          style: Get.textTheme.labelMedium?.copyWith(
              color: Get.theme.getCustomColor(context).backgroundgrey900,
              fontWeight: FontWeight.w600),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(Dimens.padding_12, Dimens.padding_8, Dimens.padding_12, Dimens.padding_8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimens.padding_8),
            color: Get.theme.getCustomColor(context).secondary1200!,
          ),
          child: SvgPicture.asset(
            'assets/images/ic_right_arrow_purple.svg',
          ),
        )
      ],
    );
  }
}
