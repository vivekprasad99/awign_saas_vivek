import 'package:awign_saas/core/widget/buttons/my_ink_well.dart';
import 'package:awign_saas/core/widget/divider/h_divider.dart';
import 'package:awign_saas/core/widget/theme/theme_manager.dart';
import 'package:awign_saas/hrms/rm/rm_attendance/data/model/employee_attendance.dart';
import 'package:awign_saas/hrms/rm/rm_attendance/features/rm_attendance_detail/cubit/rm_attendance_details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../../core/data/model/ui_state.dart';
import '../../../../../../core/router/router.dart';
import '../../../../../../core/utils/date_time_helper/date_time_helper.dart';
import '../../../../../../core/utils/helper.dart';
import '../../../../../../core/widget/app_bar/default_app_bar.dart';
import '../../../../../../core/widget/common/form_label_widget.dart';
import '../../../../../../core/widget/dialog/loading/app_circular_progress_indicator.dart';
import '../../../../../../core/widget/network_sensitive/internet_sensitive.dart';
import '../../../../../../core/widget/scaffold/app_scaffold.dart';
import '../../../../../attendance/data/model/attendance_response.dart';
import '../../../../../attendance/data/model/punch_request.dart';
import '../cubit/rm_attendance_details_state.dart';
import 'location_preview_dialog.dart';
import 'selfie_preivew_dialog.dart';

class RMAttendanceDetailWidget extends StatelessWidget {
  final EmployeeAttendance employeeAttendance;
  const RMAttendanceDetailWidget(this.employeeAttendance, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<RMAttendanceDetailsCubit>().updateEmployeeAttendance(employeeAttendance);
    return buildWidgetsForMobile();
  }

  Widget buildWidgetsForMobile() {
    return AppScaffold(
      body: SafeArea(
        child: Column(
          children: [
            DefaultAppBar(
              isBackIconVisible: true,
              title: 'attendance_details'.tr,
            ),
            Expanded(
              child: InternetSensitive(
                child: BlocConsumer<RMAttendanceDetailsCubit, RMAttendanceDetailsState>(
                  listenWhen: (previous, current) {
                    return previous.uiState != current.uiState;
                  },
                  listener: (context, state) {
                    if(state.uiState != null && state.uiState!.failedWithoutAlertMessage.isNotEmpty) {
                      Helper.showErrorToast(state.uiState!.failedWithoutAlertMessage);
                    }
                    if(state.uiState?.event == Event.success) {
                      Helper.showSuccessAlertDialogWithOnTap(context, 'Attendance_cancelled_successfully'.tr, () {
                        MRouter.pop(true);
                      });
                    }
                  },
                  buildWhen: (context, state) {
                    return state.uiState?.event == Event.reloadWidget;
                  },
                  builder: (context, state) {
                    if (state.uiState?.isOnScreenLoading ?? false) {
                      return const AppCircularProgressIndicator();
                    } else {
                      return buildBody(context, state);
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBody(BuildContext context, RMAttendanceDetailsState state) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: Dimens.padding_16, vertical: Dimens.padding_16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildAttendanceDetailsContainer(context, state),
          ],
        ),
      ),
    );
  }

  Widget buildAttendanceDetailsContainer(BuildContext context, RMAttendanceDetailsState state) {
    String? text; Color? bgColor;
    if(employeeAttendance.attendanceDetails?.firstOrNull?.status == AttendanceStatus.absent) {
      text = 'absent'.tr;
      bgColor = Get.theme.colorScheme.error;
    } else if(employeeAttendance.attendanceDetails?.firstOrNull?.status == AttendanceStatus.present) {
      text = 'present'.tr;
      bgColor = Get.theme.getCustomColor(context).success100;
    } else if(employeeAttendance.attendanceDetails?.firstOrNull?.status == AttendanceStatus.leave) {
      text = 'leave'.tr;
      bgColor = Get.theme.getCustomColor(context).link200;
    }
    String strFormattedDate = '';
    String? strDate = employeeAttendance.attendanceDetails?.firstOrNull?.date;
    if(strDate != null) {
      strFormattedDate = DateTimeHelper.getFormattedDateTime(inputDateTime: DateTime.parse(strDate!), DateTimeHelper.dateFormatDDMMMYYYY);
    }
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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimens.radius_8),
        border: Border.all(
          width: Dimens.border_1,
          color: bgColor!,
          style: BorderStyle.solid,
        ),
        color: Get.theme.colorScheme.background,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildAttendanceDetailsHeaderWidget(context, text, bgColor),
          Padding(
            padding: const EdgeInsets.fromLTRB(Dimens.padding_16, Dimens.padding_24, Dimens.padding_16, 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildAvatar(),
                const SizedBox(width: Dimens.padding_8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildName(context),
                    buildEmployeeID(context),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(Dimens.padding_16, Dimens.padding_24, Dimens.padding_16, Dimens.padding_24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FormLabelWidget(labelText: 'date'.tr, textColor: Theme.of(context).getCustomColor(context).backgroundgrey700),
                          const SizedBox(height: Dimens.padding_4),
                          buildAnswerValueWidget(context, strFormattedDate),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FormLabelWidget(labelText: 'status'.tr, textColor: Theme.of(context).getCustomColor(context).backgroundgrey700),
                          const SizedBox(height: Dimens.padding_4),
                          buildAnswerValueWidget(context, text ?? ''),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: Dimens.padding_12),
                HDivider(dividerColor: Get.theme.getCustomColor(context).backgroundgrey400, verticalPadding: Dimens.padding_8),
                const SizedBox(height: Dimens.padding_12),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FormLabelWidget(labelText: 'punch_in_time'.tr, textColor: Theme.of(context).getCustomColor(context).backgroundgrey700),
                          const SizedBox(height: Dimens.padding_4),
                          buildAnswerValueWidget(context, punchInTime),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FormLabelWidget(labelText: 'punch_out_time'.tr, textColor: Theme.of(context).getCustomColor(context).backgroundgrey700),
                          const SizedBox(height: Dimens.padding_4),
                          buildAnswerValueWidget(context, punchOutTime),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: Dimens.padding_12),
                HDivider(dividerColor: Get.theme.getCustomColor(context).backgroundgrey400, verticalPadding: Dimens.padding_8),
                const SizedBox(height: Dimens.padding_12),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FormLabelWidget(labelText: 'shift'.tr, textColor: Theme.of(context).getCustomColor(context).backgroundgrey700),
                          const SizedBox(height: Dimens.padding_4),
                          buildAnswerValueWidget(context, ''),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FormLabelWidget(labelText: 'reporting_manager'.tr, textColor: Theme.of(context).getCustomColor(context).backgroundgrey700),
                          const SizedBox(height: Dimens.padding_4),
                          buildAnswerValueWidget(context, employeeAttendance.managersName ?? ''),
                        ],
                      ),
                    ),
                  ],
                ),
                buildSelfieAndLocationPreviewWidgets(context, state),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildAttendanceDetailsHeaderWidget(BuildContext context, String? text, Color? bgColor) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(Dimens.radius_8),
              topRight: Radius.circular(Dimens.radius_8)),
          color: bgColor),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(Dimens.padding_20, Dimens.padding_16,
            Dimens.padding_20, Dimens.padding_16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text ?? '',
              style: Get.textTheme.titleMedium?.copyWith(
                  color: Get.theme.colorScheme.background,
                  fontWeight: FontWeight.w700),
            ),
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

  Widget buildAnswerValueWidget(BuildContext context, String answerValue) {
    return Text(answerValue, style: Get.textTheme.bodyMedium?.copyWith(
        color: Theme.of(context)
            .extension<CustomColors>()!
            .backgroundgrey900,
        fontWeight: FontWeight.w600));
  }

  Widget buildPreviewText(BuildContext context, Function onTap) {
    return MyInkWell(
      onTap: onTap,
      child: Text('preview'.tr, style: Get.textTheme.bodyMedium?.copyWith(
          color: Get.theme.colorScheme.primary,
          fontWeight: FontWeight.w600)),
    );
  }

  Widget buildSelfieAndLocationPreviewWidgets(BuildContext context, RMAttendanceDetailsState state) {
    bool isShowSelfiePreview = false;
    String? selfieURL = state.employeeAttendance?.attendanceDetails?.firstOrNull?.punches?.lastOrNull?.selfieUrl;
    if(selfieURL != null) {
      isShowSelfiePreview = true;
    }
    bool isShowLocationPreview = false;
    Geolocation? geolocation = state.employeeAttendance?.attendanceDetails?.firstOrNull?.punches?.lastOrNull?.geolocation;
    if(geolocation != null) {
      isShowLocationPreview = true;
      context.read<RMAttendanceDetailsCubit>().getAddressFromLatLong(geolocation);
    }
    if(isShowSelfiePreview || isShowLocationPreview) {
      return Column(
        children: [
          const SizedBox(height: Dimens.padding_12),
          HDivider(dividerColor: Get.theme.getCustomColor(context).backgroundgrey400, verticalPadding: Dimens.padding_8),
          const SizedBox(height: Dimens.padding_12),
          Row(
            children: [
              buildSelfiePreviewWidget(context, isShowSelfiePreview),
              buildShowLocationPreview(context, isShowLocationPreview),
            ],
          ),
        ],
      );
    } else {
      return const SizedBox();
    }
  }

  Widget buildSelfiePreviewWidget(BuildContext context, bool isShowSelfiePreview) {
    if(isShowSelfiePreview) {
      return Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FormLabelWidget(labelText: 'selfie'.tr, textColor: Theme.of(context).getCustomColor(context).backgroundgrey700),
            const SizedBox(height: Dimens.padding_4),
            buildPreviewText(context, () {
              showSelfiePreviewDialog(context, employeeAttendance, () {});
            }),
          ],
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  Widget buildShowLocationPreview(
      BuildContext context, bool isShowLocationPreview) {
    if (isShowLocationPreview) {
      return BlocBuilder<RMAttendanceDetailsCubit, RMAttendanceDetailsState>(
        builder: (context, state) {
          if(state.placeMark != null) {
            return Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FormLabelWidget(labelText: 'location'.tr, textColor: Theme.of(context).getCustomColor(context).backgroundgrey700),
                  const SizedBox(height: Dimens.padding_4),
                  buildPreviewText(context, () {
                    showLocationPreviewDialog(context, employeeAttendance, state.placeMark!, () {});
                  }),
                ],
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      );
    } else {
      return const SizedBox();
    }
  }
}