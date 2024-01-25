import 'package:awign_saas/core/data/local/database/user_preferences/user_preferences.dart';
import 'package:awign_saas/core/router/router.dart';
import 'package:awign_saas/core/utils/browser_helper.dart';
import 'package:awign_saas/core/utils/constants.dart';
import 'package:awign_saas/core/widget/app_bar/tenant_app_bar.dart';
import 'package:awign_saas/core/widget/buttons/my_ink_well.dart';
import 'package:awign_saas/core/widget/scaffold/app_scaffold.dart';
import 'package:awign_saas/hrms/attendance/features/regularisation_alert/cubit/regularisation_alert_cubit.dart';
import 'package:awign_saas/hrms/dashboard/features/home/cubit/home_cubit.dart';
import 'package:awign_saas/hrms/dashboard/features/home/cubit/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../core/config/cubit/flavor_cubit.dart';
import '../../../../../core/config/flavor_config.dart';
import '../../../../../core/data/model/ui_state.dart';
import '../../../../../core/di/app_injection_container.dart';
import '../../../../../core/widget/common/powered_by_widget.dart';
import '../../../../../core/widget/dialog/app_upgrade_dialog/app_upgrade_dialog.dart';
import '../../../../../core/widget/network_sensitive/internet_sensitive.dart';
import '../../../../../core/widget/theme/color_schemes.g.dart';
import '../../../../../core/widget/theme/dimens.dart';
import '../../../../attendance/features/attendance_dashboard/widget/mark_attendance/cubit/mark_attendance_cubit.dart';
import '../../../../attendance/features/attendance_dashboard/widget/mark_attendance/widget/mark_attendance_widget.dart';
import '../../../../attendance/features/regularisation_alert/widget/regularisation_alert_widget.dart';
import '../../../data/dynammic_module.dart';

class HomeWidget extends StatelessWidget {
  final _markAttendanceCubit = sl<MarkAttendanceCubit>();
  final _regularisationAlertCubit = sl<RegularisationAlertCubit>();
  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  HomeWidget({Key? key}) : super(key: key);

  _onAttendanceStatusLoaded() {
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    AppUpgradeDialogHelper().checkVersionAndShowAppUpgradeDialog(context);
    context.read<HomeCubit>().updateDeviceInfo();
    return buildWidgetsForMobile();
  }

  Widget buildWidgetsForMobile() {
    return BlocConsumer<HomeCubit, HomeState>(
      listenWhen: (previous, current) {
        return previous.uiState != current.uiState;
      },
      listener: (context, state) {},
      buildWhen: (context, state) {
        return state.uiState?.event == Event.reloadWidget;
      },
      builder: (context, state) {
        return AppScaffold(
          backgroundColor: Theme.of(context).extension<CustomColors>()!.secondary1200Container,
          topPadding: 0,
          bottomPadding: 0,
          body: buildBody(),
        );
      },
    );
  }

  Widget buildBody() {
    return SafeArea(
      child: Container(
        color: Get.theme.colorScheme.background,
        child: Column(
          children: [
            const TenantAppBar(
                isTenantLogoVisible: true, isTenantNameVisible: true),
            Expanded(
              child: InternetSensitive(
                child: SmartRefresher(
                  enablePullDown: true,
                  header: const MaterialClassicHeader(),
                  controller: _refreshController,
                  onRefresh: () {
                    _markAttendanceCubit.getAttendanceStatus(_onAttendanceStatusLoaded);
                    _regularisationAlertCubit.getAttendanceStatusByDateRange();
                  },
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildBannerWidget(),
                        buildPunchInPunchOutContainer(),
                        BlocProvider(
                            create: (context) => _regularisationAlertCubit,
                            child: const RegularisationAlertWidget()),
                        buildQuickActions(Get.context!),
                        const PoweredByWidget(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget buildBannerWidget() {
  //   return BlocProvider(
  //       create: (context) => BannerCubit(), child: const BannerWidget());
  // }

  // Widget buildBannerWidget() {
  //   return BlocProvider(
  //       create: (context) => BannerCubit(), child: const BannerWidget());
  // }

  Widget buildBannerWidget() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(Dimens.padding_16, Dimens.padding_16, Dimens.padding_16, 0),
      child: MyInkWell(
        onTap: () {
          launchUrl(Uri.parse('https://www.randstad.in/'));
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(Dimens.padding_8),
          child: Image.asset(
            'assets/images/r_talent_banner.png',
            width: double.infinity,
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }

  Widget buildPunchInPunchOutContainer() {
    return BlocProvider(
      create: (context) => _markAttendanceCubit,
      child: const MarkAttendanceWidget(),
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
    return Padding(
      padding: const EdgeInsets.fromLTRB(Dimens.padding_16, Dimens.padding_16,
          Dimens.padding_16, Dimens.padding_16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          'quick_actions'.tr,
          style: Get.textTheme.titleMedium?.copyWith(
              color:
                  Theme.of(context).extension<CustomColors>()!.backgroundblack,
              fontSize: Dimens.font_18,
              fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: Dimens.padding_16),
        GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: Dimens.padding_16,
              crossAxisSpacing: Dimens.padding_8,
            ),
            padding: const EdgeInsets.only(top: 0),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: quickActionWidget),
        const SizedBox(height: Dimens.padding_16),
      ]),
    );
  }

  Widget getQuickAction(BuildContext context, String module) {
    return switch (DynamicModule.get(module)) {
      DynamicModule.hrmsAttendance => buildAction('assets/images/ic_attendance_action.png', 'attendance'.tr, AppColors.mediumPurple, const Color(0xfff7f8ff), const Color(0xffbbb4ec), () async {
        await MRouter.pushNamed(MRouter.attendanceDashboardWidget);
        _markAttendanceCubit.getAttendanceStatus(null);
      }),
      DynamicModule.hrmsRegularization => buildAction('assets/images/ic_regularise_action.png', 'regularisations'.tr, AppColors.leiFlower, const Color(0xffFFF8F7), const Color(0xffFFBEB0), () async {
        await MRouter.pushNamed(MRouter.regularisationDashboardWidget);
        _regularisationAlertCubit.getAttendanceStatusByDateRange();
      }),
      DynamicModule.hrmsLeave => buildAction('assets/images/ic_leave_action.png', 'leaves'.tr, AppColors.barcelonaBrown, const Color(0xffFEF0C7), const Color(0xffF2C960), () {
        MRouter.pushNamed(MRouter.leavesListingWidget);
      }),
      DynamicModule.hrmsCompOff => buildAction('assets/images/ic_comp_off_action.png', 'comp_off'.tr, AppColors.compOffGreen, const Color(0x59FBFFF4), const Color(0xFF83D38F), () {
        MRouter.pushNamed(MRouter.compOffListingWidget);
      }),
      DynamicModule.hrmsReimbursement => buildAction('assets/images/ic_claim_action.png', 'reimbursements'.tr, AppColors.darkOliveGreen, const Color(0xffFCFFF4), const Color(0xffC9E38B), () {
        MRouter.pushNamed(MRouter.reimbursementsWidget);
      }),
      DynamicModule.hrmsDocuments => buildAction('assets/images/ic_documents_action.png', 'documents'.tr, AppColors.blueDahlia, const Color(0xffF1F6FF), const Color(0xffB4D0FF), () {
        MRouter.pushNamed(MRouter.documentsTabWidget);
      }),
      DynamicModule.hrmsHolidays => buildAction('assets/images/ic_holidays_action.png', 'holidays'.tr, AppColors.blueBirdDay, const Color(0xffF3FBFF), const Color(0xffA5DEFF), () {
        MRouter.pushNamed(MRouter.holidaysListingWidget);
      }),
      DynamicModule.hrmsFaqs => buildAction('assets/images/ic_faqs_action.png', 'faqs'.tr, AppColors.blueStreak, const Color(0xffF1F6FF), const Color(0xffB4D0FF), () {
        MRouter.pushNamed(MRouter.faqWidget);
      }),
      DynamicModule.hrmsTaskFulfilment => buildAction('assets/images/ic_task_fulfilment_action.png', 'task_fulfilment'.tr, AppColors.taskFulfilmentText, const Color(0x00679BEE), const Color(0x844C7CC9), () {
        BrowserHelper.customTab(context, Constants.taskFulfilmentURL);
      }),
      _ => const SizedBox(),
    };
  }

  Widget buildAction(String image, String title, Color textColor, Color startColor, Color endColor, Function onTap) {
    return Container(
      decoration:  BoxDecoration (
        borderRadius:  BorderRadius.circular(Dimens.radius_8),
        gradient:  LinearGradient (
          begin:  const Alignment(-0, -1.07),
          end:  const Alignment(-0, 1),
          colors:  <Color>[startColor, endColor],
          stops:  const <double>[0, 1],
        ),
      ),
      child: MyInkWell(
        onTap: () {
          onTap();
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(Dimens.padding_8, Dimens.padding_16, Dimens.padding_8, Dimens.padding_16),
          child: Center(
            child: Column(
              children: [
                Text(title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Get.textTheme.titleSmall
                        ?.copyWith(color: textColor, fontSize: Dimens.font_12, fontWeight: FontWeight.w700)),
                const SizedBox(height: Dimens.padding_8),
                // SvgPicture.asset(image),
                Image.asset(image),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
