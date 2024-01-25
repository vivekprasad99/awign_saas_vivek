import 'package:awign_saas/core/data/model/ui_state.dart';
import 'package:awign_saas/core/extension/common_extension.dart';
import 'package:awign_saas/core/widget/app_bar/default_app_bar.dart';
import 'package:awign_saas/core/widget/dialog/loading/app_circular_progress_indicator.dart';
import 'package:awign_saas/core/widget/divider/h_divider.dart';
import 'package:awign_saas/core/widget/network_sensitive/internet_sensitive.dart';
import 'package:awign_saas/core/widget/scaffold/app_scaffold.dart';
import 'package:awign_saas/core/widget/theme/dimens.dart';
import 'package:awign_saas/core/widget/theme/theme_manager.dart';
import 'package:awign_saas/hrms/faq/features/faq/cubit/faq_cubit.dart';
import 'package:awign_saas/hrms/faq/features/faq/cubit/faq_state.dart';
import 'package:awign_saas/hrms/faq/features/faq/widget/tile/faq_navbar_tile.dart';
import 'package:awign_saas/hrms/faq/features/faq/widget/tile/faq_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/get_utils.dart';

import '../../../data/model/faq_navbar_data.dart';

class FaqWidget extends StatelessWidget {
  const FaqWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<FaqCubit>().getFaqType();
    return buildWidgetsForMobile();
  }

  Widget buildWidgetsForMobile() {
    return BlocConsumer<FaqCubit, FaqState>(
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
                  title: 'faqs'.tr,
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
                                  buildNavbarList(),
                                  buildFaqList(),
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

  Widget buildNavbarList() {
    return BlocBuilder<FaqCubit, FaqState>(
      buildWhen: (preState, curState) {
        return (preState.navbar != curState.navbar);
      },
      builder: (context, state) {
        if (state.navbar != null) {
          return Container(
              padding: const EdgeInsets.fromLTRB(0, Dimens.padding_16,
                  0, Dimens.padding_16),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimens.radius_16),
                  topRight: Radius.circular(Dimens.radius_16),
                ),
              ),
              child: SizedBox(
                height: Dimens.margin_40,
                child: ListView.builder(
                  itemCount: state.navbar!.length,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return FaqNavbarTile(
                      navBarData: state.navbar![index],
                      index: index,
                      onNavBarTapped: (int index, NavBarData navBarData,
                          BuildContext context) {
                        context.read<FaqCubit>().updateNavBar(
                            index, navBarData, state.isSelected);
                      },
                    );
                  },),
              )
          );
        } else {
          return const Padding(
            padding: EdgeInsets.all(Dimens.padding_150),
            child: AppCircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget buildFaqList() {
    return BlocBuilder<FaqCubit, FaqState>(
      buildWhen: (preState, curState) {
        return (preState.isSearchFaqLoading !=
            curState.isSearchFaqLoading);
      },
      builder: (context, state) {
        if (state.isSearchFaqLoading ?? true) {
          return const Padding(
            padding: EdgeInsets.all(Dimens.padding_150),
            child: AppCircularProgressIndicator(),
          );
        } else if (!state.faqs!.isNullOrEmpty) {
          return ListView.separated(
            padding: EdgeInsets.zero,
            itemCount: state.faqs!.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, i) {
              return  FaqTile(faqs: state.faqs![i],);
            },
            separatorBuilder: (BuildContext context, int index) {
              return HDivider(dividerColor: Get.theme
                  .getCustomColor(Get.context!)
                  .secondary1200,);
            },
          );
        } else {
          return Padding(
            padding: const EdgeInsets.only(top: Dimens.padding_36),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    'assets/images/ic_no_data_found.svg',
                  ),
                  const SizedBox(height: Dimens.padding_16),
                  Text(
                    'no_faq_available'.tr,
                    style: Get.textTheme.titleMedium?.copyWith(
                        color: Theme
                            .of(context)
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

}
