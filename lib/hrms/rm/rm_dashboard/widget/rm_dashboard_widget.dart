import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../../core/router/router.dart';
import '../../../../../core/widget/app_bar/tenant_app_bar.dart';
import '../../../../../core/widget/buttons/my_ink_well.dart';
import '../../../../../core/widget/network_sensitive/internet_sensitive.dart';
import '../../../../../core/widget/scaffold/app_scaffold.dart';
import '../../../../../core/widget/theme/color_schemes.g.dart';
import '../../../../../core/widget/theme/dimens.dart';
import '../../../../core/data/local/database/user_preferences/user_preferences.dart';
import '../../../dashboard/data/dynammic_module.dart';

class RMDashboardWidget extends StatelessWidget {
  const RMDashboardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildWidgetsForMobile(context);
  }

  Widget buildWidgetsForMobile(BuildContext context) {
    return AppScaffold(
      backgroundColor: Theme.of(context).extension<CustomColors>()!.secondary1200Container,
      body: SafeArea(
        child: Container(
          color: Get.theme.colorScheme.background,
          child: Column(
            children: [
              const TenantAppBar(
                  isTenantLogoVisible: true, isTenantNameVisible: true),
              Expanded(
                child: InternetSensitive(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: Dimens.margin_16),
                        buildHeaderWidget(context),
                        const SizedBox(height: Dimens.margin_8),
                        buildQuickActions(context),
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
  }

  Widget buildHeaderWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: Dimens.padding_16),
      child: Text(
        'rm_quick_actions'.tr,
        style: Get.textTheme.titleMedium?.copyWith(
            color: Theme.of(context)
                .extension<CustomColors>()!
                .backgroundblack,
            fontSize: Dimens.font_18,
            fontWeight: FontWeight.w700),
      ),
    );
  }

  Widget buildQuickActions(BuildContext context) {
    List<String> modules =
        UserPreferences.getInstance().getCurrentUser()?.tenant?.modules ?? [];
    List<Widget> quickActionWidget = [];
    for (String module in modules) {
      quickActionWidget.add(getQuickAction(context, module));
    }
    return Column(
      children: quickActionWidget,
    );
  }

  Widget getQuickAction(BuildContext context, String module) {
    return switch (DynamicModule.get(module)) {
      DynamicModule.hrmsAttendance => buildAction(
          context,
          'assets/images/ic_attendance_action.png',
          'attendance'.tr,
          'attendance_summary'.tr,
          const Color(0xfff7f8ff),
          const Color(0xffbbb4ec),
              () {
            MRouter.pushNamed(MRouter.rmAttendanceDashboardWidget);
          }),
      DynamicModule.hrmsRegularization => buildAction(
          context,
          'assets/images/ic_regularise_action.png',
          'regularisation'.tr,
          'regularisation_summary'.tr,
          const Color(0xffFFF8F7),
          const Color(0xffFFBEB0), () {
        MRouter.pushNamed(MRouter.rmRegularisationDashboardWidget);
      }),
      DynamicModule.hrmsLeave => buildAction(
          context,
          'assets/images/ic_leave_action.png',
          'leaves'.tr,
          'leaves_summary'.tr,
          const Color(0xffFFFCF3),
          const Color(0xffF2C960),
              () {
            MRouter.pushNamed(MRouter.rmLeaveListingWidget);
          }),
      DynamicModule.hrmsCompOff => buildAction(
          context,
          'assets/images/ic_comp_off_action.png',
          'comp_off'.tr,
          'comp_off_summary'.tr,
          const Color(0x59FBFFF4),
          const Color(0xFF83D38F),
              () {
            MRouter.pushNamed(MRouter.rmCompOffListingWidget);
          }),
      DynamicModule.hrmsReimbursement => buildAction(
          context,
          'assets/images/ic_claim_action.png',
          'reimbursement'.tr,
          'reimbursement_summary'.tr,
          const Color(0xffFCFFF4),
          const Color(0xffC9E38B), () {
        MRouter.pushNamed(MRouter.rmReimbursementsWidget);
      }),
      _ => const SizedBox(),
    };
  }

  Widget buildAction(BuildContext context, String image, String title, String subTitle, Color startColor,
      Color endColor, Function onTap) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(Dimens.padding_16, Dimens.padding_16, Dimens.padding_16, 0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimens.radius_12),
          border: Border.all(
            width: Dimens.border_1,
            color: endColor,
            style: BorderStyle.solid,
          ),
          gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            colors: <Color>[startColor, endColor],
            stops: const <double>[0, 1],
          ),
        ),
        child: MyInkWell(
          onTap: () {
            onTap();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                SizedBox(
                  width: 80,
                  height: 72,
                  child: Image.asset(image),
                ),
                const SizedBox(width: Dimens.padding_16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Get.textTheme.titleMedium?.copyWith(
                            color: Get.theme.getCustomColor(context).backgroundblack,
                            fontWeight: FontWeight.w700)),
                    Text(subTitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Get.textTheme.titleSmall?.copyWith(
                            color: AppColors.textColor,
                            fontSize: Dimens.font_14,
                            fontWeight: FontWeight.w400)),
                  ],
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: Dimens.padding_8,
                      horizontal: Dimens.padding_11),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimens.padding_8),
                    color: Get.theme
                        .getCustomColor(Get.context!)
                        .secondary1100!,
                  ),
                  child: SvgPicture.asset(
                    'assets/images/ic_arrow_forward.svg',
                  ),
                ),
                const SizedBox(width: Dimens.padding_12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
