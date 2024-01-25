import 'package:awign_saas/core/widget/app_bar/default_app_bar.dart';
import 'package:awign_saas/core/widget/network_sensitive/internet_sensitive.dart';
import 'package:awign_saas/core/widget/scaffold/app_scaffold.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../../core/data/model/ui_state.dart';
import '../../../../../core/router/router.dart';
import '../../../../../core/utils/browser_helper.dart';
import '../../../../../core/utils/helper.dart';
import '../../../../../core/widget/buttons/raised_rect_button.dart';
import '../../../../../core/widget/common/form_label_widget.dart';
import '../../../../../core/widget/common/form_text_field.dart';
import '../../../../../core/widget/theme/theme_manager.dart';
import '../../common_widget/auth_header.dart';
import '../../otp_verification_widget/data/otp_verification_argument.dart';
import '../cubit/login_via_number_cubit.dart';
import '../cubit/login_via_number_state.dart';

class LoginViaNumberWidget extends StatelessWidget {
  const LoginViaNumberWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildWidgetsForMobile();
  }

  Widget buildWidgetsForMobile() {
    return BlocConsumer<LoginViaNumberCubit, LoginViaNumberState>(
      listenWhen: (previous, current) {
        return previous.uiState != current.uiState;
      },
      listener: (context, state) {
        if (state.uiState?.event == Event.otpSent &&
            state.uiState?.data is OTPVerificationArgument) {
          _launchOTPVerificationWidget(state.uiState?.data);
        } else if(state.uiState != null && state.uiState!.failedWithoutAlertMessage.isNotEmpty) {
          Helper.showErrorToast(state.uiState!.failedWithoutAlertMessage);
        }
      },
      buildWhen: (context, state) {
        return state.uiState?.event == Event.reloadWidget;
      },
      builder: (context, state) {
        return AppScaffold(
          body: SafeArea(
            child: Column(
              children: [
                DefaultAppBar(),
                Expanded(
                  child: InternetSensitive(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Dimens.padding_16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const AuthHeader(),
                            const SizedBox(height: Dimens.padding_64),
                            FormLabelWidget(labelText: 'mobile_number'.tr),
                            const SizedBox(height: Dimens.padding_8),
                            buildMobileNumberTextFieldWidget(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                buildSendOTPButton(),
                buildPrivacyPolicyWidget(context),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildMobileNumberTextFieldWidget() {
    return BlocBuilder<LoginViaNumberCubit, LoginViaNumberState>(
      buildWhen: (previousState, state) {
        if ((previousState.mobileNumberError == null &&
                state.mobileNumberError != null) ||
            (previousState.mobileNumberError != null &&
                state.mobileNumberError == null)) {
          return true;
        } else {
          return false;
        }
      },
      builder: (context, state) {
        return FormTextField(
          onChanged: context.read<LoginViaNumberCubit>().updateMobileNumber,
          keyboardType: TextInputType.phone,
          maxLines: 1,
          textInputAction: TextInputAction.done,
          hintText: 'enter_mobile_number'.tr,
          errorText: state.mobileNumberError,
          prefixIcon: Padding(padding: const EdgeInsets.fromLTRB(Dimens.padding_16, Dimens.padding_16, Dimens.padding_4, Dimens.padding_16), child: Text('+91'.tr, style: Get.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500))),
        );
      },
    );
  }

  Widget buildSendOTPButton() {
    return BlocBuilder<LoginViaNumberCubit, LoginViaNumberState>(
      buildWhen: (previousState, state) {
        return previousState.buttonState != state.buttonState;
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(
              Dimens.padding_16, Dimens.padding_16, Dimens.padding_16, 0),
          child: RaisedRectButton(
            buttonState: state.buttonState,
            text: 'send_otp'.tr,
            onPressed: () async {
              Helper.hideKeyBoard(context);
              context.read<LoginViaNumberCubit>().sendOTP();
            },
          ),
        );
      },
    );
  }

  void _launchOTPVerificationWidget(
      OTPVerificationArgument otpVerificationArgument) {
    MRouter.pushNamed(MRouter.otpVerificationWidget,
        arguments: otpVerificationArgument);
  }

  Widget buildPrivacyPolicyWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimens.padding_16),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: Get.textTheme.labelLarge,
          children: <TextSpan>[
            TextSpan(
              text: 'by_continuing_you_agree_to_our'.tr,
            ),
            TextSpan(
              text: ' ${'privacy_policy'.tr}',
              style: Get.textTheme.labelLarge
                  ?.copyWith(color: Get.theme.primaryColor),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  BrowserHelper.customTab(
                      context, "https://www.awign.com/privacy_policy");
                },
            ),
            TextSpan(
              text: ' ${'and'.tr}',
            ),
            TextSpan(
              text: ' ${'terms_and_conditions'.tr}',
              style: Get.textTheme.labelLarge
                  ?.copyWith(color: Get.theme.primaryColor),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  BrowserHelper.customTab(
                      context, "https://www.awign.com/terms_and_conditions");
                },
            ),
          ],
        ),
      ),
    );
  }
}
