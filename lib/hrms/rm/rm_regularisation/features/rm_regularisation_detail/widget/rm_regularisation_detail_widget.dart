import 'package:awign_saas/core/data/model/ui_state.dart';
import 'package:awign_saas/core/router/router.dart';
import 'package:awign_saas/core/utils/constants.dart';
import 'package:awign_saas/core/utils/date_time_helper/date_time_helper.dart';
import 'package:awign_saas/core/utils/helper.dart';
import 'package:awign_saas/core/widget/app_bar/default_app_bar.dart';
import 'package:awign_saas/core/widget/buttons/raised_rect_button.dart';
import 'package:awign_saas/core/widget/divider/h_divider.dart';
import 'package:awign_saas/core/widget/network_sensitive/internet_sensitive.dart';
import 'package:awign_saas/core/widget/scaffold/app_scaffold.dart';
import 'package:awign_saas/core/widget/theme/color_schemes.g.dart';
import 'package:awign_saas/hrms/regularisation/data/model/regularisation_status_response.dart';
import 'package:awign_saas/hrms/rm/rm_regularisation/data/model/regularize_search_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../../core/widget/dialog/rm_regularise_approved_dialog/widget/rm_regularise_approved_dialog.dart';
import '../../../../../../core/widget/theme/dimens.dart';
import '../cubit/rm_regilarisation_detail_cubit.dart';
import '../cubit/rm_regilarisation_detail_state.dart';
import 'package:awign_saas/core/extension/string_extension.dart';

class RmRegularisationDetailWidget extends StatelessWidget {
  final Regularization regularization;

  const RmRegularisationDetailWidget(this.regularization, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildWidgetsForMobile();
  }

  Widget buildWidgetsForMobile() {
    return BlocConsumer<RmRegilarisationDetailCubit,
        RmRegilarisationDetailState>(
      listenWhen: (previous, current) {
        return previous.uiState != current.uiState;
      },
      listener: (context, state) {
        if (state.uiState != null &&
            state.uiState!.failedWithoutAlertMessage.isNotEmpty) {
          Helper.showErrorToast(state.uiState!.failedWithoutAlertMessage);
        }
        if (state.uiState?.event == Event.success) {
          MRouter.pop(true);
        }
      },
      builder: (context, state) {
        String punchInTime = '--:--';
        if(regularization.getPunchInTime() != null) {
          String strTime = DateTimeHelper.getFormattedDateTime(inputDateTime: DateFormat(DateTimeHelper.timeFormatHMS).parse(regularization.getPunchInTime()!), DateTimeHelper.timeFormatHMA);
          punchInTime = strTime;
        }
        String punchOutTime = '--:--';
        if(regularization.getPunchOutTime() != null) {
          String strTime = DateTimeHelper.getFormattedDateTime(inputDateTime: DateFormat(DateTimeHelper.timeFormatHMS).parse(regularization.getPunchOutTime()!), DateTimeHelper.timeFormatHMA);
          punchOutTime = strTime;
        }
        return AppScaffold(
          body: SafeArea(
            child: Column(
              children: [
                DefaultAppBar(
                  isBackIconVisible: true,
                  title: 'regularisation_details'.tr,
                ),
                Expanded(
                    child: InternetSensitive(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: Dimens.padding_16,
                          right: Dimens.padding_16,
                          top: Dimens.padding_16,
                          bottom: Dimens.padding_16),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimens.radius_8),
                            border: Border.all(
                              width: Dimens.border_1,
                              color: Get.theme
                                  .getCustomColor(Get.context!)
                                  .warning250!,
                              style: BorderStyle.solid,
                            ),
                          color: Get.theme.colorScheme.background,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildStatusWidget(
                                context, regularization.status),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: Dimens.padding_16),
                              child: buildManagerRegularizationType(),
                            ),
                            const SizedBox(height: Dimens.padding_16),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: Dimens.padding_16),
                              child: buildDetailWidget(
                                  'regularise_date'.tr,
                                  regularization.date?.getDateWithMonthName() ??
                                      ""),
                            ),
                            const SizedBox(height: Dimens.padding_16),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: Dimens.padding_16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  HDivider(
                                      dividerColor: Get.theme
                                          .getCustomColor(Get.context!)
                                          .backgroundgrey400),
                                  const SizedBox(height: Dimens.padding_16),
                                  Row(
                                    children: [
                                       Expanded(
                                         child: buildDetailWidget(
                                            'punch_in'.tr,
                                                punchInTime),
                                       ),
                                      Expanded(
                                        child: buildDetailWidget(
                                            'punch_out'.tr,
                                            punchOutTime),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: Dimens.padding_16),
                                  HDivider(
                                      dividerColor: Get.theme
                                          .getCustomColor(Get.context!)
                                          .backgroundgrey400),
                                ],
                              ),
                            ),
                            const SizedBox(height: Dimens.padding_16),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: Dimens.padding_16),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: buildDetailWidget(
                                            'shift'.tr,"${regularization.shiftName}"),
                                      ),
                                      Expanded(
                                        child: buildDetailWidget(
                                            'reporting_manager'.tr, "${regularization.approval?.managerName}"),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: Dimens.padding_16),
                                  HDivider(
                                      dividerColor: Get.theme
                                          .getCustomColor(Get.context!)
                                          .backgroundgrey400),
                                ],
                              ),
                            ),
                            const SizedBox(height: Dimens.padding_16),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: Dimens.padding_16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'reason'.tr,
                                              style: Get.textTheme.titleSmall
                                                  ?.copyWith(
                                                      color: Get.theme
                                                          .getCustomColor(
                                                              Get.context!)
                                                          .backgroundgrey700),
                                            ),
                                            Text(
                                              regularization.reasonComment ?? "",
                                              style: Get.textTheme.titleSmall
                                                  ?.copyWith(
                                                  color: Get.theme.getCustomColor(Get.context!).backgroundgrey900),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: Dimens.padding_16),
                          ],
                        ),
                      ),
                    ),
                  ),
                )),
                Visibility(
                  visible: regularization.status == RegularisationStatus.pending,
                  child: buildApproveAndRejectWidget(context, regularization),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildStatusWidget(BuildContext context, RegularisationStatus? status) {
    return Container(
      padding: const EdgeInsets.only(
          left: Dimens.padding_16,
          right: Dimens.padding_16,
          top: Dimens.padding_16,
          bottom: Dimens.padding_16),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(Dimens.radius_8),
            topLeft: Radius.circular(Dimens.radius_8)),
        color: getColor(status)[Constants.bgColor],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            getColor(status)['img_url'],
          ),
          const SizedBox(width: Dimens.padding_16),
          Text('approval_pending'.tr,
              style: Get.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Get.theme.colorScheme.onPrimary)),
        ],
      ),
    );
  }

  Widget buildManagerRegularizationType() {
    return Padding(
      padding: const EdgeInsets.only(top: Dimens.margin_16),
      child: Row(
        children: [
          ClipOval(
            child: Image.network(
              "https://urmstonpartnership.org.uk/wp-content/uploads/2019/01/dummy-profile-image.png",
              width: Dimens.iconSize_56,
              height: Dimens.iconSize_56,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: Dimens.margin_12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${regularization.employeeName}",
                    style: Get.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: Get.theme
                            .getCustomColor(Get.context!)
                            .backgroundgrey900)),
                Text("${regularization.employeeId}",
                    style: Get.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: Get.theme
                            .getCustomColor(Get.context!)
                            .backgroundgrey700)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDetailWidget(String name, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: Get.textTheme.titleSmall?.copyWith(
              color: Get.theme.getCustomColor(Get.context!).backgroundgrey700),
        ),
        Text(
          value,
          style: Get.textTheme.titleSmall?.copyWith(
              color: Get.theme.getCustomColor(Get.context!).backgroundgrey900),
        ),
      ],
    );
  }

  Widget buildApproveAndRejectWidget(
      BuildContext context, Regularization? regularization) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(Dimens.padding_16, Dimens.padding_24,
          Dimens.padding_16, Dimens.padding_16),
      child: Row(
        children: [
          Expanded(
            child: RaisedRectButton(
              width: Dimens.margin_120,
              backgroundColor: AppColors.secondary1300,
              borderColor: Get.theme.getCustomColor(context).secondary1300!,
              textColor: Get.theme.colorScheme.onPrimary,
              text: 'approve'.tr,
              fontSize: Dimens.padding_16,
              onPressed: () {
                showRMRegulariseApprovedDialog(context, regularization, true);
              },
            ),
          ),
          const SizedBox(
            width: Dimens.margin_16,
          ),
          Expanded(
            child: RaisedRectButton(
              backgroundColor: AppColors.transparent,
              borderColor: Get.theme.getCustomColor(context).secondary1300!,
              textColor: Get.theme.getCustomColor(context).secondary1300!,
              text: 'reject'.tr,
              fontSize: Dimens.padding_16,
              onPressed: () {
                showRMRegulariseApprovedDialog(context, regularization, false);
              },
            ),
          ),
        ],
      ),
    );
  }

  Map<String, dynamic> getColor(RegularisationStatus? status) {
    switch (status) {
      case RegularisationStatus.pending:
        return {
          Constants.bgColor:
              Get.theme.getCustomColor(Get.context!).sourceWarning250!,
          'img_url': 'assets/images/ic_pending.png',
          'status': 'pending',
        };
      case RegularisationStatus.approved:
        return {
          Constants.bgColor: Get.theme.getCustomColor(Get.context!).success300!,
          'img_url': 'assets/images/ic_approved.png',
          'status': 'Successfully',
        };
      case RegularisationStatus.rejected:
        return {
          Constants.bgColor: Get.theme.colorScheme.error,
          'img_url': 'assets/images/ic_rejected.png',
          'status': 'Rejected',
        };
      default:
        return {
          Constants.bgColor:
              Get.theme.getCustomColor(Get.context!).sourceWarning250!,
          'img_url': 'assets/images/ic_pending.png',
          'status': 'pending',
        };
    }
  }
}
