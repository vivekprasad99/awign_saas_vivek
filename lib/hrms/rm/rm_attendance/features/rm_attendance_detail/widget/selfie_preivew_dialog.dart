import 'package:awign_saas/core/router/router.dart';
import 'package:awign_saas/core/widget/theme/theme_manager.dart';
import 'package:awign_saas/hrms/rm/rm_attendance/data/model/employee_attendance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../../core/utils/date_time_helper/date_time_helper.dart';
import '../../../../../../core/widget/buttons/my_ink_well.dart';
import '../../../../../../core/widget/image_loader/network_image_loader.dart';

void showSelfiePreviewDialog(
    BuildContext context, EmployeeAttendance employeeAttendance, VoidCallback onTap) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) => SelfiePreviewDialog(employeeAttendance, onTap),
  );
}

class SelfiePreviewDialog extends StatelessWidget {
  final EmployeeAttendance employeeAttendance;
  final Function() onOKTap;

  const SelfiePreviewDialog(this.employeeAttendance, this.onOKTap, {super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: Dimens.elevation_8,
      insetAnimationCurve: Curves.easeInOut,
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      insetPadding: const EdgeInsets.all(Dimens.padding_20),
      child: buildDialogContent(context),
    );
  }

  Widget buildDialogContent(BuildContext context) {
    String name = employeeAttendance.employeeName ?? '';
    String strFormattedDate = '';
    String? strDate = employeeAttendance.attendanceDetails?.firstOrNull?.date;
    if(strDate != null) {
      strFormattedDate = DateTimeHelper.getFormattedDateTime(inputDateTime: DateTime.parse(strDate!), DateTimeHelper.dateFormatDDMMMYYYY);
    }
    String nameAndDate = '$name - $strFormattedDate';
    String punchInTime = '--:--';
    String? strPunchInTime = employeeAttendance.attendanceDetails?.firstOrNull?.getPunchInTime();
    if(strPunchInTime != null) {
      String strTime = DateTimeHelper.getFormattedDateTime(inputDateTime: DateFormat(DateTimeHelper.timeFormatHMS).parse(strPunchInTime),
          DateTimeHelper.timeFormatHMA);
      punchInTime = strTime;
    }
    String punchOutTime = '--:--';
    String? strPunchOutTime = employeeAttendance.attendanceDetails?.firstOrNull?.getPunchOutTime();
    if(strPunchOutTime != null) {
      String strTime = DateTimeHelper.getFormattedDateTime(inputDateTime: DateFormat(DateTimeHelper.timeFormatHMS).parse(strPunchOutTime),
          DateTimeHelper.timeFormatHMA);
      punchOutTime = strTime;
    }
    return Container(
      padding: const EdgeInsets.all(Dimens.padding_16),
      decoration: BoxDecoration(
        color: Get.theme.getCustomColor(context).backgroundwhite,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(Dimens.radius_8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // To make the card compact
        children: <Widget>[
          buildCloseIcon(),
          buildTitle(),
          const SizedBox(height: Dimens.padding_8),
          Text(
            nameAndDate,
            textAlign: TextAlign.center,
            style: Get.textTheme.bodyMedium,
          ),
          const SizedBox(height: Dimens.margin_16),
          buildImageWidget(),
          const SizedBox(height: Dimens.margin_16),
          Text(
            '$punchInTime - $punchOutTime',
            textAlign: TextAlign.center,
            style: Get.textTheme.bodyMedium,
          ),
          const SizedBox(height: Dimens.margin_24),
          Text(
            'Matches with Picture uploaded during onboarding',
            textAlign: TextAlign.center,
            style: Get.textTheme.bodyMedium?.copyWith(color: Get.theme.getCustomColor(context).success300, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget buildCloseIcon() {
    return Align(
      alignment: Alignment.topRight,
      child: MyInkWell(
        onTap: () {
          MRouter.pop(null);
        },
        child: SvgPicture.asset('assets/images/ic_close_dialog.svg'),
      ),
    );
  }

  Widget buildTitle() {
    return Text(
      'selfie'.tr,
      textAlign: TextAlign.center,
      style: Get.textTheme.headlineSmall?.copyWith(fontSize: Dimens.font_20, fontWeight: FontWeight.w700),
    );
  }

  Widget buildImageWidget() {
    String? selfieURL = employeeAttendance.attendanceDetails?.firstOrNull?.punches?.lastOrNull?.selfieUrl;
    return ClipRRect(
      borderRadius: BorderRadius.circular(Dimens.radius_8),
      child: NetworkImageLoader(
        url: selfieURL ?? '',
        width: Dimens.imageWidth_200,
        height: Dimens.imageHeight_200,
        filterQuality: FilterQuality.high,
        fit: BoxFit.cover,
      ),
    );
  }
}
