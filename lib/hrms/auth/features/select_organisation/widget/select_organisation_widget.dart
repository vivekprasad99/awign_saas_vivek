import 'package:awign_saas/core/extension/common_extension.dart';
import 'package:awign_saas/core/widget/theme/theme_manager.dart';
import 'package:awign_saas/hrms/auth/data/model/user_response.dart';
import 'package:awign_saas/hrms/auth/features/select_organisation/cubit/select_organisation_cubit.dart';
import 'package:awign_saas/hrms/auth/features/select_organisation/cubit/select_organisation_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../core/data/local/database/model/current_user/tenant.dart';
import '../../../../../core/data/model/ui_state.dart';
import '../../../../../core/router/router.dart';
import '../../../../../core/widget/app_bar/default_app_bar.dart';
import '../../../../../core/widget/buttons/raised_rect_button.dart';
import '../../../../../core/widget/network_sensitive/internet_sensitive.dart';
import '../../../../../core/widget/scaffold/app_scaffold.dart';
import 'tile/organisation_tile.dart';

class SelectOrganisationWidget extends StatelessWidget {
  final UserResponse userResponse;
  const SelectOrganisationWidget(this.userResponse, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<SelectOrganisationCubit>().updateUserDetails(userResponse);
    return buildWidgetsForMobile();
  }

  Widget buildWidgetsForMobile() {
    return BlocConsumer<SelectOrganisationCubit, SelectOrganisationState>(
      listenWhen: (previous, current) {
        return previous.uiState != current.uiState;
      },
      listener: (context, state) {
        if(state.uiState?.event == Event.verified) {
          MRouter.pushNamedAndRemoveUntil(MRouter.dashboardWidget);
        }
      },
      buildWhen: (prev, cur) {
        return cur.uiState?.event == Event.reloadWidget;
      },
      builder: (context, state) {
        return AppScaffold(
          body: SafeArea(
            child: Column(
              children: [
                DefaultAppBar(
                    isBackIconVisible: true,
                    title: 'select_organisation'.tr),
                Expanded(
                  child: InternetSensitive(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildOrganisationList(),
                        buildContinueButton(),
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


  Widget buildOrganisationList() {
    return BlocBuilder<SelectOrganisationCubit, SelectOrganisationState>(
      buildWhen: (prev, cur) {
        return prev.uiState != cur.uiState;
      },
      builder: (context, state) {
        if(!state.tenants.isNullOrEmpty) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimens.padding_16),
              child: ListView.separated(
                itemCount: state.tenants!.length,
                padding: const EdgeInsets.symmetric(vertical: Dimens.padding_16),
                itemBuilder: (context, i) {
                  return OrganisationTile(index: i, tenant: state.tenants![i], onTenantTap: onTenantTap);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: Dimens.padding_12);
                },
              ),
            ),
          );
        } else {
          return buildEmptyWidgets(context);
        }
      },
    );
  }

  onTenantTap(BuildContext context, int index, Tenant tenant) async {
    context.read<SelectOrganisationCubit>().updateTenantList(index, tenant);
  }

  Widget buildEmptyWidgets(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: Dimens.padding_36),
      child: Center(
        child: Column(
          children: [
            SvgPicture.asset(
              'assets/images/ic_no_data_found.svg',
            ),
            const SizedBox(height: Dimens.padding_16),
            Text('organisation_not_available'.tr, style: Get.textTheme.titleMedium?.copyWith(color:
            Theme.of(context).getCustomColor(context).secondary1300, fontSize: Dimens.font_18),),
          ],
        ),
      ),
    );
  }

  Widget buildContinueButton() {
    return BlocBuilder<SelectOrganisationCubit, SelectOrganisationState>(
      buildWhen: (previousState, state) {
        return previousState.buttonState != state.buttonState;
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(Dimens.padding_16),
          child: RaisedRectButton(
            buttonState: state.buttonState,
            text: 'continue'.tr,
            onPressed: () {
              context.read<SelectOrganisationCubit>().getAuthTokenByTenantID();
            },
          ),
        );
      },
    );
  }
}
