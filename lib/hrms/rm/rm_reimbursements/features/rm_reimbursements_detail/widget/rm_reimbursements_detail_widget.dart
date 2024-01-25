import 'package:awign_saas/core/data/model/ui_state.dart';
import 'package:awign_saas/core/extension/string_extension.dart';
import 'package:awign_saas/core/router/router.dart';
import 'package:awign_saas/core/utils/constants.dart';
import 'package:awign_saas/core/utils/file_utils.dart';
import 'package:awign_saas/core/utils/helper.dart';
import 'package:awign_saas/core/widget/app_bar/default_app_bar.dart';
import 'package:awign_saas/core/widget/buttons/my_ink_well.dart';
import 'package:awign_saas/core/widget/buttons/raised_rect_button.dart';
import 'package:awign_saas/core/widget/dialog/loading/app_circular_progress_indicator.dart';
import 'package:awign_saas/core/widget/divider/h_divider.dart';
import 'package:awign_saas/core/widget/network_sensitive/internet_sensitive.dart';
import 'package:awign_saas/core/widget/scaffold/app_scaffold.dart';
import 'package:awign_saas/core/widget/theme/theme_manager.dart';
import 'package:awign_saas/hrms/rm/rm_reimbursements/features/rm_reimbursements_detail/cubit/rm_reimbursement_detail_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../../core/widget/common/form_label_widget.dart';
import '../../../../../reimbursements/data/model/reimbursement_detail_response.dart';
import '../../rm_approved_dialog/widget/reimbursement_approv_reject_dialog.dart';
import '../cubit/rm_reimbursement_detail_cubit.dart';

class RMReimbursementsDetailWidget extends StatelessWidget {
  final String uuid;

  const RMReimbursementsDetailWidget(this.uuid, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<RMReimbursementDetailCubit>().getReimbursement(uuid);
    return buildWidgetsForMobile();
  }

  Widget buildWidgetsForMobile() {
    return BlocConsumer<RMReimbursementDetailCubit, RMReimbursementDetailState>(
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
        return AppScaffold(
            body: SafeArea(
              child: Column(
          children: [
              DefaultAppBar(
                isBackIconVisible: true,
                title: 'claim_details'.tr,
              ),
              Expanded(
                child: Column(
                  children: [
                    if (state.isLoading ?? false) ...[
                      const Expanded(child: AppCircularProgressIndicator())
                    ] else if (state.reimbursementDetailResponse?.data! !=
                        null) ...[
                      Expanded(
                          child: InternetSensitive(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(Dimens.padding_16),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(Dimens.radius_16),
                                  border: Border.all(color: Get.theme.getCustomColor(context).warning250!)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  buildStatusWidget(context, state.reimbursementDetailResponse?.data?.status ?? ""),
                                  const SizedBox(height: Dimens.padding_12),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: Dimens.padding_16),
                                    child: buildManagerReimbursementType(state.reimbursementDetailResponse?.data),
                                  ),
                                  const SizedBox(height: Dimens.padding_16),
                                  buildFromDateToDateWidget(state.reimbursementDetailResponse),
                                  const SizedBox(height: Dimens.padding_16),
                                  buildClaimNumAndClaimAmtWidget(state.reimbursementDetailResponse),
                                  const SizedBox(height: Dimens.padding_16),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: Dimens.padding_16),
                                    child: buildDetailWidget('reporting_manager'.tr,
                                        state.reimbursementDetailResponse?.data?.approverName ?? ""),
                                  ),
                                  const SizedBox(height: Dimens.padding_24),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: Dimens.margin_16),
                                    child: HDivider(dividerColor: Get.theme.getCustomColor(Get.context!).backgroundgrey400),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: Dimens.padding_16),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        state.reimbursementDetailResponse?.data?.metadata?.vendorName != null
                                            ? Expanded(child: buildSingleMetadataWidget(context, 'vendor_name'.tr,
                                            state.reimbursementDetailResponse?.data?.metadata?.vendorName),)
                                            : const SizedBox(),
                                        Expanded(
                                          child: buildSingleMetadataWidget(context, 'date_of_travel'.tr,
                                              state.reimbursementDetailResponse?.data?.metadata?.dateOfTravel),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(padding: const EdgeInsets.symmetric(horizontal: Dimens.padding_16),
                                    child: Row(
                                      children: [
                                        state.reimbursementDetailResponse?.data?.metadata?.fromDestination != null
                                            ? Expanded(
                                                child: buildSingleMetadataWidget(context, 'from_destination'.tr, state
                                                        .reimbursementDetailResponse?.data?.metadata?.fromDestination),
                                              )
                                            : const SizedBox(),
                                        Expanded(
                                          child: buildSingleMetadataWidget(context, 'to_destination'.tr,
                                              state.reimbursementDetailResponse?.data?.metadata?.toDestination),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(padding: const EdgeInsets.symmetric(horizontal: Dimens.padding_16),
                                    child: Row(
                                      children: [
                                        state.reimbursementDetailResponse?.data?.metadata?.stayLocation != null
                                            ? Expanded(
                                                child: buildSingleMetadataWidget(context, 'stay_location'.tr,
                                                    state.reimbursementDetailResponse?.data?.metadata?.stayLocation),
                                              )
                                            : const SizedBox(),
                                        Expanded(
                                          child: buildSingleMetadataWidget(context, 'stay_date'.tr,
                                              state.reimbursementDetailResponse?.data?.metadata?.stayDate),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: Dimens.padding_16),
                                    child: buildSingleMetadataWidget(context, 'distance_travelled'.tr,
                                        state.reimbursementDetailResponse?.data?.metadata?.distanceTravelled),
                                  ),
                                  const SizedBox(height: Dimens.padding_12),
                                  buildAttachmentFileWidget(state.reimbursementDetailResponse),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )),
                      Visibility(
                        visible: state.reimbursementDetailResponse?.data?.status == 'PENDING',
                        child: buildApproveAndRejectWidget(context, state.reimbursementDetailResponse?.data),
                      ),
                    ] else ...[
                      const SizedBox()
                    ]
                  ],
                ),
              ),
          ],
        ),
            ));
      },
    );
  }

  Widget buildFromDateToDateWidget(
      ReimbursementDetailResponse? reimbursementDetailResponse) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.padding_16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: buildDetailWidget('from_date'.tr,
                    reimbursementDetailResponse?.data?.startDate?.getDateWithMonthName() ?? ""),
              ),
              Expanded(
                child: buildDetailWidget('to_date'.tr,
                    reimbursementDetailResponse?.data?.endDate?.getDateWithMonthName() ?? ""),
              ),
            ],
          ),
          const SizedBox(height: Dimens.padding_12),
          HDivider(dividerColor: Get.theme.getCustomColor(Get.context!).backgroundgrey400),
        ],
      ),
    );
  }

  Widget buildClaimNumAndClaimAmtWidget(
      ReimbursementDetailResponse? reimbursementDetailResponse) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.padding_16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: buildDetailWidget('claim_number'.tr,
                    reimbursementDetailResponse?.data?.invoiceNumber ?? ""),
              ),
              Expanded(
                child: buildDetailWidget('claim_amount'.tr,
                    "${Constants.rs} ${reimbursementDetailResponse?.data?.amount.toString()}" ?? ""),
              ),
            ],
          ),
          const SizedBox(height: Dimens.padding_12),
          HDivider(dividerColor: Get.theme.getCustomColor(Get.context!).backgroundgrey400),
        ],
      ),
    );
  }

  Widget buildAttachmentFileWidget(
      ReimbursementDetailResponse? reimbursementDetailResponse) {
    if (reimbursementDetailResponse?.data?.attachmentUrl != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimens.padding_16),
            child: Text(
              'attachments'.tr,
              style: Get.textTheme.titleSmall?.copyWith(
                  color:
                      Get.theme.getCustomColor(Get.context!).backgroundgrey700),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(Dimens.padding_16,
                Dimens.padding_12, Dimens.padding_16, Dimens.padding_24),
            child: Card(
              color: AppColors.backgroundWhite,
              child: Padding(
                padding: const EdgeInsets.all(Dimens.padding_16),
                child: MyInkWell(
                  onTap: () {
                    downloadFile(
                        reimbursementDetailResponse?.data!, Get.context!);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimens.padding_16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          'assets/images/ic_pdf.svg',
                        ),
                        const SizedBox(width: Dimens.padding_16),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'download_attachment'.tr,
                              style: Get.textTheme.titleSmall?.copyWith(
                                  color: Get.theme
                                      .getCustomColor(Get.context!)
                                      .backgroundblack),
                            ),
                            Text(
                              "pdf".tr,
                              style: Get.textTheme.bodySmall?.copyWith(
                                  color: Get.theme
                                      .getCustomColor(Get.context!)
                                      .backgroundblack),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      return const SizedBox();
    }
  }

  Widget buildStatusWidget(BuildContext context, String? status) {
    return Container(
      padding: const EdgeInsets.only(
          left: Dimens.padding_16,
          right: Dimens.padding_16,
          top: Dimens.padding_16,
          bottom: Dimens.padding_16),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(Dimens.radius_16),
            topLeft: Radius.circular(Dimens.radius_16)),
        color: getColor(status!)[Constants.bgColor],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: Dimens.padding_16),
            child: Image.asset(
              getColor(status)['img_url'],
            ),
          ),
          Text('${'claims'.tr} ${getColor(status)['status']}',
              style: Get.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Get.theme.colorScheme.onPrimary)),
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
      BuildContext context, ReimbursementDetail? reimbursementDetail) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(Dimens.padding_16, Dimens.padding_24,
          Dimens.padding_16, Dimens.padding_24),
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
                showReimbursementApproveRejectDialog(context, reimbursementDetail, true);
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
                showReimbursementApproveRejectDialog(context, reimbursementDetail, false);
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> downloadFile(
      ReimbursementDetail? reimbursementDetail, BuildContext context) async {
    FileUtils.download(context, reimbursementDetail?.attachmentUrl ?? "",
        reimbursementDetail?.invoiceNumber ?? "hrmsFile");
  }

  Widget buildManagerReimbursementType(
      ReimbursementDetail? reimbursementDetail) {
    return Padding(
      padding: const EdgeInsets.only(top: Dimens.margin_12),
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
                Text("${reimbursementDetail?.userName}",
                    style: Get.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: Get.theme
                            .getCustomColor(Get.context!)
                            .backgroundgrey900)),
                Text("${reimbursementDetail?.employeeId}",
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

  Map<String, dynamic> getColor(String status) {
    switch (status) {
      case "PENDING":
        return {
          Constants.bgColor:
              Get.theme.getCustomColor(Get.context!).sourceWarning250!,
          'img_url': 'assets/images/ic_pending.png',
          'status': 'pending',
        };
      case "APPROVED":
        return {
          Constants.bgColor: Get.theme.getCustomColor(Get.context!).success300!,
          'img_url': 'assets/images/ic_approved.png',
          'status': 'Successfully',
        };
      case "REJECTED":
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

  Widget buildSingleMetadataWidget(
      BuildContext context, String? label, String? answer) {
    if (label != null && answer != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: Dimens.padding_12),
          FormLabelWidget(
              labelText: label,
              textColor:
                  Theme.of(context).getCustomColor(context).backgroundgrey700),
          const SizedBox(height: Dimens.padding_4),
          buildAnswerValueWidget(context, answer),
          const SizedBox(height: Dimens.padding_12),
          HDivider(
              dividerColor: Get.theme.getCustomColor(context).backgroundgrey400,
              verticalPadding: Dimens.padding_8),
          // const SizedBox(height: Dimens.padding_12),
        ],
      );
    } else {
      return const SizedBox();
    }
  }

  Widget buildAnswerValueWidget(BuildContext context, String answerValue) {
    return Text(answerValue,
        style: Get.textTheme.bodyMedium?.copyWith(
            color:
                Theme.of(context).extension<CustomColors>()!.backgroundgrey900,
            fontWeight: FontWeight.w600));
  }
}
