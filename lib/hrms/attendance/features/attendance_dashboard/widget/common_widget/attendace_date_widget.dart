import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../core/utils/date_time_helper/date_time_helper.dart';
import '../../../../../../core/widget/theme/theme_manager.dart';
import '../../../../data/model/attendance_response.dart';

class AttendanceDateWidget extends StatelessWidget {
  final AttendanceDetails attendanceDetails;
  const AttendanceDateWidget({required this.attendanceDetails, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String strDate = '';
    if(attendanceDetails.date != null) {
      strDate = DateTimeHelper.getFormattedDateTime(DateTimeHelper.dateFormatD,
          inputDateTime: DateTime.parse(attendanceDetails.date!));
    }
    String strMonth = '';
    if(attendanceDetails.date != null) {
      strMonth = DateTimeHelper.getFormattedDateTime(DateTimeHelper.dateFormatMMM,
          inputDateTime: DateTime.parse(attendanceDetails.date!));
    }
    String strDay = '';
    if(attendanceDetails.date != null) {
      strDay = DateTimeHelper.getFormattedDateTime(DateTimeHelper.dateFormatE,
          inputDateTime: DateTime.parse(attendanceDetails.date!));
    }
    return SizedBox(
      width: 50,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: Dimens.padding_8),
          Text(strDate, style: Get.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700)),
          Text('$strMonth,', style: Get.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500)),
          Text(strDay, style: Get.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
