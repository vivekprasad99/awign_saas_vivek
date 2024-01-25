import 'package:awign_saas/core/data/local/database/user_preferences/user_preferences.dart';
import 'package:awign_saas/core/data/model/ui_state.dart';
import 'package:awign_saas/core/extension/common_extension.dart';
import 'package:awign_saas/core/router/router.dart';
import 'package:awign_saas/core/utils/browser_helper.dart';
import 'package:awign_saas/core/widget/app_bar/default_app_bar.dart';
import 'package:awign_saas/core/widget/buttons/my_ink_well.dart';
import 'package:awign_saas/core/widget/dialog/loading/app_circular_progress_indicator.dart';
import 'package:awign_saas/core/widget/network_sensitive/internet_sensitive.dart';
import 'package:awign_saas/core/widget/scaffold/app_scaffold.dart';
import 'package:awign_saas/core/widget/theme/color_schemes.g.dart';
import 'package:awign_saas/core/widget/theme/dimens.dart';
import 'package:awign_saas/hrms/documents/features/company_document/cubit/company_document_cubit.dart';
import 'package:awign_saas/hrms/documents/features/company_document/cubit/company_document_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'tile/my_documents_tile.dart';

class DocumentsTabWidget extends StatelessWidget {
  const DocumentsTabWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    searchDocuments(context);
    return buildWidgetsForMobile();
  }

  Widget buildWidgetsForMobile() {
    return BlocConsumer<CompanyDocumentCubit, CompanyDocumentState>(
      listenWhen: (previous, current) {
        return previous.uiState != current.uiState;
      },
      listener: (context, state) {},
      buildWhen: (context, state) {
        return state.uiState?.event == Event.reloadWidget;
      },
      builder: (context, state) {
        return AppScaffold(
            body: SafeArea(
              child: Column(
          children: [
              DefaultAppBar(
                isBackIconVisible: true,
                title: 'documents'.tr,
              ),
              Expanded(
                child: InternetSensitive(
                  child: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Dimens.padding_16),
                          child: buildDocumentsTypeTabBar(context),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
            ));
      },
    );
  }

  Widget buildDocumentsTypeTabBar(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Container(
            height: Dimens.tabBarHeight_40,
            decoration: BoxDecoration(
              color: Get.theme.getCustomColor(context).secondary1100!,
              borderRadius: BorderRadius.circular(Dimens.radius_6),
            ),
            child: TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BoxDecoration(
                color: Get.theme.colorScheme.onPrimary,
                borderRadius: BorderRadius.circular(Dimens.radius_6),
                border: Border.all(
                    color: Get.theme.getCustomColor(context).secondary1300!),
              ),
              labelColor: Get.theme.getCustomColor(context).backgroundgrey900!,
              labelPadding: EdgeInsets.zero,
              labelStyle: Get.textTheme.labelLarge?.copyWith(
                  color: Get.theme.getCustomColor(context).backgroundgrey900,
                  fontWeight: FontWeight.w700),
              unselectedLabelStyle: Get.textTheme.labelLarge?.copyWith(
                  color: Get.theme.getCustomColor(context).backgroundgrey900),
              onTap: (index) {},
              tabs: [
                Tab(
                    child: Text(
                  'company_documents'.tr,
                )),
                Tab(
                    child: Text(
                  'my_documents'.tr,
                )),
              ],
            ),
          ),
          const SizedBox(
            height: Dimens.padding_16,
          ),
          Expanded(
            child: TabBarView(
              children: [
                buildCompanyDocuments(context),
                buildMyDocumentsList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCompanyDocuments(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.fromLTRB(0, Dimens.padding_16, 0, Dimens.padding_16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // buildAction(
              //   'assets/images/ic_payslip_action.png',
              //   Get.theme.getCustomColor(context).backgroundgrey900!,
              //   const Color(0xffFAF2FF),
              //   const Color(0xffDEB1FF),
              //   () {
              //     MRouter.pushNamed(MRouter.companyDocumentWidget,
              //         arguments: 'payslips');
              //   },
              //   context,
              //   'payslips'.tr,
              // ),
              // const SizedBox(width: Dimens.padding_16),
              buildAction(
                'assets/images/ic_policies_action.png',
                Get.theme.getCustomColor(context).backgroundgrey900!,
                const Color(0xffFFFDF6),
                const Color(0xffEDD377),
                () {
                  MRouter.pushNamed(MRouter.companyDocumentWidget,
                      arguments: 'policies');
                },
                context,
                'policies'.tr,
              ),
              const Expanded(child: SizedBox()),
            ],
          ),
          // const SizedBox(height: Dimens.padding_16),
          // Row(
          //   children: [
          //     buildAction(
          //       'assets/images/ic_form.png',
          //       Get.theme.getCustomColor(context).backgroundgrey900!,
          //       const Color(0xffFAF2FF),
          //       const Color(0xffFAF2FF),
          //       () {
          //         MRouter.pushNamed(MRouter.companyDocumentWidget,
          //             arguments: 'form_16');
          //       },
          //       context,
          //       'form_16'.tr,
          //     ),
          //     const SizedBox(width: Dimens.padding_16),
          //     const Spacer(),
          //   ],
          // ),
        ],
      ),
    );
  }

  Widget buildAction(
      String image,
      Color textColor,
      Color startColor,
      Color endColor,
      Function onTap,
      BuildContext context,
      String documentType) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimens.radius_8),
          color: Get.theme.colorScheme.onPrimary!,
          border: Border.all(
            color: endColor,
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(Dimens.radius_8),
                    topRight: Radius.circular(Dimens.radius_8)),
                gradient: LinearGradient(
                  begin: const Alignment(-0, -1.07),
                  end: const Alignment(-0, 1),
                  colors: <Color>[startColor, endColor],
                  stops: const <double>[0, 1],
                ),
              ),
              child: MyInkWell(
                onTap: () {
                  onTap();
                },
                child: Center(
                  child: Image.asset(
                    image,
                    height: Dimens.margin_120,
                  ),
                ),
              ),
            ),
            const SizedBox(height: Dimens.padding_8),
            Padding(
              padding: const EdgeInsets.only(
                  left: Dimens.padding_16, bottom: Dimens.padding_8),
              child: Text(documentType,
                  style: Get.textTheme.titleSmall?.copyWith(
                      color: textColor,
                      fontSize: Dimens.font_12,
                      fontWeight: FontWeight.w700)),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMyDocumentsList() {
    return BlocBuilder<CompanyDocumentCubit, CompanyDocumentState>(
      buildWhen: (preState, curState) {
        return (preState.isSearchDocumentLoading !=
            curState.isSearchDocumentLoading);
      },
      builder: (context, state) {
        if (state.isSearchDocumentLoading ?? false) {
          return const Padding(
            padding: EdgeInsets.all(Dimens.padding_150),
            child: AppCircularProgressIndicator(),
          );
        } else if (!state.documents.isNullOrEmpty) {
          return ListView.separated(
            padding: EdgeInsets.zero,
            itemCount: state.documents!.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, i) {
              return MyInkWell(
                  onTap: () {
                    BrowserHelper.customTab(context, state.documents![i].url!);
                  },
                  child: MyDocumentsTile(
                    documents: state.documents![i],
                  ));
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: Dimens.padding_12);
            },
          );
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/images/ic_no_data_found.svg',
                ),
                const SizedBox(height: Dimens.padding_16),
                Text(
                  'no_document_found'.tr,
                  style: Get.textTheme.titleMedium?.copyWith(
                      color: Theme.of(context)
                          .getCustomColor(context)
                          .secondary1300,
                      fontSize: Dimens.font_18),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  void searchDocuments(BuildContext context) {
    String? id =
        UserPreferences.getInstance().getCurrentUser()?.tenant?.userId ?? '';
    context.read<CompanyDocumentCubit>().searchDocument('personal', id);
  }
}
