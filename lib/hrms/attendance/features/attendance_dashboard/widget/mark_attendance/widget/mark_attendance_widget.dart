import 'dart:async';

import 'package:awign_saas/core/location/location_helper.dart';
import 'package:awign_saas/core/router/router.dart';
import 'package:awign_saas/core/widget/theme/theme_manager.dart';
import 'package:awign_saas/hrms/attendance/data/model/today_attendance_status.dart';
import 'package:awign_saas/hrms/attendance/features/selfie_camera/data/model/selfie_camera_widget_argument.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../../../core/data/model/ui_state.dart';
import '../../../../../../../core/utils/app_log.dart';
import '../../../../../../../core/utils/date_time_helper/date_time_helper.dart';
import '../../../../../../../core/utils/helper.dart';
import '../../../../../../../core/widget/buttons/punch_in_out_button.dart';
import '../../../../../../../core/widget/dialog/location_service_enable_alert_dialog/location_service_enable_alert_dialog.dart';
import '../../../../../../attendance/data/model/punch_request.dart';
import '../../../../../../attendance/features/attendance_dashboard/widget/bottom_sheet/attendance_success_bottom_sheet.dart';
import '../cubit/mark_attendance_cubit.dart';
import '../cubit/mark_attendance_state.dart';

class MarkAttendanceWidget extends StatelessWidget {
  const MarkAttendanceWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext _context) {
    _context.read<MarkAttendanceCubit>().getAttendanceStatus(null);
    return buildWidgetForMobile(_context);
  }

  Widget buildWidgetForMobile(BuildContext _context) {
    return BlocConsumer<MarkAttendanceCubit, MarkAttendanceState>(
      listenWhen: (previous, current) {
        return previous.uiState != current.uiState;
      },
      listener: (context, state) {
        if (state.uiState?.event == Event.updated) {
          showAttendanceSuccessBottomSheet(Get.context!);
        }
        if (state.uiState?.event == Event.locationSetting) {
          showLocationServiceEnableAlertDialogWithOnTap(context, () async {
            await Geolocator.openLocationSettings();
          });
        }
        if (state.uiState?.failedWithoutAlertMessage.isNotEmpty ?? false) {
          Helper.showErrorToast(state.uiState!.failedWithoutAlertMessage);
        }
      },
      buildWhen: (context, state) {
        return state.uiState?.event == Event.reloadWidget;
      },
      builder: (context, state) {
        return buildPunchInPunchOutContainer(_context);
      },
    );
  }

  Widget buildPunchInPunchOutContainer(BuildContext _context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(
          Dimens.padding_16, Dimens.padding_16, Dimens.padding_16, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimens.radius_8),
        gradient: LinearGradient(
          begin: const Alignment(0, -1),
          end: const Alignment(0, 1.66),
          colors: <Color>[
            Theme.of(_context).extension<CustomColors>()!.sourceSecondary1300!,
            Theme.of(_context)
                .extension<CustomColors>()!
                .sourceSecondary1default!
          ],
          stops: const <double>[0, 1],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(Dimens.padding_16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: Dimens.padding_8),
            Text(
              'time_to_mark_your_attendance'.tr,
              style: Get.textTheme.titleMedium
                  ?.copyWith(color: Get.theme.colorScheme.onSecondary),
            ),
            const SizedBox(height: Dimens.padding_36),
            buildPunchInOutTimeWidgets(),
            const SizedBox(height: Dimens.padding_12),
            buildPunchInOutButton(_context),
          ],
        ),
      ),
    );
  }

  Widget buildPunchInOutTimeWidgets() {
    return BlocBuilder<MarkAttendanceCubit, MarkAttendanceState>(
      buildWhen: (preState, curState) {
        return (preState.lastPunchInTime != curState.lastPunchInTime || preState.lastPunchOutTime != curState.lastPunchOutTime
        || preState.duration != curState.duration);
      },
      builder: (context, state) {
        String punchInTime = '--:--';
        if(state.lastPunchInTime != null) {
          String strTime = DateTimeHelper.getFormattedDateTime(inputDateTime: DateFormat(DateTimeHelper.timeFormatHMS).parse(state.lastPunchInTime!), DateTimeHelper.timeFormatHMA);
          punchInTime = strTime;
        }
        String punchOutTime = '--:--';
        if(state.lastPunchOutTime != null) {
          String strTime = DateTimeHelper.getFormattedDateTime(inputDateTime: DateFormat(DateTimeHelper.timeFormatHMS).parse(state.lastPunchOutTime!), DateTimeHelper.timeFormatHMA);
          punchOutTime = strTime;
        }
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            buildPunchTimeWidgets(punchInTime, 'punch_in_time'.tr),
            buildDurationWidget(state.duration),
            buildPunchTimeWidgets(punchOutTime, 'punch_out_time'.tr),
          ],
        );
      },
    );
  }

  Widget buildPunchTimeWidgets(String value, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: Get.textTheme.titleMedium
              ?.copyWith(color: Get.theme.colorScheme.onSecondary),
        ),
        Text(
          label,
          style: Get.textTheme.bodySmall
              ?.copyWith(color: Get.theme.colorScheme.onSecondary),
        ),
      ],
    );
  }

  Widget buildDurationWidget(Duration? duration) {
    if(duration != null) {
      var (String hour, String minute, _) = DateTimeHelper.convertSecondsToHMS(duration.inSeconds);
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '${hour}h:${minute}m',
            style: Get.textTheme.titleMedium
                ?.copyWith(fontSize: Dimens.font_22, color: Get.theme.colorScheme.onSecondary),
          ),
          Text(
            'total_duration'.tr,
            style: Get.textTheme.bodySmall
                ?.copyWith(color: Get.theme.colorScheme.onSecondary),
          ),
        ],
      );
    } else {
      return const SizedBox();
    }
  }

  Widget buildPunchInOutButton(BuildContext _context) {
    return BlocBuilder<MarkAttendanceCubit, MarkAttendanceState>(
      buildWhen: (previousState, state) {
        return (previousState.buttonState != state.buttonState || previousState.punchType != state.punchType);
      },
      builder: (context, state) {
        String text = '';
        if (state.punchType == PunchType.punchIn) {
          text = 'punch_in'.tr;
        } else if (state.punchType == PunchType.punchOut) {
          text = 'punch_out'.tr;
        } else if (state.punchType == PunchType.disabled) {
          text = 'disabled'.tr;
        }
        if(state.punchType == PunchType.punchIn || state.punchType == PunchType.punchOut) {
          return PunchInOutButton(
            text: text,
            svgIcon: 'assets/images/ic_arrow_right_blue.svg',
            buttonState: state.buttonState,
            onPressed: () {
              if(state.punchType != PunchType.disabled) {
                Helper.showConfirmAlertDialog(context, message: 'you_want_to_mark_attendance'.tr, isYesPrimaryButton: true, onYesTap: () {
                  _getLocationAndDoPunchInPunchOut(_context, state);
                });
              }
            },
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  _getLocationAndDoPunchInPunchOut(BuildContext _context, MarkAttendanceState state) async {
    try {
      if(state.attendanceType != null) {
        switch(state.attendanceType!) {
          case AttendanceType.normal:
            _context.read<MarkAttendanceCubit>().doPunchInPunchOut();
            break;
          case AttendanceType.selfieAndGeo:
            bool? doRefresh = await MRouter.pushNamed(MRouter.selfieCameraWidget, arguments: SelfieCameraWidgetArgument(state.punchType,
                state.attendanceType!, state.workLocation));
            if(doRefresh ?? false) {
              _context.read<MarkAttendanceCubit>().getAttendanceStatus(null);
            }
            break;
          case AttendanceType.geo:
            _context.read<MarkAttendanceCubit>().doPunchInPunchOut();
            break;
          case AttendanceType.selfie:
            bool? doRefresh = await MRouter.pushNamed(MRouter.selfieCameraWidget, arguments: SelfieCameraWidgetArgument(state.punchType,
                state.attendanceType!, state.workLocation));
            if(doRefresh ?? false) {
              _context.read<MarkAttendanceCubit>().getAttendanceStatus(null);
            }
            break;
        }
      }
    } catch (e, stacktrace) {
      Helper.showErrorToast(e.toString());
      AppLog.e('_getLocationAndDoPunchInPunchOut : ${e.toString()} \n${stacktrace.toString()}');
    }
  }
}
