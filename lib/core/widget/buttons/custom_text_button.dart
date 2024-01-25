import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme/theme_manager.dart';

class CustomTextButton extends StatelessWidget {
  Color? backgroundColor;
  Color? textColor;
  Color? borderColor;
  Color? splashColor;
  final String? text;
  final String? svgIcon;
  final double width;
  final double height;
  final double radius;
  final double textTBPadding;
  final double elevation;
  final double? fontSize;
  final TextStyle? textStyle;
  final VoidCallback? onPressed;

  CustomTextButton({
    Key? key,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.splashColor,
    this.text,
    this.svgIcon,
    this.width = double.infinity,
    this.height = Dimens.btnHeight_48,
    this.radius = Dimens.radius_8,
    this.textTBPadding = Dimens.padding_8,
    this.elevation = 0,
    this.fontSize,
    this.textStyle,
    this.onPressed,
  }) : super(key: key) {
    backgroundColor ??= Get.theme.colorScheme.primary;
    textColor ??= Get.theme.colorScheme.primary;
    borderColor ??= AppColors.transparent;
    splashColor ??= Get.theme.getCustomColor(Get.context!).primarymain;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: borderColor!),
          borderRadius: BorderRadius.circular(radius),
        ),
        splashColor: splashColor,
        color: backgroundColor,
        elevation: elevation,
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: textTBPadding,
              ),
              child: Row(
                children: [
                  Text(
                    text ?? "",
                    style: textStyle ??
                        context.textTheme.labelLarge?.copyWith(
                            color: textColor,
                            fontSize: fontSize ?? Dimens.font_14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
