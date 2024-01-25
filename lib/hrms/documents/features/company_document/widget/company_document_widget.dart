import 'package:awign_saas/core/data/local/database/user_preferences/user_preferences.dart';
import 'package:awign_saas/core/extension/common_extension.dart';
import 'package:awign_saas/core/widget/app_bar/default_app_bar.dart';
import 'package:awign_saas/core/widget/buttons/my_ink_well.dart';
import 'package:awign_saas/core/widget/dialog/loading/app_circular_progress_indicator.dart';
import 'package:awign_saas/core/widget/network_sensitive/internet_sensitive.dart';
import 'package:awign_saas/core/widget/safe_area/responsive_safe_area.dart';
import 'package:awign_saas/core/widget/scaffold/app_scaffold.dart';
import 'package:awign_saas/core/widget/theme/dimens.dart';
import 'package:awign_saas/core/widget/theme/theme_manager.dart';
import 'package:awign_saas/hrms/documents/features/company_document/cubit/company_document_cubit.dart';
import 'package:awign_saas/hrms/documents/features/company_document/cubit/company_document_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../../core/data/model/ui_state.dart';
import '../../../../../core/utils/browser_helper.dart';
import 'tile/company_document_tile.dart';

class CompanyDocumentWidget extends StatelessWidget {
  final String documentType;

  const CompanyDocumentWidget(this.documentType, {Key? key}) : super(key: key);

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
                  title: documentType == 'payslips'
                      ? 'payslips'.tr
                      : documentType == 'policies'
                          ? 'policies'.tr
                          : 'form_16'.tr,
                ),
                Expanded(
                  child: InternetSensitive(
                    child: Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: Dimens.padding_16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // buildNavbarList(),
                                  buildPoliciesList(),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Widget buildNavbarList() {
  //   return Container(
  //     padding: const EdgeInsets.fromLTRB(0, Dimens.padding_16,
  //         0, Dimens.padding_16),
  //     decoration: const BoxDecoration(
  //       borderRadius: BorderRadius.only(
  //         topLeft: Radius.circular(Dimens.radius_16),
  //         topRight: Radius.circular(Dimens.radius_16),
  //       ),
  //     ),
  //     child: SizedBox(
  //       height: Dimens.margin_40,
  //       child: ListView.builder(
  //         itemCount: 5,
  //         scrollDirection: Axis.horizontal,
  //         shrinkWrap: true,
  //         itemBuilder: (BuildContext context, int index) {
  //             return const PoliciesNavbarTile();
  //         },),
  //     )
  //   );
  // }

  Widget buildPoliciesList() {
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
                    BrowserHelper.customTab(
                        context, state.documents![i].url!);
                  },
                  child: PoliciesTile(
                    documents: state.documents![i],
                  ));
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: Dimens.padding_12);
            },
          );
        } else {
          return Padding(
            padding: const EdgeInsets.only(top: Dimens.padding_36),
            child: Center(
              child: Column(
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
            ),
          );
        }
      },
    );
  }

  void searchDocuments(BuildContext context) {
    String? id =
        UserPreferences.getInstance().getCurrentUser()?.tenant?.userId ?? '';
    context.read<CompanyDocumentCubit>().searchDocument(documentType, id);
  }
}
