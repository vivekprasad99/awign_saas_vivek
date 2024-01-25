import 'dart:async';

import 'package:awign_saas/core/router/router.dart';
import 'package:awign_saas/core/widget/network_sensitive/internet_sensitive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../../../core/data/model/ui_state.dart';
import '../../../../../core/utils/helper.dart';
import '../../../../../core/widget/app_bar/default_app_bar.dart';
import '../../../../../core/widget/buttons/my_ink_well.dart';
import '../../../../../core/widget/buttons/raised_rect_button.dart';
import '../../../../../core/widget/scaffold/app_scaffold.dart';
import '../../../../../core/widget/theme/theme_manager.dart';
import '../../common_widget/auth_header.dart';
import '../cubit/otp_verification_cubit.dart';
import '../cubit/otp_verification_state.dart';
import '../data/otp_verification_argument.dart';

class OTPVerificationWidget extends StatefulWidget {
  final OTPVerificationArgument otpVerificationArgument;
  const OTPVerificationWidget(this.otpVerificationArgument, {Key? key}) : super(key: key);

  @override
  State<OTPVerificationWidget> createState() => _OTPVerificationWidgetState();
}

class _OTPVerificationWidgetState extends State<OTPVerificationWidget> {
  final TextEditingController _otpController = TextEditingController();

  final StreamController<ErrorAnimationType> _errorController =
  StreamController<ErrorAnimationType>();

  @override
  void dispose() {
    _errorController.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    context.read<OtpVerificationCubit>().showResendOTPTimer(widget.otpVerificationArgument);
  }

  @override
  Widget build(BuildContext context) {
    return buildWidgetsForMobile();
  }

  Widget buildWidgetsForMobile() {
    return BlocConsumer<OtpVerificationCubit, OTPVerificationState>(
      listenWhen: (previousState, state) {
        return previousState.uiState != state.uiState;
      },
      listener: (context, state) {
        if(state.uiState?.event == Event.success) {
          MRouter.pushNamed(MRouter.selectOrganisationWidget, arguments: state.userResponse);
        } else if(state.uiState?.event == Event.verified) {
          MRouter.pushNamedAndRemoveUntil(MRouter.dashboardWidget);
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
                DefaultAppBar(isBackIconVisible: true),
                Expanded(
                  child: InternetSensitive(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: Dimens.padding_16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const AuthHeader(),
                            const SizedBox(height: Dimens.padding_64),
                            buildOTPLabelWidget(),
                            buildEmailWidget(),
                            const SizedBox(height: Dimens.padding_16),
                            buildOTPTextField(context),
                            buildOTPMessageText(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                buildSubmitButton(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildOTPLabelWidget() {
    return Text('enter_otp_sent_to_this_mobile_number'.tr, style: Get.textTheme.labelLarge);
  }

  Widget buildEmailWidget() {
    return Text(widget.otpVerificationArgument.mobileNumber, style: Get.textTheme.labelMedium);
  }

  Widget buildOTPTextField(BuildContext context) {
    return PinCodeTextField(
      appContext: context,
      length: 5,
      obscureText: false,
      animationType: AnimationType.fade,
      pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderWidth: Dimens.border_1,
          borderRadius: BorderRadius.circular(Dimens.radius_4),
          fieldHeight: Dimens.imageHeight_48,
          fieldWidth: Dimens.imageHeight_48,
          activeFillColor: AppColors.backgroundGrey400,
          activeColor: AppColors.backgroundGrey400,
          inactiveColor: AppColors.backgroundGrey400,
          inactiveFillColor: AppColors.backgroundGrey400,
          selectedColor: Get.theme.colorScheme.primary,
          selectedFillColor: AppColors.backgroundGrey400),
      keyboardType: TextInputType.number,
      animationDuration: const Duration(milliseconds: 300),
      enableActiveFill: true,
      onCompleted: (v) {},
      onChanged: context.read<OtpVerificationCubit>().updateOTP,
      beforeTextPaste: (text) {
        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
        //but you can show anything you want here, like your pop up saying wrong paste format or etc
        return true;
      },
    );
  }

  Widget buildOTPMessageText() {
    return BlocBuilder<OtpVerificationCubit, OTPVerificationState>(
      buildWhen: (previousState, state) {
        return (previousState.isShowTimer != state.isShowTimer || previousState.isShowResendButton != state.isShowResendButton
        || previousState.timerText != state.timerText || previousState.isShowResendOTPLoading != state.isShowResendOTPLoading);
      },
        builder: (context, state) {
          if(state.isShowTimer ?? false) {
            return buildTimerText(state.timerText ?? '');
          } else if(state.isShowResendButton ?? false) {
            return Column(
              children: [
                buildResendOTPText(),
              ],
            );
          } else if (state.isShowResendOTPLoading ?? false) {
            return const Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(top: Dimens.padding_8),
                child: SizedBox(width: Dimens.circularProgressIndicatorWidth_16,
                    height: Dimens.circularProgressIndicatorHeight_16, child: CircularProgressIndicator()),
              ),
            );
          } else {
            return const SizedBox();
          }
        });
  }

  Widget buildTimerText(String timerText) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
            Dimens.padding_16, Dimens.padding_8, 0, 0),
        child: RichText(
          textAlign: TextAlign.right,
          text: TextSpan(
            style: Get.textTheme.labelLarge,
            children: <TextSpan>[
              TextSpan(
                text: 'resend_otp_in'.tr,
                style: Get.textTheme.labelLarge?.copyWith(color: AppColors.backgroundGrey500),
              ),
              TextSpan(
                text: ' $timerText',
                style: Get.textTheme.labelLarge?.copyWith(color: AppColors.backgroundBlack),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildResendOTPText() {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
            Dimens.padding_16, Dimens.padding_8, 0, 0),
        child: MyInkWell(
          onTap: () {
            context.read<OtpVerificationCubit>().sendOTP();
          },
          child: Text(
            'resend_otp'.tr,
            style: Get.context?.textTheme.labelMedium?.copyWith(
              color: Get.theme.colorScheme.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSubmitButton() {
    return BlocBuilder<OtpVerificationCubit, OTPVerificationState>(
      buildWhen: (previousState, state) {
        return previousState.buttonState != state.buttonState;
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(Dimens.padding_16),
          child: RaisedRectButton(
            buttonState: state.buttonState,
            text: 'submit'.tr,
            onPressed: () {
              context.read<OtpVerificationCubit>().validateOTP();
            },
          ),
        );
      },
    );
  }
}
