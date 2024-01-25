import 'package:awign_saas/core/data/model/ui_state.dart';
import 'package:awign_saas/core/extension/string_extension.dart';
import 'package:awign_saas/core/router/router.dart';
import 'package:awign_saas/core/utils/constants.dart';
import 'package:awign_saas/core/utils/file_utils.dart';
import 'package:awign_saas/core/utils/helper.dart';
import 'package:awign_saas/core/widget/app_bar/default_app_bar.dart';
import 'package:awign_saas/core/widget/buttons/raised_rect_button.dart';
import 'package:awign_saas/core/widget/divider/h_divider.dart';
import 'package:awign_saas/core/widget/network_sensitive/internet_sensitive.dart';
import 'package:awign_saas/core/widget/scaffold/app_scaffold.dart';
import 'package:awign_saas/core/widget/theme/theme_manager.dart';
import 'package:awign_saas/hrms/reimbursements/features/reimbursements_detail/cubit/reimbursement_detail_cubit.dart';
import 'package:awign_saas/hrms/reimbursements/features/reimbursements_detail/cubit/reimbursement_detail_state.dart';
import 'package:awign_saas/hrms/reimbursements/features/reimbursements_detail/widget/dialog/delete_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../core/widget/buttons/my_ink_well.dart';
import '../../../../../core/widget/common/form_label_widget.dart';
import '../../../../../core/widget/dialog/loading/app_circular_progress_indicator.dart';
import '../../../data/model/reimbursement_detail_response.dart';

class ReimbursementsDetailWidget extends StatelessWidget {
  final String uuid;

  const ReimbursementsDetailWidget(this.uuid, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<ReimbursementDetailCubit>().getReimbursement(uuid);
    return AppScaffold(
        body: SafeArea(
          child: Column(
      children: [
          DefaultAppBar(
            isBackIconVisible: true,
            title: 'reimbursement_details'.tr,
          ),
          BlocConsumer<ReimbursementDetailCubit, ReimbursementDetailState>(
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
              return BlocBuilder<ReimbursementDetailCubit,
                  ReimbursementDetailState>(
                builder: (context, state) {
                  if(state.isLoading ?? false) {
                    return const Expanded(child: AppCircularProgressIndicator());
                  } else if (state.reimbursementDetailResponse?.data != null) {
                    return Expanded(
                      child: Column(
                        children: [
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
                                          borderRadius:
                                          BorderRadius.circular(Dimens.radius_16),
                                          border: Border.all(
                                            color: Get.theme
                                                .getCustomColor(context)
                                                .warning250!,
                                          )),
                                      child: Column(
                                        children: [
                                          buildStatusWidget(
                                              context,
                                              state.reimbursementDetailResponse?.data
                                                  ?.status ??
                                                  ""),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(Dimens.padding_16, Dimens.padding_24, Dimens.padding_16, Dimens.padding_24),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const SizedBox(height: Dimens.padding_12),
                                                FormLabelWidget(labelText: 'claim_type'.tr, textColor: Theme.of(context).getCustomColor(context).backgroundgrey700),
                                                const SizedBox(height: Dimens.padding_4),
                                                buildAnswerValueWidget(context, state.reimbursementDetailResponse?.data?.reimbursementType?.toCapitalized() ?? ""),
                                                const SizedBox(height: Dimens.padding_12),
                                                HDivider(dividerColor: Get.theme.getCustomColor(context).backgroundgrey400, verticalPadding: Dimens.padding_8),
                                                const SizedBox(height: Dimens.padding_12),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          FormLabelWidget(labelText: 'applied_on'.tr, textColor: Theme.of(context).getCustomColor(context).backgroundgrey700),
                                                          const SizedBox(height: Dimens.padding_4),
                                                          buildAnswerValueWidget(context, state.reimbursementDetailResponse
                                                              ?.data!.createdAt
                                                              ?.getDateWithMonthName() ??
                                                              ""),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          FormLabelWidget(labelText: 'receipt_no'.tr, textColor: Theme.of(context).getCustomColor(context).backgroundgrey700),
                                                          const SizedBox(height: Dimens.padding_4),
                                                          buildAnswerValueWidget(context, state.reimbursementDetailResponse
                                                              ?.data!.invoiceNumber ??
                                                              ""),
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
                                                          FormLabelWidget(labelText: 'reason'.tr, textColor: Theme.of(context).getCustomColor(context).backgroundgrey700),
                                                          const SizedBox(height: Dimens.padding_4),
                                                          buildAnswerValueWidget(context, state.reimbursementDetailResponse
                                                              ?.data!.comments ??
                                                              ""),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          FormLabelWidget(labelText: 'approver'.tr, textColor: Theme.of(context).getCustomColor(context).backgroundgrey700),
                                                          const SizedBox(height: Dimens.padding_4),
                                                          buildAnswerValueWidget(context, state.reimbursementDetailResponse
                                                              ?.data!.approverName ??
                                                              ""),
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
                                                    state.reimbursementDetailResponse?.data?.amount != null ? Expanded(
                                                      child: buildRequestedAmountWidget(context, state.reimbursementDetailResponse?.data),
                                                    ) : const SizedBox(),
                                                    Expanded(
                                                      child: buildApprovedAmountWidget(context, state.reimbursementDetailResponse?.data),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: Dimens.padding_12),
                                                HDivider(dividerColor: Get.theme.getCustomColor(context).backgroundgrey400, verticalPadding: Dimens.padding_8),
                                                Row(
                                                  children: [
                                                    state.reimbursementDetailResponse?.data?.metadata?.vendorName != null ? Expanded(
                                                      child: buildSingleMetadataWidget(context, 'vendor_name'.tr,
                                                          state.reimbursementDetailResponse?.data?.metadata?.vendorName),
                                                    ) : const SizedBox(),
                                                    Expanded(
                                                      child: buildSingleMetadataWidget(context, 'date_of_travel'.tr,
                                                          state.reimbursementDetailResponse?.data?.metadata?.dateOfTravel),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    state.reimbursementDetailResponse?.data?.metadata?.fromDestination != null ? Expanded(
                                                      child: buildSingleMetadataWidget(context, 'from_destination'.tr,
                                                          state.reimbursementDetailResponse?.data?.metadata?.fromDestination),
                                                    ) : const SizedBox(),
                                                    Expanded(
                                                      child: buildSingleMetadataWidget(context, 'to_destination'.tr,
                                                          state.reimbursementDetailResponse?.data?.metadata?.toDestination),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    state.reimbursementDetailResponse?.data?.metadata?.stayLocation != null ? Expanded(
                                                      child: buildSingleMetadataWidget(context, 'stay_location'.tr,
                                                          state.reimbursementDetailResponse?.data?.metadata?.stayLocation),
                                                    ) : const SizedBox(),
                                                    Expanded(
                                                      child: buildSingleMetadataWidget(context, 'stay_date'.tr,
                                                          state.reimbursementDetailResponse?.data?.metadata?.stayDate),
                                                    ),
                                                  ],
                                                ),
                                                buildSingleMetadataWidget(context, 'distance_travelled'.tr,
                                                    state.reimbursementDetailResponse?.data?.metadata?.distanceTravelled),
                                                buildAttachmentFileWidget(state.reimbursementDetailResponse),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                          Visibility(
                              visible:
                              state.reimbursementDetailResponse?.data?.status ==
                                  'PENDING',
                              child: buildRequestReimbursementDeleteButtonWidgets(
                                  context)),
                        ],
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              );
            },
          ),
      ],
    ),
        ));
  }

  Widget buildRequestedAmountWidget(BuildContext context, ReimbursementDetail? reimbursementDetail) {
    if(reimbursementDetail?.amount != null) {
      return  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: Dimens.padding_8),
          FormLabelWidget(labelText: 'requested_amount'.tr, textColor: Theme.of(context).getCustomColor(context).backgroundgrey700),
          const SizedBox(height: Dimens.padding_4),
          buildAnswerValueWidget(context, reimbursementDetail?.amount?.toString() ?? ''),
        ],
      );
    } else {
      return const SizedBox();
    }
  }

  Widget buildApprovedAmountWidget(BuildContext context, ReimbursementDetail? reimbursementDetail) {
    if(reimbursementDetail?.approvedAmount != null) {
      return  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: Dimens.padding_8),
          FormLabelWidget(labelText: 'approved_amount'.tr, textColor: Theme.of(context).getCustomColor(context).backgroundgrey700),
          const SizedBox(height: Dimens.padding_4),
          buildAnswerValueWidget(context, reimbursementDetail?.approvedAmount ?? ''),
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
          Image.asset(
            getColor(status)['img_url'],
          ),
          const SizedBox(width: Dimens.padding_8),
          Text('${getColor(status)['status']}',
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

  Widget buildRequestReimbursementDeleteButtonWidgets(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(Dimens.padding_16, Dimens.padding_24,
          Dimens.padding_16, Dimens.padding_32),
      child: RaisedRectButton(
        backgroundColor: AppColors.transparent,
        borderColor: Get.theme.getCustomColor(context).secondary1300!,
        textColor: Get.theme.getCustomColor(context).secondary1300!,
        text: 'delete'.tr,
        fontSize: Dimens.padding_16,
        onPressed: () {
          onDeleteTap(context);
        },
      ),
    );
  }

  void onDeleteTap(BuildContext context) async {
    openDeleteDialog(context, () {
      MRouter.pop(null);
      context.read<ReimbursementDetailCubit>().deleteReimbursement(uuid);
    });
  }

  Future<void> downloadFile(
      ReimbursementDetail? reimbursementDetail, BuildContext context) async {
    FileUtils.download(context, reimbursementDetail?.attachmentUrl ?? "",
        reimbursementDetail?.invoiceNumber ?? "hrmsFile");
  }

  Map<String, dynamic> getColor(String status) {
    switch (status) {
      case "PENDING":
        return {
          Constants.bgColor:
              Get.theme.getCustomColor(Get.context!).sourceWarning250!,
          'img_url': 'assets/images/ic_pending.png',
          'status': 'request_pending'.tr,
        };
      case "APPROVED":
        return {
          Constants.bgColor: Get.theme.getCustomColor(Get.context!).success300!,
          'img_url': 'assets/images/ic_approved.png',
          'status': 'request_approved'.tr,
        };
      case "REJECTED":
        return {
          Constants.bgColor: Get.theme.colorScheme.error,
          'img_url': 'assets/images/ic_rejected.png',
          'status': 'request_rejected'.tr,
        };
      default:
        return {
          Constants.bgColor:
              Get.theme.getCustomColor(Get.context!).sourceWarning250!,
          'img_url': 'assets/images/ic_pending.png',
          'status': 'request_pending'.tr,
        };
    }
  }

  Widget buildSingleMetadataWidget(BuildContext context, String? label, String? answer) {
    if(label != null && answer != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: Dimens.padding_12),
          FormLabelWidget(labelText: label, textColor: Theme.of(context).getCustomColor(context).backgroundgrey700),
          const SizedBox(height: Dimens.padding_4),
          buildAnswerValueWidget(context, answer),
          const SizedBox(height: Dimens.padding_12),
          HDivider(dividerColor: Get.theme.getCustomColor(context).backgroundgrey400, verticalPadding: Dimens.padding_8),
          const SizedBox(height: Dimens.padding_12),
        ],
      );
    } else {
      return const SizedBox();
    }
  }

  Widget buildAnswerValueWidget(BuildContext context, String answerValue) {
    return Text(answerValue, style: Get.textTheme.bodyMedium?.copyWith(
        color: Theme.of(context)
            .extension<CustomColors>()!
            .backgroundgrey900,
        fontWeight: FontWeight.w600));
  }

  Widget buildAttachmentFileWidget(
      ReimbursementDetailResponse? reimbursementDetailResponse) {
    if (reimbursementDetailResponse?.data?.attachmentUrl != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'attachments'.tr,
            style: Get.textTheme.titleSmall?.copyWith(
                color:
                Get.theme.getCustomColor(Get.context!).backgroundgrey700),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0,
                Dimens.padding_4, 0, 0),
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
}
