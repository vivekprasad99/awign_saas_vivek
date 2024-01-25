import 'package:awign_saas/core/data/local/database/user_preferences/user_preferences.dart';
import 'package:awign_saas/core/router/router.dart';
import 'package:awign_saas/core/utils/constants.dart';
import 'package:awign_saas/core/widget/buttons/my_ink_well.dart';
import 'package:awign_saas/core/widget/divider/h_divider.dart';
import 'package:awign_saas/core/widget/scaffold/app_scaffold.dart';
import 'package:awign_saas/core/widget/theme/theme_manager.dart';
import 'package:awign_saas/hrms/dashboard/features/profile/cubit/profile_cubit.dart';
import 'package:awign_saas/hrms/dashboard/features/profile/cubit/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../../core/data/model/ui_state.dart';
import '../../../../../core/utils/browser_helper.dart';
import '../../../../../core/utils/helper.dart';
import '../../../../../core/widget/app_bar/default_app_bar.dart';
import '../../../../../core/widget/buttons/custom_text_button.dart';
import '../../../../../core/widget/network_sensitive/internet_sensitive.dart';
import '../../../data/dynammic_module.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildWidgetsForMobile();
  }

  Widget buildWidgetsForMobile() {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listenWhen: (previous, current) {
        return previous.uiState != current.uiState;
      },
      listener: (context, state) {

      },
      buildWhen: (context, state) {
        return state.uiState?.event == Event.reloadWidget;
      },
      builder: (context, state) {
        return AppScaffold(
          backgroundColor: Get.theme.colorScheme.primary,
          body: SafeArea(
            child: Container(
              color: Get.theme.colorScheme.background,
              child: Column(
                children: [
                  DefaultAppBar(
                      backgroundColor: Get.theme.colorScheme.primary,
                      title: 'profile'.tr,
                      textColor: Get.theme.getCustomColor(context).backgroundwhite),
                  Expanded(
                    child: InternetSensitive(
                      child: SingleChildScrollView(
                        child: Stack(
                          children: [
                            Container(
                              height: 80,
                              color: Get.theme.colorScheme.primary,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: Dimens.padding_16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: Dimens.padding_8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SvgPicture.asset(
                                        'assets/images/ic_circular_profile_place_holder.svg',
                                        width: Dimens.imageWidth_150,
                                        height: Dimens.imageHeight_150,
                                      ),
                                      /// Temp Removed
                                      // buildEditProfileButton(context),
                                    ],
                                  ),
                                  const SizedBox(height: Dimens.padding_16),
                                  buildNameWidget(),
                                  const SizedBox(height: Dimens.padding_24),
                                  buildAction('personal_details'.tr, 'assets/images/ic_personal_details.svg', () {
                                    MRouter.pushNamed(MRouter.personalDetailsWidget);
                                  }, isDividerVisible: false),
                                  buildQuickActions(context),
                                  buildAction('logout'.tr, 'assets/images/ic_logout.svg', () {
                                    Helper.doLogout();
                                  }),
                                  const SizedBox(height: Dimens.padding_32),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildQuickActions(BuildContext context) {
    List<String> modules =
        UserPreferences.getInstance().getCurrentUser()?.tenant?.modules ?? [];
    List<Widget> quickActionWidget = [];
    if(modules.contains(DynamicModule.hrmsAttendance.value)) {
      quickActionWidget.add(getQuickAction(context, DynamicModule.hrmsAttendance.value));
    }
    if(modules.contains(DynamicModule.hrmsRegularization.value)) {
      quickActionWidget.add(getQuickAction(context, DynamicModule.hrmsRegularization.value));
    }
    if(modules.contains(DynamicModule.hrmsLeave.value)) {
      quickActionWidget.add(getQuickAction(context, DynamicModule.hrmsLeave.value));
    }
    if(modules.contains(DynamicModule.hrmsCompOff.value)) {
      quickActionWidget.add(getQuickAction(context, DynamicModule.hrmsCompOff.value));
    }
    if(modules.contains(DynamicModule.hrmsReimbursement.value)) {
      quickActionWidget.add(getQuickAction(context, DynamicModule.hrmsReimbursement.value));
    }
    if(modules.contains(DynamicModule.hrmsHolidays.value)) {
      quickActionWidget.add(getQuickAction(context, DynamicModule.hrmsHolidays.value));
    }
    if(modules.contains(DynamicModule.hrmsDocuments.value)) {
      quickActionWidget.add(getQuickAction(context, DynamicModule.hrmsDocuments.value));
    }
    if(modules.contains(DynamicModule.hrmsFaqs.value)) {
      quickActionWidget.add(getQuickAction(context, DynamicModule.hrmsFaqs.value));
    }
    if(modules.contains(DynamicModule.hrmsTaskFulfilment.value)) {
      quickActionWidget.add(getQuickAction(context, DynamicModule.hrmsTaskFulfilment.value));
    }
    return Column(
      children: quickActionWidget,
    );
  }

  Widget getQuickAction(BuildContext context, String module) {
    return switch (DynamicModule.get(module)) {
      DynamicModule.hrmsAttendance => buildAction('attendance'.tr, 'assets/images/ic_attendance_profile.svg', () {
        MRouter.pushNamed(MRouter.attendanceDashboardWidget);
      }),
      DynamicModule.hrmsRegularization => buildAction('regularisation'.tr, 'assets/images/ic_regularisation_profile.svg', () {
        MRouter.pushNamed(MRouter.regularisationDashboardWidget);
      }),
      DynamicModule.hrmsLeave => buildAction('leaves'.tr, 'assets/images/ic_leaves_profile.svg', () {
        MRouter.pushNamed(MRouter.leavesListingWidget);
      }),
      DynamicModule.hrmsReimbursement => buildAction('reimbursement'.tr, 'assets/images/ic_reimbursement_profile.svg', () {
        MRouter.pushNamed(MRouter.reimbursementsWidget);
      }),
      DynamicModule.hrmsDocuments => buildAction('documents'.tr, 'assets/images/ic_documents_profile.svg', () {
        MRouter.pushNamed(MRouter.documentsTabWidget);
      }),
      DynamicModule.hrmsHolidays => buildAction('holidays'.tr, 'assets/images/ic_holidays_profile.svg', () {
        MRouter.pushNamed(MRouter.holidaysListingWidget);
      }),
      DynamicModule.hrmsFaqs => buildAction('faqs'.tr, 'assets/images/ic_faqs_profile.svg', () {
        MRouter.pushNamed(MRouter.faqWidget);
      }),
      DynamicModule.hrmsCompOff => buildAction('comp_off'.tr, 'assets/images/ic_comp_off_leave_profile.svg', () {
        MRouter.pushNamed(MRouter.compOffListingWidget);
      }),
      DynamicModule.hrmsTaskFulfilment => buildAction('task_fulfilment'.tr, 'assets/images/ic_task_fulfilment_profile.svg', () {
        BrowserHelper.customTab(context, Constants.taskFulfilmentURL);
      }),
      _ => const SizedBox(),
    };
  }
  
  Widget buildEditProfileButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: Dimens.padding_16),
      child: CustomTextButton(
        width: Dimens.btnWidth_110,
        height: Dimens.btnHeight_40,
        text: 'edit_profile'.tr,
        textColor: Get.theme.colorScheme.primary,
        backgroundColor: Get.theme.getCustomColor(context).backgroundwhite,
        onPressed: () {

          // onYesTap();
        },
      ),
    );
  }

  Widget buildNameWidget() {
    return Text(UserPreferences.getInstance().getCurrentUser()?.name ?? '', style: Get.textTheme.bodyLarge?.copyWith(fontSize: Dimens.font_18, fontWeight: FontWeight.w600));
  }

  Widget buildAction(String text, String icon, Function onTap, {bool isDividerVisible = true}) {
    return Column(
      children: [
        isDividerVisible ? buildHDivider() : const SizedBox(),
        MyInkWell(
          onTap: onTap,
          child: Row(
            children: [
              SvgPicture.asset(
                icon,
                color: Get.theme.getCustomColor(Get.context!).backgroundblack,
                width: Dimens.iconSize_24,
                height: Dimens.iconSize_24,
              ),
              const SizedBox(width: Dimens.padding_16),
              Text(text, style: Get.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildHDivider() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(Dimens.padding_36, Dimens.padding_12, 0, Dimens.padding_12),
      child: HDivider(dividerColor: Get.theme.colorScheme.primaryContainer, dividerThickness: Dimens.dividerHeight_1),
    );
  }
}
