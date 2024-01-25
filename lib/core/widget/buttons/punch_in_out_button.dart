import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

import '../../data/model/button_state.dart';
import '../theme/theme_manager.dart';

class PunchInOutButton extends StatelessWidget {
  Color? backgroundColor;
  Color? textColor;
  Color? borderColor;
  final String? text;
  final String? svgIcon;
  final Icon? icon;
  final double width;
  final double height;
  final double radius;
  final double textTBPadding;
  final double elevation;
  final VoidCallback? onPressed;
  final double? fontSize;
  final TextStyle? textStyle;
  ButtonState? buttonState;

  PunchInOutButton({super.key,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.text,
    this.svgIcon,
    this.icon,
    this.width = double.infinity,
    this.height = Dimens.btnHeight_48,
    this.radius = Dimens.radius_8,
    this.textTBPadding = Dimens.padding_8,
    this.elevation = 0,
    this.onPressed,
    this.buttonState,
    this.fontSize,
    this.textStyle,
  }) {
    buttonState ??
        BehaviorSubject<ButtonState>.seeded(const ButtonState(isEnable: true));
    backgroundColor ??= Get.theme.colorScheme.onSecondary;
    textColor ??= Get.theme.getCustomColor(Get.context!).secondary1default;
    borderColor ??= Get.theme.colorScheme.onSecondary;
  }

  @override
  Widget build(BuildContext context) {
    String buttonText = text ?? '';
    if ((buttonState?.isLoading ?? false) &&
        buttonState?.message != null) {
      buttonText = buttonState!.message!;
    } else if ((buttonState?.isSuccess ?? false) &&
        buttonState?.message != null) {
      buttonText = buttonState!.message!;
    }
    return SizedBox(
      width: width,
      height: height,
      child: MaterialButton(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: borderColor!),
            borderRadius: BorderRadius.circular(radius),
          ),
          elevation: elevation,
          // splashColor: (buttonState?.isEnable) == false
          //     ? backgroundColor
          //     : Get.theme.colorScheme.primary,
          color: (buttonState == null)
              ? backgroundColor
              : (buttonState!.isEnable ||
              buttonState!.isLoading ||
              buttonState!.isSuccess)
              ? backgroundColor
              : AppColors.backgroundGrey500,
          onPressed: () {
            if (onPressed != null && buttonState == null) {
              onPressed!();
            } else if (onPressed != null &&
                buttonState != null &&
                buttonState!.isEnable &&
                !buttonState!.isLoading &&
                !buttonState!.isSuccess) {
              onPressed!();
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: textTBPadding,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildIcon(),
                      buildLoadingWidget(buttonState),
                      buildSuccessWidget(buttonState),
                      Text(
                        buttonText,
                        overflow: TextOverflow.ellipsis,
                        style: textStyle ??
                            context.textTheme.labelLarge?.copyWith(
                                color: textColor,
                                fontSize: fontSize ?? Dimens.font_20, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
              ),
              buildSvgIcon(),
            ],
          )),
    );
  }

  Widget buildSvgIcon() {
    if (svgIcon != null) {
      return Padding(
        padding: const EdgeInsets.only(right: Dimens.padding_8),
        child: SvgPicture.asset(
          svgIcon!,
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  Widget buildIcon() {
    if (icon != null) {
      return Padding(
        padding: const EdgeInsets.only(right: Dimens.padding_8),
        child: icon,
      );
    } else {
      return const SizedBox();
    }
  }

  Widget buildLoadingWidget(ButtonState? buttonStatus) {
    if (buttonStatus?.isLoading ?? false) {
      return Padding(
        padding: const EdgeInsets.only(right: Dimens.padding_16),
        child: SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            backgroundColor: Get.theme.colorScheme.inversePrimary,
          ),
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  Widget buildSuccessWidget(ButtonState? buttonStatus) {
    if (buttonStatus?.isSuccess ?? false) {
      return const Padding(
        padding: EdgeInsets.only(right: Dimens.padding_16),
        child: Icon(Icons.done, color: AppColors.backgroundWhite),
      );
    } else {
      return const SizedBox();
    }
  }
}
