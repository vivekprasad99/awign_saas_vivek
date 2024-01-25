import 'package:awign_saas/core/data/local/database/user_preferences/user_preferences.dart';
import 'package:awign_saas/core/widget/common/powered_by_widget.dart';
import 'package:awign_saas/core/widget/theme/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../../../core/data/model/ui_state.dart';
import '../../../../../core/router/router.dart';
import '../../../../../core/widget/scaffold/app_scaffold.dart';
import '../cubit/splash_cubit.dart';
import '../cubit/splash_state.dart';

class SplashWidget extends StatelessWidget {
  const SplashWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildSplashForMobile();
  }

  Widget buildSplashForMobile() {
    return BlocConsumer<SplashCubit, SplashState>(
      listener: (context, state) {
        if ((state.isTimerCompleted ?? false) && state.uiState == null) {
          _launchDashboardWidgetOrGenerateToken(context);
        }
      },
      buildWhen: (context, state) {
        return state.uiState?.event == Event.reloadWidget;
      },
      builder: (context, state) {
        return AppScaffold(
          backgroundColor: Get.theme.colorScheme.primary,
          body: Column(
            children: [
              const Spacer(),
              Center(
                child: Image.asset('assets/images/splash_logo_r_talent.png', width: Dimens.imageWidth_150, height: Dimens.imageHeight_40),
              ),
              const Spacer(),
              PoweredByWidget(color: Get.theme.getCustomColor(context).backgroundwhite),
              const SizedBox(height: Dimens.padding_8),
            ],
          ),
        );
      },
    );
  }

  void _launchDashboardWidgetOrGenerateToken(BuildContext context) {
    if(UserPreferences.getInstance().getCurrentUser() != null) {
      MRouter.pushNamedAndRemoveUntil(MRouter.dashboardWidget);
    } else {
      MRouter.pushNamedAndRemoveUntil(MRouter.loginViaMobileWidget);
    }
  }
}
