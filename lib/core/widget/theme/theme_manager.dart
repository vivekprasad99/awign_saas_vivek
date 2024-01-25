import 'package:awign_saas/core/widget/theme/color_schemes.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dimens.dart';
export 'color_schemes.g.dart';
export 'dimens.dart';

class ThemeManager {
  static final appTheme = ThemeData(
    useMaterial3: true,
    colorScheme: AppColors.lightColorScheme,
    textTheme: AppTextThemes.textThemeLight,
    fontFamily: 'inter',
  );

  static final appThemeDark = ThemeData(
    useMaterial3: true,
    colorScheme: AppColors.darkColorScheme,
    textTheme: AppTextThemes.textThemeDark,
    fontFamily: 'inter',
  );

  static const upwardsBoxShadow = BoxShadow(
      color: Color.fromARGB(25, 21, 28, 42),
      spreadRadius: 2,
      blurRadius: 4,
      offset: Offset(0, -2));

  static Brightness? get currentSystemBrightness =>
      SchedulerBinding.instance.window.platformBrightness;

  static setStatusBarAndNavigationBarColors(ThemeMode themeMode) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness:
          themeMode == ThemeMode.light ? Brightness.dark : Brightness.light,
      systemNavigationBarIconBrightness:
          themeMode == ThemeMode.light ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: themeMode == ThemeMode.light
          ? AppColors.backgroundLight
          : AppColors.backgroundDark,
      systemNavigationBarDividerColor: Colors.transparent,
    ));
  }
}

class AppTextThemes {
  static TextTheme textThemeLight = const TextTheme(
    displayLarge: displayLarge,
    displayMedium: displayMedium,
    displaySmall: displaySmall,
    headlineLarge: headlineLarge,
    headlineMedium: headlineMedium,
    headlineSmall: headlineSmall,
    titleLarge: titleLarge,
    titleMedium: titleMedium,
    titleSmall: titleSmall,
    labelLarge: labelLarge,
    labelMedium: labelMedium,
    labelSmall: labelSmall,
    bodyLarge: bodyLarge,
    bodyMedium: bodyMedium,
    bodySmall: bodySmall,
  );

  static TextTheme textThemeDark = const TextTheme(
    displayLarge: displayLargeDark,
    displayMedium: displayMediumDark,
    displaySmall: displaySmallDark,
    headlineLarge: headlineLargeDark,
    headlineMedium: headlineMediumDark,
    headlineSmall: headlineSmallDark,
    titleLarge: titleLargeDark,
    titleMedium: titleMediumDark,
    titleSmall: titleSmallDark,
    labelLarge: labelLargeDark,
    labelMedium: labelMediumDark,
    labelSmall: labelSmallDark,
    bodyLarge: bodyLargeDark,
    bodyMedium: bodyMediumDark,
    bodySmall: bodySmallDark,
  );

  static const displayLarge = TextStyle(
      fontSize: Dimens.font_57, fontWeight: FontWeight.w400, color: AppColors.textColor, letterSpacing: -0.25);
  static const displayMedium = TextStyle(
      fontSize: Dimens.font_45, fontWeight: FontWeight.w400, color: AppColors.textColor);
  static const displaySmall = TextStyle(
      fontSize: Dimens.font_36, fontWeight: FontWeight.w400, color: AppColors.textColor);
  static const headlineLarge = TextStyle(
      fontSize: Dimens.font_32, fontWeight: FontWeight.w400, color: AppColors.textColor);
  static const headlineMedium = TextStyle(
      fontSize: Dimens.font_28, fontWeight: FontWeight.w400, color: AppColors.textColor);
  static const headlineSmall = TextStyle(
      fontSize: Dimens.font_24, fontWeight: FontWeight.w400, color: AppColors.textColor);
  static const titleLarge = TextStyle(
      fontSize: Dimens.font_22, fontWeight: FontWeight.w400, color: AppColors.backgroundGrey900);
  static const titleMedium = TextStyle(
      fontSize: Dimens.font_16, fontWeight: FontWeight.w500, color: AppColors.backgroundGrey900, letterSpacing: 0.15);
  static const titleSmall = TextStyle(
      fontSize: Dimens.font_14, fontWeight: FontWeight.w500, color: AppColors.backgroundGrey900, letterSpacing: 0.1);
  static const labelLarge = TextStyle(
      fontSize: Dimens.font_14, fontWeight: FontWeight.w500, color: AppColors.backgroundGrey800, letterSpacing: 0.1);
  static const labelMedium = TextStyle(
      fontSize: Dimens.font_12, fontWeight: FontWeight.w500, color: AppColors.backgroundGrey800, letterSpacing: 0.5);
  static const labelSmall = TextStyle(
      fontSize: Dimens.font_11, fontWeight: FontWeight.w500, color: AppColors.backgroundGrey800, letterSpacing: 0.5);
  static const bodyLarge = TextStyle(
      fontSize: Dimens.font_16, fontWeight: FontWeight.w400, color: AppColors.textColor, letterSpacing: 0.5);
  static const bodyMedium = TextStyle(
      fontSize: Dimens.font_14, fontWeight: FontWeight.w400, color: AppColors.textColor, letterSpacing: 0.25);
  static const bodySmall = TextStyle(
      fontSize: Dimens.font_12, fontWeight: FontWeight.w400, color: AppColors.textColor);

  static const displayLargeDark = TextStyle(
      fontSize: Dimens.font_57, fontWeight: FontWeight.w400, color: AppColors.textColor, letterSpacing: -0.25);
  static const displayMediumDark = TextStyle(
      fontSize: Dimens.font_45, fontWeight: FontWeight.w400, color: AppColors.textColor);
  static const displaySmallDark = TextStyle(
      fontSize: Dimens.font_36, fontWeight: FontWeight.w400, color: AppColors.textColor);
  static const headlineLargeDark = TextStyle(
      fontSize: Dimens.font_32, fontWeight: FontWeight.w400, color: AppColors.textColor);
  static const headlineMediumDark = TextStyle(
      fontSize: Dimens.font_28, fontWeight: FontWeight.w400, color: AppColors.textColor);
  static const headlineSmallDark = TextStyle(
      fontSize: Dimens.font_24, fontWeight: FontWeight.w400, color: AppColors.textColor);
  static const titleLargeDark = TextStyle(
      fontSize: Dimens.font_22, fontWeight: FontWeight.w400, color: AppColors.textColor);
  static const titleMediumDark = TextStyle(
      fontSize: Dimens.font_16, fontWeight: FontWeight.w500, color: AppColors.textColor, letterSpacing: 0.15);
  static const titleSmallDark = TextStyle(
      fontSize: Dimens.font_14, fontWeight: FontWeight.w500, color: AppColors.textColor, letterSpacing: 0.1);
  static const labelLargeDark = TextStyle(
      fontSize: Dimens.font_14, fontWeight: FontWeight.w500, color: AppColors.textColor, letterSpacing: 0.1);
  static const labelMediumDark = TextStyle(
      fontSize: Dimens.font_12, fontWeight: FontWeight.w500, color: AppColors.textColor, letterSpacing: 0.5);
  static const labelSmallDark = TextStyle(
      fontSize: Dimens.font_11, fontWeight: FontWeight.w500, color: AppColors.textColor, letterSpacing: 0.5);
  static const bodyLargeDark = TextStyle(
      fontSize: Dimens.font_16, fontWeight: FontWeight.w400, color: AppColors.textColor, letterSpacing: 0.5);
  static const bodyMediumDark = TextStyle(
      fontSize: Dimens.font_14, fontWeight: FontWeight.w400, color: AppColors.textColor, letterSpacing: 0.25);
  static const bodySmallDark = TextStyle(
      fontSize: Dimens.font_12, fontWeight: FontWeight.w400, color: AppColors.textColor, );
}

extension TextThemeExtras on TextTheme {
  TextStyle get headline7 => TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w400,
      color: Get.isDarkMode ? AppColors.backgroundWhite : AppColors.textColor);
}

extension ThemeExtras on ThemeData {
  Color get appBarColor => brightness == Brightness.light
      ? Get.theme.colorScheme.primary
      : AppColors.surfaceDark;

  Color get navBarColor => brightness == Brightness.light
      ? AppColors.backgroundWhite
      : AppColors.surfaceDark;

  Color get textFieldBackgroundColor => brightness == Brightness.light
      ? AppColors.backgroundGrey300
      : AppColors.surfaceDark;

  Color get textFieldOutlineColorSecondary => brightness == Brightness.light
      ? AppColors.secondary2Default
      : AppColors.surfaceDark;

  Color get captionSecondaryColor => brightness == Brightness.light
      ? AppColors.secondary2Default
      : AppColors.secondary2Default;

  Color get iconColorNormal => brightness == Brightness.light
      ? AppColors.iconColorNormalLight
      : AppColors.iconColorNormalDark;

  Color get iconColorHighlighted => brightness == Brightness.light
      ? AppColors.iconColorHighlightedLight
      : AppColors.iconColorHighlightedDark;

  Color get buttonSecondaryColor => brightness == Brightness.light
      ? Get.theme.colorScheme.primary
      : AppColors.secondary2Default;

  Color get appDividerColor => brightness == Brightness.light
      ? AppColors.backgroundGrey500
      : AppColors.backgroundWhite;

  Color get toastBackgroundColor => brightness == Brightness.light
      ? AppColors.surfaceDark
      : AppColors.backgroundGrey100;

  Color get toastTextColor => brightness == Brightness.light
      ? AppColors.backgroundWhite
      : AppColors.black;

  Color get inputBoxBackgroundColor => brightness == Brightness.light
      ? AppColors.backgroundGrey300
      : AppColors.surfaceDark;

  Color get inputBoxBorderColor =>
      brightness == Brightness.light ? AppColors.geyser : AppColors.surfaceDark;

  Color get shimmerBaseColor =>
      brightness == Brightness.light ? AppColors.alto : AppColors.alto;

  Color get shimmerHighlightColor =>
      brightness == Brightness.light ? AppColors.concrete : AppColors.concrete;
}
