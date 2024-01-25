import 'package:flutter/material.dart';

class AppColors {
  static const primaryMain = Color(0xFF113DBC);
  static const primary50 = Color(0xFFECF1FD);
  static const primary100 = Color(0xFFDCE1FA);
  static const primary200 = Color(0xFFB7C3F4);
  static const primary300 = Color(0xFF5F7CE7);
  static const primary500 = Color(0xFF182F8F);
  static const primary600 = Color(0xFF11236C);
  static const primary700 = Color(0xFF0B1848);
  static const primary800 = Color(0xFF081236);
  static const primary900 = Color(0xFF030612);

  static const secondary1100 = Color(0xFFEFECFC);
  static const secondary1200 = Color(0xFFD1C7F6);
  static const secondary1300 = Color(0xFF937DEC);
  static const secondary1Default = Color(0xFF3A11BC);

  static const secondary2100 = Color(0xFFEEF9FC);
  static const secondary2200 = Color(0xFFCFEDF8);
  static const secondary2300 = Color(0xFF92D5F0);
  static const secondary2400 = Color(0xFF59B8E5);
  static const secondary2Default = Color(0xFF1193BC);

  static const success100 = Color(0xFFE3FEEF);
  static const success200 = Color(0xFF6FECA4);
  static const success300 = Color(0xFF28C269);
  static const success400 = Color(0xFF1F9A53);
  static const success500 = Color(0xFF115A30);

  static const link100 = Color(0xFFE1F2FF);
  static const link200 = Color(0xFF88CCFF);
  static const link300 = Color(0xFF2EA5FF);
  static const link400 = Color(0xFF028EF8);
  static const link500 = Color(0xFF0271C5);

  static const warning100 = Color(0xFFFFFAEB);
  static const warning200 = Color(0xFFFEF0C7);
  static const warning300 = Color(0xFFF79009);
  static const warning400 = Color(0xFFDC6803);
  static const warning500 = Color(0xFFB54708);
  static const warning250 = Color(0xFFF9A63A);
  static const yellow = Color(0xFFFFC82C);

  static const error100 = Color(0xFFFFEDED);
  static const error200 = Color(0xFFFFAEAE);
  static const error300 = Color(0xFFFE4141);
  static const error400 = Color(0xFFEA0000);
  static const error500 = Color(0xFFAC0101);

  static const backgroundWhite = Color(0xFFFFFFFF);
  static const backgroundGrey100 = Color(0xffF6FAFB);
  static const backgroundGrey200 = Color(0xffF4F9FA);
  static const backgroundGrey300 = Color(0xFFECF3F5);
  static const backgroundGrey400 = Color(0xffD9E9ED);
  static const backgroundGrey500 = Color(0xFFAABFC3);
  static const backgroundGrey600 = Color(0xff9CAFB1);
  static const backgroundGrey700 = Color(0xff8FA3A5);
  static const backgroundGrey800 = Color(0xff606A7B);
  static const backgroundGrey900 = Color(0xFF3C4858);
  static const geyser = Color(0xFFdae0e5);

  static const grey = Color(0xFFF5F5F8);

  static const backgroundBlack = Color(0xFF1F2D3D);

  static const overlay = Color(0xBF1F2D3D);
  static const black = Color(0xFF000000);
  static const transparent = Color(0xFFFFFF);
  static const textColor = backgroundBlack;

  static const secondary = primaryMain;

  static const backgroundLight = backgroundGrey100;
  static const backgroundDark = Color(0xFF1F2B2D);

  static const surfaceDark = Color(0xFF0E272D);

  static const pine = Color(0xff49be91);
  static const pattensBlue = Color(0xffdee2e4);
  static const orange = Color(0xfff8843b);
  static const alto = Color(0xffDDDDDD);
  static const concrete = Color(0xfff3f3f3);
  static const abyssalAnchorfishBlue = Color(0xff18212F);
  static const skirretGreen = Color(0xff45ba43);

  static const iconColorNormalLight = backgroundGrey600;
  static const iconColorNormalDark = backgroundGrey300;

  static const iconColorHighlightedLight = primaryMain;
  static const iconColorHighlightedDark = backgroundWhite;

  static const facebookBlue = Color(0xFF3A559F);
  static const googleRed = Color(0xFFDC4E41);
  static const backgroundPink = Color(0xFFFFD7CD);
  static const backgroundDarkPink = Color(0xFFD37E69);
  static const leiFlower = Color(0xFFD87767);
  static const mediumPurple = Color(0xFF7D6FDA);
  static const barcelonaBrown = Color(0xFF916947);
  static const darkOliveGreen = Color(0xFF58692E);
  static const blueDahlia = Color(0xFF4255A1);
  static const blueBirdDay  = Color(0xFF217AAB);
  static const blueStreak  = Color(0xFF2157B7);
  static const compOffGreen  = Color(0xFF3CB950);
  static const taskFulfilmentText  = Color(0xFF395580);

  static const lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF634CB8),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFEFEBFC),
    onPrimaryContainer: Color(0xFF1E0061),
    secondary: Color(0xFF605B71),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFE6DFF9),
    onSecondaryContainer: Color(0xFF1D192B),
    tertiary: Color(0xFF875200),
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFFFFDDBA),
    onTertiaryContainer: Color(0xFF2B1700),
    error: Color(0xFFEA6666),
    errorContainer: Color(0xFFFFDAD6),
    onError: Color(0xFFFFFFFF),
    onErrorContainer: Color(0xFF410002),
    background: Color(0xFFFFFBFF),
    onBackground: Color(0xFF1C1B1E),
    surface: Color(0xFFFFFBFF),
    onSurface: Color(0xFF1C1B1E),
    surfaceVariant: Color(0xFFE6E0EC),
    onSurfaceVariant: Color(0xFF48454E),
    outline: Color(0xFF79757F),
    onInverseSurface: Color(0xFFF4EFF4),
    inverseSurface: Color(0xFF313033),
    inversePrimary: Color(0xFFCBBEFF),
    shadow: Color(0xFF000000),
    surfaceTint: Color(0xFF634CB8),
    outlineVariant: Color(0xFFCAC4CF),
    scrim: Color(0xFF000000),
  );

  static const darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFFCBBEFF),
    onPrimary: Color(0xFF331488),
    primaryContainer: Color(0xFF4A329E),
    onPrimaryContainer: Color(0xFFE7DEFF),
    secondary: Color(0xFFCAC3DC),
    onSecondary: Color(0xFF322E41),
    secondaryContainer: Color(0xFF484458),
    onSecondaryContainer: Color(0xFFE6DFF9),
    tertiary: Color(0xFFFFB865),
    onTertiary: Color(0xFF482900),
    tertiaryContainer: Color(0xFF673D00),
    onTertiaryContainer: Color(0xFFFFDDBA),
    error: Color(0xFFFFB4AB),
    errorContainer: Color(0xFF93000A),
    onError: Color(0xFF690005),
    onErrorContainer: Color(0xFFFFDAD6),
    background: Color(0xFF1C1B1E),
    onBackground: Color(0xFFE6E1E6),
    surface: Color(0xFF1C1B1E),
    onSurface: Color(0xFFE6E1E6),
    surfaceVariant: Color(0xFF48454E),
    onSurfaceVariant: Color(0xFFCAC4CF),
    outline: Color(0xFF938F99),
    onInverseSurface: Color(0xFF1C1B1E),
    inverseSurface: Color(0xFFE6E1E6),
    inversePrimary: Color(0xFF634CB8),
    shadow: Color(0xFF000000),
    surfaceTint: Color(0xFFCBBEFF),
    outlineVariant: Color(0xFF48454E),
    scrim: Color(0xFF000000),
  );

  /// Don't use source color
  static const CustomColors lightCustomColors = CustomColors(
    sourcePrimarymain: Color(0xFF113DBC),
    primarymain: Color(0xFF113DBC),
    onPrimarymain: Color(0xFFFFFFFF),
    primarymainContainer: Color(0xFFDDE1FF),
    onPrimarymainContainer: Color(0xFF001454),
    sourcePrimary50: Color(0xFFECF1FD),
    primary50: Color(0xFFECF1FD),
    onPrimary50: Color(0xFFFFFFFF),
    primary50Container: Color(0xFFD3E4FF),
    onPrimary50Container: Color(0xFF001C38),
    sourcePrimary100: Color(0xFFDCE1FA),
    primary100: Color(0xFFDCE1FA),
    onPrimary100: Color(0xFFFFFFFF),
    primary100Container: Color(0xFFDBE1FF),
    onPrimary100Container: Color(0xFF00174A),
    sourcePrimary200: Color(0xFFB7C3F4),
    primary200: Color(0xFFB7C3F4),
    onPrimary200: Color(0xFFFFFFFF),
    primary200Container: Color(0xFFDCE1FF),
    onPrimary200Container: Color(0xFF00164E),
    sourcePrimary300: Color(0xFF5F7CE7),
    primary300: Color(0xFF5F7CE7),
    onPrimary300: Color(0xFFFFFFFF),
    primary300Container: Color(0xFFDCE1FF),
    onPrimary300Container: Color(0xFF001551),
    sourcePrimary500: Color(0xFF182F8F),
    primary500: Color(0xFF182F8F),
    onPrimary500: Color(0xFFFFFFFF),
    primary500Container: Color(0xFFDEE1FF),
    onPrimary500Container: Color(0xFF001258),
    sourcePrimary600: Color(0xFF11236C),
    primary600: Color(0xFF11236C),
    onPrimary600: Color(0xFFFFFFFF),
    primary600Container: Color(0xFFDDE1FF),
    onPrimary600Container: Color(0xFF001257),
    sourcePrimary700: Color(0xFF0B1848),
    primary700: Color(0xFF0B1848),
    onPrimary700: Color(0xFFFFFFFF),
    primary700Container: Color(0xFFDDE1FF),
    onPrimary700Container: Color(0xFF001354),
    sourcePrimary800: Color(0xFF081236),
    primary800: Color(0xFF081236),
    onPrimary800: Color(0xFFFFFFFF),
    primary800Container: Color(0xFFDDE1FF),
    onPrimary800Container: Color(0xFF001453),
    sourcePrimary900: Color(0xFF030612),
    primary900: Color(0xFF030612),
    onPrimary900: Color(0xFFFFFFFF),
    primary900Container: Color(0xFFDAE2FF),
    onPrimary900Container: Color(0xFF001849),
    sourceSecondary1100: Color(0xFFEFECFC),
    secondary1100: Color(0xFFEFECFC),
    onSecondary1100: Color(0xFFFFFFFF),
    secondary1100Container: Color(0xFFE1DFFF),
    onSecondary1100Container: Color(0xFF0C0664),
    sourceSecondary1200: Color(0xFFD1C7F6),
    secondary1200: Color(0xFFD1C7F6),
    onSecondary1200: Color(0xFFFFFFFF),
    secondary1200Container: Color(0xFFE6DEFF),
    onSecondary1200Container: Color(0xFF1D0160),
    sourceSecondary1300: Color(0xFF937DEC),
    secondary1300: Color(0xFF937DEC),
    onSecondary1300: Color(0xFFFFFFFF),
    secondary1300Container: Color(0xFFE7DEFF),
    onSecondary1300Container: Color(0xFF1E0061),
    sourceSecondary1default: Color(0xFF3A11BC),
    secondary1default: Color(0xFF3A11BC),
    onSecondary1default: Color(0xFFFFFFFF),
    secondary1defaultContainer: Color(0xFFE5DEFF),
    onSecondary1defaultContainer: Color(0xFF190064),
    sourceSecondary2100: Color(0xFFEEF9FC),
    secondary2100: Color(0xFFEEF9FC),
    onSecondary2100: Color(0xFFFFFFFF),
    secondary2100Container: Color(0xFFA4EEFF),
    onSecondary2100Container: Color(0xFF001F25),
    sourceSecondary2200: Color(0xFFCFEDF8),
    secondary2200: Color(0xFFCFEDF8),
    onSecondary2200: Color(0xFFFFFFFF),
    secondary2200Container: Color(0xFFB2EBFF),
    onSecondary2200Container: Color(0xFF001F27),
    sourceSecondary2300: Color(0xFF92D5F0),
    secondary2300: Color(0xFF92D5F0),
    onSecondary2300: Color(0xFFFFFFFF),
    secondary2300Container: Color(0xFFB9EAFF),
    onSecondary2300Container: Color(0xFF001F29),
    sourceSecondary2400: Color(0xFF59B8E5),
    secondary2400: Color(0xFF59B8E5),
    onSecondary2400: Color(0xFFFFFFFF),
    secondary2400Container: Color(0xFFC2E8FF),
    onSecondary2400Container: Color(0xFF001E2B),
    sourceSecondary2default: Color(0xFF1193BC),
    secondary2default: Color(0xFF1193BC),
    onSecondary2default: Color(0xFFFFFFFF),
    secondary2defaultContainer: Color(0xFFBEE9FF),
    onSecondary2defaultContainer: Color(0xFF001F2A),
    sourceSuccess100: Color(0xFFE3FEEF),
    success100: Color(0xFFE3FEEF),
    onSuccess100: Color(0xFFFFFFFF),
    success100Container: Color(0xFF86F8CB),
    onSuccess100Container: Color(0xFF002116),
    sourceSuccess200: Color(0xFF6FECA4),
    success200: Color(0xFF6FECA4),
    onSuccess200: Color(0xFFFFFFFF),
    success200Container: Color(0xFF7EFBB1),
    onSuccess200Container: Color(0xFF002110),
    sourceSuccess300: Color(0xFF28C269),
    success300: Color(0xFF28C269),
    onSuccess300: Color(0xFFFFFFFF),
    success300Container: Color(0xFF70FD9D),
    onSuccess300Container: Color(0xFF00210C),
    sourceSuccess400: Color(0xFF1F9A53),
    success400: Color(0xFF1F9A53),
    onSuccess400: Color(0xFFFFFFFF),
    success400Container: Color(0xFF88FAA7),
    onSuccess400Container: Color(0xFF00210C),
    sourceSuccess500: Color(0xFF115A30),
    success500: Color(0xFF115A30),
    onSuccess500: Color(0xFFFFFFFF),
    success500Container: Color(0xFF9BF6B2),
    onSuccess500Container: Color(0xFF00210D),
    sourceLink100: Color(0xFFE1F2FF),
    link100: Color(0xFFE1F2FF),
    onLink100: Color(0xFFFFFFFF),
    link100Container: Color(0xFFC4E7FF),
    onLink100Container: Color(0xFF001E2D),
    sourceLink200: Color(0xFF88CCFF),
    link200: Color(0xFF88CCFF),
    onLink200: Color(0xFFFFFFFF),
    link200Container: Color(0xFFCAE6FF),
    onLink200Container: Color(0xFF001E2F),
    sourceLink300: Color(0xFF2EA5FF),
    link300: Color(0xFF2EA5FF),
    onLink300: Color(0xFFFFFFFF),
    link300Container: Color(0xFFD0E4FF),
    onLink300Container: Color(0xFF001D34),
    sourceLink400: Color(0xFF028EF8),
    link400: Color(0xFF028EF8),
    onLink400: Color(0xFFFFFFFF),
    link400Container: Color(0xFFD3E3FF),
    onLink400Container: Color(0xFF001C39),
    sourceLink500: Color(0xFF0271C5),
    link500: Color(0xFF0271C5),
    onLink500: Color(0xFFFFFFFF),
    link500Container: Color(0xFFD3E4FF),
    onLink500Container: Color(0xFF001C38),
    sourceWarning100: Color(0xFFFFFAEB),
    warning100: Color(0xFFFFFAEB),
    onWarning100: Color(0xFFFFFFFF),
    warning100Container: Color(0xFFF1E66A),
    onWarning100Container: Color(0xFF1F1C00),
    sourceWarning200: Color(0xFFFEF0C7),
    warning200: Color(0xFFFEF0C7),
    onWarning200: Color(0xFFFFFFFF),
    warning200Container: Color(0xFFFFE170),
    onWarning200Container: Color(0xFF221B00),
    sourceWarning300: Color(0xFFF79009),
    warning300: Color(0xFFF79009),
    onWarning300: Color(0xFFFFFFFF),
    warning300Container: Color(0xFFFFDCC0),
    onWarning300Container: Color(0xFF2D1600),
    sourceWarning400: Color(0xFFDC6803),
    warning400: Color(0xFFDC6803),
    onWarning400: Color(0xFFFFFFFF),
    warning400Container: Color(0xFFFFDBC9),
    onWarning400Container: Color(0xFF321200),
    sourceWarning500: Color(0xFFB54708),
    warning500: Color(0xFFB54708),
    onWarning500: Color(0xFFFFFFFF),
    warning500Container: Color(0xFFFFDBCD),
    onWarning500Container: Color(0xFF360F00),
    sourceWarning250: Color(0xFFF9A63A),
    warning250: Color(0xFFF9A63A),
    onWarning250: Color(0xFFFFFFFF),
    warning250Container: Color(0xFFFFDDBA),
    onWarning250Container: Color(0xFF2B1700),
    sourceYellow: Color(0xFFFFC82C),
    yellow: Color(0xFFFC82C),
    onYellow: Color(0xFFFFFFFF),
    yellowContainer: Color(0xFFFFDF98),
    onYellowContainer: Color(0xFF251A00),
    sourceError100: Color(0xFFFFEDED),
    error100: Color(0xFFFFEDED),
    onError100: Color(0xFFFFFFFF),
    error100Container: Color(0xFFFFDADB),
    onError100Container: Color(0xFF40000E),
    sourceError200: Color(0xFFFFAEAE),
    error200: Color(0xFFFFAEAE),
    onError200: Color(0xFFFFFFFF),
    error200Container: Color(0xFFFFDAD9),
    onError200Container: Color(0xFF400009),
    sourceError300: Color(0xFFFE4141),
    error300: Color(0xFFFE4141),
    onError300: Color(0xFFFFFFFF),
    error300Container: Color(0xFFFFDAD6),
    onError300Container: Color(0xFF410003),
    sourceError400: Color(0xFFEA0000),
    error400: Color(0xFFEA0000),
    onError400: Color(0xFFFFFFFF),
    error400Container: Color(0xFFFFDAD4),
    onError400Container: Color(0xFF410000),
    sourceError500: Color(0xFFAC0101),
    error500: Color(0xFFAC0101),
    onError500: Color(0xFFFFFFFF),
    error500Container: Color(0xFFFFDAD4),
    onError500Container: Color(0xFF410000),
    sourceBackgroundwhite: Color(0xFFFFFFFF),
    backgroundwhite: Color(0xFFFFFFFF),
    onBackgroundwhite: Color(0xFFFFFFFF),
    backgroundwhiteContainer: Color(0xFF97F0FF),
    onBackgroundwhiteContainer: Color(0xFF001F24),
    sourceBackgroundgrey100: Color(0xFFF6FAFB),
    backgroundgrey100: Color(0xFFF6FAFB),
    onBackgroundgrey100: Color(0xFFFFFFFF),
    backgroundgrey100Container: Color(0xFF9EEFFF),
    onBackgroundgrey100Container: Color(0xFF001F24),
    sourceBackgroundgrey200: Color(0xFFF4F9FA),
    backgroundgrey200: Color(0xFFF4F9FA),
    onBackgroundgrey200: Color(0xFFFFFFFF),
    backgroundgrey200Container: Color(0xFF99F0FF),
    onBackgroundgrey200Container: Color(0xFF001F24),
    sourceBackgroundgrey300: Color(0xFFECF3F5),
    backgroundgrey300: Color(0xFFECF3F5),
    onBackgroundgrey300: Color(0xFFFFFFFF),
    backgroundgrey300Container: Color(0xFFA3EEFF),
    onBackgroundgrey300Container: Color(0xFF001F25),
    sourceBackgroundgrey400: Color(0xFFD9E9ED),
    backgroundgrey400: Color(0xFFD9E9ED),
    onBackgroundgrey400: Color(0xFFFFFFFF),
    backgroundgrey400Container: Color(0xFFA2EEFF),
    onBackgroundgrey400Container: Color(0xFF001F25),
    sourceBackgroundgrey500: Color(0xFFAABFC3),
    backgroundgrey500: Color(0xFFAABFC3),
    onBackgroundgrey500: Color(0xFFFFFFFF),
    backgroundgrey500Container: Color(0xFF99F0FF),
    onBackgroundgrey500Container: Color(0xFF001F24),
    sourceBackgroundgrey600: Color(0xFF9CAFB1),
    backgroundgrey600: Color(0xFF9CAFB1),
    onBackgroundgrey600: Color(0xFFFFFFFF),
    backgroundgrey600Container: Color(0xFF81F4FF),
    onBackgroundgrey600Container: Color(0xFF002022),
    sourceBackgroundgrey700: Color(0xFF8FA3A5),
    backgroundgrey700: Color(0xFF8FA3A5),
    onBackgroundgrey700: Color(0xFFFFFFFF),
    backgroundgrey700Container: Color(0xFF7EF4FF),
    onBackgroundgrey700Container: Color(0xFF002022),
    sourceBackgroundgrey800: Color(0xFF606A7B),
    backgroundgrey800: Color(0xFF606A7B),
    onBackgroundgrey800: Color(0xFFFFFFFF),
    backgroundgrey800Container: Color(0xFFD4E3FF),
    onBackgroundgrey800Container: Color(0xFF001C3A),
    sourceBackgroundgrey900: Color(0xFF3C4858),
    backgroundgrey900: Color(0xFF3C4858),
    onBackgroundgrey900: Color(0xFFFFFFFF),
    backgroundgrey900Container: Color(0xFFD2E4FF),
    onBackgroundgrey900Container: Color(0xFF001D37),
    sourceGeyser: Color(0xFFDAE0E5),
    geyser: Color(0xFFDAE0E5),
    onGeyser: Color(0xFFFFFFFF),
    geyserContainer: Color(0xFFC1E8FF),
    onGeyserContainer: Color(0xFF001E2B),
    sourceGrey: Color(0xFFF5F5F8),
    grey: Color(0xFFF5F5F8),
    onGrey: Color(0xFFFFFFFF),
    greyContainer: Color(0xFFCBE6FF),
    onGreyContainer: Color(0xFF001E30),
    sourceBackgroundblack: Color(0xFF1F2D3D),
    backgroundblack: Color(0xFF1F2D3D),
    onBackgroundblack: Color(0xFFFFFFFF),
    backgroundblackContainer: Color(0xFFD1E4FF),
    onBackgroundblackContainer: Color(0xFF001D35),
    sourceSkirretgreen: Color(0xFF45BA43),
    skirretgreen: Color(0xFF45BA43),
    onSkirretgreen: Color(0xFFFFFFFF),
    skirretgreenContainer: Color(0xFF86FC7C),
    onSkirretgreenContainer: Color(0xFF002202),
  );

  static const CustomColors darkCustomColors = CustomColors(
    sourcePrimarymain: Color(0xFF113DBC),
    primarymain: Color(0xFFB8C4FF),
    onPrimarymain: Color(0xFF002585),
    primarymainContainer: Color(0xFF0437B7),
    onPrimarymainContainer: Color(0xFFDDE1FF),
    sourcePrimary50: Color(0xFFECF1FD),
    primary50: Color(0xFFA2C9FF),
    onPrimary50: Color(0xFF00315B),
    primary50Container: Color(0xFF004881),
    onPrimary50Container: Color(0xFFD3E4FF),
    sourcePrimary100: Color(0xFFDCE1FA),
    primary100: Color(0xFFB3C5FF),
    onPrimary100: Color(0xFF002A77),
    primary100Container: Color(0xFF224290),
    onPrimary100Container: Color(0xFFDBE1FF),
    sourcePrimary200: Color(0xFFB7C3F4),
    primary200: Color(0xFFB5C4FF),
    onPrimary200: Color(0xFF052978),
    primary200Container: Color(0xFF264190),
    onPrimary200Container: Color(0xFFDCE1FF),
    sourcePrimary300: Color(0xFF5F7CE7),
    primary300: Color(0xFFB7C4FF),
    onPrimary300: Color(0xFF002681),
    primary300Container: Color(0xFF183CA6),
    onPrimary300Container: Color(0xFFDCE1FF),
    sourcePrimary500: Color(0xFF182F8F),
    primary500: Color(0xFFB9C3FF),
    onPrimary500: Color(0xFF082386),
    primary500Container: Color(0xFF283D9C),
    onPrimary500Container: Color(0xFFDEE1FF),
    sourcePrimary600: Color(0xFF11236C),
    primary600: Color(0xFFB9C3FF),
    onPrimary600: Color(0xFF132778),
    primary600Container: Color(0xFF2E4090),
    onPrimary600Container: Color(0xFFDDE1FF),
    sourcePrimary700: Color(0xFF0B1848),
    primary700: Color(0xFFB8C4FF),
    onPrimary700: Color(0xFF102878),
    primary700Container: Color(0xFF2C4090),
    onPrimary700Container: Color(0xFFDDE1FF),
    sourcePrimary800: Color(0xFF081236),
    primary800: Color(0xFFB7C4FF),
    onPrimary800: Color(0xFF0E2878),
    primary800Container: Color(0xFF2B4090),
    onPrimary800Container: Color(0xFFDDE1FF),
    sourcePrimary900: Color(0xFF030612),
    primary900: Color(0xFFB3C5FF),
    onPrimary900: Color(0xFF002B74),
    primary900Container: Color(0xFF20428F),
    onPrimary900Container: Color(0xFFDAE2FF),
    sourceSecondary1100: Color(0xFFEFECFC),
    secondary1100: Color(0xFFC1C1FF),
    onSecondary1100: Color(0xFF242478),
    secondary1100Container: Color(0xFF3C3D8F),
    onSecondary1100Container: Color(0xFFE1DFFF),
    sourceSecondary1200: Color(0xFFD1C7F6),
    secondary1200: Color(0xFFCBBEFF),
    onSecondary1200: Color(0xFF322074),
    secondary1200Container: Color(0xFF49398C),
    onSecondary1200Container: Color(0xFFE6DEFF),
    sourceSecondary1300: Color(0xFF937DEC),
    secondary1300: Color(0xFFCBBEFF),
    onSecondary1300: Color(0xFF331488),
    secondary1300Container: Color(0xFF4A329E),
    onSecondary1300Container: Color(0xFFE7DEFF),
    sourceSecondary1default: Color(0xFF3A11BC),
    secondary1default: Color(0xFFC8BFFF),
    onSecondary1default: Color(0xFF2C009E),
    secondary1defaultContainer: Color(0xFF4221C3),
    onSecondary1defaultContainer: Color(0xFFE5DEFF),
    sourceSecondary2100: Color(0xFFEEF9FC),
    secondary2100: Color(0xFF52D7F0),
    onSecondary2100: Color(0xFF00363F),
    secondary2100Container: Color(0xFF004E5A),
    onSecondary2100Container: Color(0xFFA4EEFF),
    sourceSecondary2200: Color(0xFFCFEDF8),
    secondary2200: Color(0xFF58D5F8),
    onSecondary2200: Color(0xFF003642),
    secondary2200Container: Color(0xFF004E5E),
    onSecondary2200Container: Color(0xFFB2EBFF),
    sourceSecondary2300: Color(0xFF92D5F0),
    secondary2300: Color(0xFF5ED4FD),
    onSecondary2300: Color(0xFF003544),
    secondary2300Container: Color(0xFF004D62),
    onSecondary2300Container: Color(0xFFB9EAFF),
    sourceSecondary2400: Color(0xFF59B8E5),
    secondary2400: Color(0xFF75D1FF),
    onSecondary2400: Color(0xFF003548),
    secondary2400Container: Color(0xFF004D67),
    onSecondary2400Container: Color(0xFFC2E8FF),
    sourceSecondary2default: Color(0xFF1193BC),
    secondary2default: Color(0xFF6AD3FF),
    onSecondary2default: Color(0xFF003546),
    secondary2defaultContainer: Color(0xFF004D65),
    onSecondary2defaultContainer: Color(0xFFBEE9FF),
    sourceSuccess100: Color(0xFFE3FEEF),
    success100: Color(0xFF68DBAF),
    onSuccess100: Color(0xFF003827),
    success100Container: Color(0xFF00513B),
    onSuccess100Container: Color(0xFF86F8CB),
    sourceSuccess200: Color(0xFF6FECA4),
    success200: Color(0xFF60DD97),
    onSuccess200: Color(0xFF00391F),
    success200Container: Color(0xFF00522F),
    onSuccess200Container: Color(0xFF7EFBB1),
    sourceSuccess300: Color(0xFF28C269),
    success300: Color(0xFF50E083),
    onSuccess300: Color(0xFF003919),
    success300Container: Color(0xFF005227),
    onSuccess300Container: Color(0xFF70FD9D),
    sourceSuccess400: Color(0xFF1F9A53),
    success400: Color(0xFF6CDD8E),
    onSuccess400: Color(0xFF003919),
    success400Container: Color(0xFF005227),
    onSuccess400Container: Color(0xFF88FAA7),
    sourceSuccess500: Color(0xFF115A30),
    success500: Color(0xFF80D998),
    onSuccess500: Color(0xFF00391A),
    success500Container: Color(0xFF005229),
    onSuccess500Container: Color(0xFF9BF6B2),
    sourceLink100: Color(0xFFE1F2FF),
    link100: Color(0xFF7DD0FF),
    onLink100: Color(0xFF00344A),
    link100Container: Color(0xFF004C69),
    onLink100Container: Color(0xFFC4E7FF),
    sourceLink200: Color(0xFF88CCFF),
    link200: Color(0xFF8CCDFF),
    onLink200: Color(0xFF00344E),
    link200Container: Color(0xFF004B70),
    onLink200Container: Color(0xFFCAE6FF),
    sourceLink300: Color(0xFF2EA5FF),
    link300: Color(0xFF9ACBFF),
    onLink300: Color(0xFF003355),
    link300Container: Color(0xFF004A79),
    onLink300Container: Color(0xFFD0E4FF),
    sourceLink400: Color(0xFF028EF8),
    link400: Color(0xFFA3C9FF),
    onLink400: Color(0xFF00315C),
    link400Container: Color(0xFF004882),
    onLink400Container: Color(0xFFD3E3FF),
    sourceLink500: Color(0xFF0271C5),
    link500: Color(0xFFA2C9FF),
    onLink500: Color(0xFF00315B),
    link500Container: Color(0xFF004881),
    onLink500Container: Color(0xFFD3E4FF),
    sourceWarning100: Color(0xFFFFFAEB),
    warning100: Color(0xFFD4CA52),
    onWarning100: Color(0xFF353100),
    warning100Container: Color(0xFF4D4800),
    onWarning100Container: Color(0xFFF1E66A),
    sourceWarning200: Color(0xFFFEF0C7),
    warning200: Color(0xFFE3C54A),
    onWarning200: Color(0xFF3A3000),
    warning200Container: Color(0xFF544600),
    onWarning200Container: Color(0xFFFFE170),
    sourceWarning300: Color(0xFFF79009),
    warning300: Color(0xFFFFB875),
    onWarning300: Color(0xFF4B2800),
    warning300Container: Color(0xFF6B3B00),
    onWarning300Container: Color(0xFFFFDCC0),
    sourceWarning400: Color(0xFFDC6803),
    warning400: Color(0xFFFFB68C),
    onWarning400: Color(0xFF522300),
    warning400Container: Color(0xFF753400),
    onWarning400Container: Color(0xFFFFDBC9),
    sourceWarning500: Color(0xFFB54708),
    warning500: Color(0xFFFFB597),
    onWarning500: Color(0xFF581D00),
    warning500Container: Color(0xFF7D2D00),
    onWarning500Container: Color(0xFFFFDBCD),
    sourceWarning250: Color(0xFFF9A63A),
    warning250: Color(0xFFFFB865),
    onWarning250: Color(0xFF482900),
    warning250Container: Color(0xFF673D00),
    onWarning250Container: Color(0xFFFFDDBA),
    sourceYellow: Color(0xFFFFC82C),
    yellow: Color(0xFFF5BF21),
    onYellow: Color(0xFF3E2E00),
    yellowContainer: Color(0xFF5A4300),
    onYellowContainer: Color(0xFFFFDF98),
    sourceError100: Color(0xFFFFEDED),
    error100: Color(0xFFFFB2B7),
    onError100: Color(0xFF5F1220),
    error100Container: Color(0xFF7D2935),
    onError100Container: Color(0xFFFFDADB),
    sourceError200: Color(0xFFFFAEAE),
    error200: Color(0xFFFFB3B3),
    onError200: Color(0xFF5F131B),
    error200Container: Color(0xFF7E2A2F),
    onError200Container: Color(0xFFFFDAD9),
    sourceError300: Color(0xFFFE4141),
    error300: Color(0xFFFFB3AD),
    onError300: Color(0xFF680009),
    error300Container: Color(0xFF930011),
    onError300Container: Color(0xFFFFDAD6),
    sourceError400: Color(0xFFEA0000),
    error400: Color(0xFFFFB4A8),
    onError400: Color(0xFF690000),
    error400Container: Color(0xFF930100),
    onError400Container: Color(0xFFFFDAD4),
    sourceError500: Color(0xFFAC0101),
    error500: Color(0xFFFFB4A8),
    onError500: Color(0xFF690000),
    error500Container: Color(0xFF930000),
    onError500Container: Color(0xFFFFDAD4),
    sourceBackgroundwhite: Color(0xFFFFFFFF),
    backgroundwhite: Color(0xFF4FD8EB),
    onBackgroundwhite: Color(0xFF00363D),
    backgroundwhiteContainer: Color(0xFF004F58),
    onBackgroundwhiteContainer: Color(0xFF97F0FF),
    sourceBackgroundgrey100: Color(0xFFF6FAFB),
    backgroundgrey100: Color(0xFF50D7ED),
    onBackgroundgrey100: Color(0xFF00363E),
    backgroundgrey100Container: Color(0xFF004E59),
    onBackgroundgrey100Container: Color(0xFF9EEFFF),
    sourceBackgroundgrey200: Color(0xFFF4F9FA),
    backgroundgrey200: Color(0xFF4FD8EC),
    onBackgroundgrey200: Color(0xFF00363D),
    backgroundgrey200Container: Color(0xFF004F58),
    onBackgroundgrey200Container: Color(0xFF99F0FF),
    sourceBackgroundgrey300: Color(0xFFECF3F5),
    backgroundgrey300: Color(0xFF52D7F0),
    onBackgroundgrey300: Color(0xFF00363F),
    backgroundgrey300Container: Color(0xFF004E5A),
    onBackgroundgrey300Container: Color(0xFFA3EEFF),
    sourceBackgroundgrey400: Color(0xFFD9E9ED),
    backgroundgrey400: Color(0xFF52D7EF),
    onBackgroundgrey400: Color(0xFF00363E),
    backgroundgrey400Container: Color(0xFF004E5A),
    onBackgroundgrey400Container: Color(0xFFA2EEFF),
    sourceBackgroundgrey500: Color(0xFFAABFC3),
    backgroundgrey500: Color(0xFF4FD8EC),
    onBackgroundgrey500: Color(0xFF00363D),
    backgroundgrey500Container: Color(0xFF004F58),
    onBackgroundgrey500Container: Color(0xFF99F0FF),
    sourceBackgroundgrey600: Color(0xFF9CAFB1),
    backgroundgrey600: Color(0xFF4DD9E5),
    onBackgroundgrey600: Color(0xFF00363B),
    backgroundgrey600Container: Color(0xFF004F55),
    onBackgroundgrey600Container: Color(0xFF81F4FF),
    sourceBackgroundgrey700: Color(0xFF8FA3A5),
    backgroundgrey700: Color(0xFF4DD9E5),
    onBackgroundgrey700: Color(0xFF00363B),
    backgroundgrey700Container: Color(0xFF004F55),
    onBackgroundgrey700Container: Color(0xFF7EF4FF),
    sourceBackgroundgrey800: Color(0xFF606A7B),
    backgroundgrey800: Color(0xFFA4C8FF),
    onBackgroundgrey800: Color(0xFF00315E),
    backgroundgrey800Container: Color(0xFF004784),
    onBackgroundgrey800Container: Color(0xFFD4E3FF),
    sourceBackgroundgrey900: Color(0xFF3C4858),
    backgroundgrey900: Color(0xFF9FCAFF),
    onBackgroundgrey900: Color(0xFF003259),
    backgroundgrey900Container: Color(0xFF00497E),
    onBackgroundgrey900Container: Color(0xFFD2E4FF),
    sourceGeyser: Color(0xFFDAE0E5),
    geyser: Color(0xFF73D1FF),
    onGeyser: Color(0xFF003548),
    geyserContainer: Color(0xFF004D66),
    onGeyserContainer: Color(0xFFC1E8FF),
    sourceGrey: Color(0xFFF5F5F8),
    grey: Color(0xFF8FCDFF),
    onGrey: Color(0xFF003450),
    greyContainer: Color(0xFF004B71),
    onGreyContainer: Color(0xFFCBE6FF),
    sourceBackgroundblack: Color(0xFF1F2D3D),
    backgroundblack: Color(0xFF9DCAFF),
    onBackgroundblack: Color(0xFF003257),
    backgroundblackContainer: Color(0xFF00497C),
    onBackgroundblackContainer: Color(0xFFD1E4FF),
    sourceSkirretgreen: Color(0xFF45BA43),
    skirretgreen: Color(0xFF6ADF63),
    onSkirretgreen: Color(0xFF003A05),
    skirretgreenContainer: Color(0xFF00530A),
    onSkirretgreenContainer: Color(0xFF86FC7C),
  );
}

/// Defines a set of custom colors, each comprised of 4 complementary tones.
///
/// See also:
///   * <https://m3.material.io/styles/color/the-color-system/custom-colors>
@immutable
class CustomColors extends ThemeExtension<CustomColors> {
  const CustomColors({
    required this.sourcePrimarymain,
    required this.primarymain,
    required this.onPrimarymain,
    required this.primarymainContainer,
    required this.onPrimarymainContainer,
    required this.sourcePrimary50,
    required this.primary50,
    required this.onPrimary50,
    required this.primary50Container,
    required this.onPrimary50Container,
    required this.sourcePrimary100,
    required this.primary100,
    required this.onPrimary100,
    required this.primary100Container,
    required this.onPrimary100Container,
    required this.sourcePrimary200,
    required this.primary200,
    required this.onPrimary200,
    required this.primary200Container,
    required this.onPrimary200Container,
    required this.sourcePrimary300,
    required this.primary300,
    required this.onPrimary300,
    required this.primary300Container,
    required this.onPrimary300Container,
    required this.sourcePrimary500,
    required this.primary500,
    required this.onPrimary500,
    required this.primary500Container,
    required this.onPrimary500Container,
    required this.sourcePrimary600,
    required this.primary600,
    required this.onPrimary600,
    required this.primary600Container,
    required this.onPrimary600Container,
    required this.sourcePrimary700,
    required this.primary700,
    required this.onPrimary700,
    required this.primary700Container,
    required this.onPrimary700Container,
    required this.sourcePrimary800,
    required this.primary800,
    required this.onPrimary800,
    required this.primary800Container,
    required this.onPrimary800Container,
    required this.sourcePrimary900,
    required this.primary900,
    required this.onPrimary900,
    required this.primary900Container,
    required this.onPrimary900Container,
    required this.sourceSecondary1100,
    required this.secondary1100,
    required this.onSecondary1100,
    required this.secondary1100Container,
    required this.onSecondary1100Container,
    required this.sourceSecondary1200,
    required this.secondary1200,
    required this.onSecondary1200,
    required this.secondary1200Container,
    required this.onSecondary1200Container,
    required this.sourceSecondary1300,
    required this.secondary1300,
    required this.onSecondary1300,
    required this.secondary1300Container,
    required this.onSecondary1300Container,
    required this.sourceSecondary1default,
    required this.secondary1default,
    required this.onSecondary1default,
    required this.secondary1defaultContainer,
    required this.onSecondary1defaultContainer,
    required this.sourceSecondary2100,
    required this.secondary2100,
    required this.onSecondary2100,
    required this.secondary2100Container,
    required this.onSecondary2100Container,
    required this.sourceSecondary2200,
    required this.secondary2200,
    required this.onSecondary2200,
    required this.secondary2200Container,
    required this.onSecondary2200Container,
    required this.sourceSecondary2300,
    required this.secondary2300,
    required this.onSecondary2300,
    required this.secondary2300Container,
    required this.onSecondary2300Container,
    required this.sourceSecondary2400,
    required this.secondary2400,
    required this.onSecondary2400,
    required this.secondary2400Container,
    required this.onSecondary2400Container,
    required this.sourceSecondary2default,
    required this.secondary2default,
    required this.onSecondary2default,
    required this.secondary2defaultContainer,
    required this.onSecondary2defaultContainer,
    required this.sourceSuccess100,
    required this.success100,
    required this.onSuccess100,
    required this.success100Container,
    required this.onSuccess100Container,
    required this.sourceSuccess200,
    required this.success200,
    required this.onSuccess200,
    required this.success200Container,
    required this.onSuccess200Container,
    required this.sourceSuccess300,
    required this.success300,
    required this.onSuccess300,
    required this.success300Container,
    required this.onSuccess300Container,
    required this.sourceSuccess400,
    required this.success400,
    required this.onSuccess400,
    required this.success400Container,
    required this.onSuccess400Container,
    required this.sourceSuccess500,
    required this.success500,
    required this.onSuccess500,
    required this.success500Container,
    required this.onSuccess500Container,
    required this.sourceLink100,
    required this.link100,
    required this.onLink100,
    required this.link100Container,
    required this.onLink100Container,
    required this.sourceLink200,
    required this.link200,
    required this.onLink200,
    required this.link200Container,
    required this.onLink200Container,
    required this.sourceLink300,
    required this.link300,
    required this.onLink300,
    required this.link300Container,
    required this.onLink300Container,
    required this.sourceLink400,
    required this.link400,
    required this.onLink400,
    required this.link400Container,
    required this.onLink400Container,
    required this.sourceLink500,
    required this.link500,
    required this.onLink500,
    required this.link500Container,
    required this.onLink500Container,
    required this.sourceWarning100,
    required this.warning100,
    required this.onWarning100,
    required this.warning100Container,
    required this.onWarning100Container,
    required this.sourceWarning200,
    required this.warning200,
    required this.onWarning200,
    required this.warning200Container,
    required this.onWarning200Container,
    required this.sourceWarning300,
    required this.warning300,
    required this.onWarning300,
    required this.warning300Container,
    required this.onWarning300Container,
    required this.sourceWarning400,
    required this.warning400,
    required this.onWarning400,
    required this.warning400Container,
    required this.onWarning400Container,
    required this.sourceWarning500,
    required this.warning500,
    required this.onWarning500,
    required this.warning500Container,
    required this.onWarning500Container,
    required this.sourceWarning250,
    required this.warning250,
    required this.onWarning250,
    required this.warning250Container,
    required this.onWarning250Container,
    required this.sourceYellow,
    required this.yellow,
    required this.onYellow,
    required this.yellowContainer,
    required this.onYellowContainer,
    required this.sourceError100,
    required this.error100,
    required this.onError100,
    required this.error100Container,
    required this.onError100Container,
    required this.sourceError200,
    required this.error200,
    required this.onError200,
    required this.error200Container,
    required this.onError200Container,
    required this.sourceError300,
    required this.error300,
    required this.onError300,
    required this.error300Container,
    required this.onError300Container,
    required this.sourceError400,
    required this.error400,
    required this.onError400,
    required this.error400Container,
    required this.onError400Container,
    required this.sourceError500,
    required this.error500,
    required this.onError500,
    required this.error500Container,
    required this.onError500Container,
    required this.sourceBackgroundwhite,
    required this.backgroundwhite,
    required this.onBackgroundwhite,
    required this.backgroundwhiteContainer,
    required this.onBackgroundwhiteContainer,
    required this.sourceBackgroundgrey100,
    required this.backgroundgrey100,
    required this.onBackgroundgrey100,
    required this.backgroundgrey100Container,
    required this.onBackgroundgrey100Container,
    required this.sourceBackgroundgrey200,
    required this.backgroundgrey200,
    required this.onBackgroundgrey200,
    required this.backgroundgrey200Container,
    required this.onBackgroundgrey200Container,
    required this.sourceBackgroundgrey300,
    required this.backgroundgrey300,
    required this.onBackgroundgrey300,
    required this.backgroundgrey300Container,
    required this.onBackgroundgrey300Container,
    required this.sourceBackgroundgrey400,
    required this.backgroundgrey400,
    required this.onBackgroundgrey400,
    required this.backgroundgrey400Container,
    required this.onBackgroundgrey400Container,
    required this.sourceBackgroundgrey500,
    required this.backgroundgrey500,
    required this.onBackgroundgrey500,
    required this.backgroundgrey500Container,
    required this.onBackgroundgrey500Container,
    required this.sourceBackgroundgrey600,
    required this.backgroundgrey600,
    required this.onBackgroundgrey600,
    required this.backgroundgrey600Container,
    required this.onBackgroundgrey600Container,
    required this.sourceBackgroundgrey700,
    required this.backgroundgrey700,
    required this.onBackgroundgrey700,
    required this.backgroundgrey700Container,
    required this.onBackgroundgrey700Container,
    required this.sourceBackgroundgrey800,
    required this.backgroundgrey800,
    required this.onBackgroundgrey800,
    required this.backgroundgrey800Container,
    required this.onBackgroundgrey800Container,
    required this.sourceBackgroundgrey900,
    required this.backgroundgrey900,
    required this.onBackgroundgrey900,
    required this.backgroundgrey900Container,
    required this.onBackgroundgrey900Container,
    required this.sourceGeyser,
    required this.geyser,
    required this.onGeyser,
    required this.geyserContainer,
    required this.onGeyserContainer,
    required this.sourceGrey,
    required this.grey,
    required this.onGrey,
    required this.greyContainer,
    required this.onGreyContainer,
    required this.sourceBackgroundblack,
    required this.backgroundblack,
    required this.onBackgroundblack,
    required this.backgroundblackContainer,
    required this.onBackgroundblackContainer,
    required this.sourceSkirretgreen,
    required this.skirretgreen,
    required this.onSkirretgreen,
    required this.skirretgreenContainer,
    required this.onSkirretgreenContainer,
  });

  final Color? sourcePrimarymain;
  final Color? primarymain;
  final Color? onPrimarymain;
  final Color? primarymainContainer;
  final Color? onPrimarymainContainer;
  final Color? sourcePrimary50;
  final Color? primary50;
  final Color? onPrimary50;
  final Color? primary50Container;
  final Color? onPrimary50Container;
  final Color? sourcePrimary100;
  final Color? primary100;
  final Color? onPrimary100;
  final Color? primary100Container;
  final Color? onPrimary100Container;
  final Color? sourcePrimary200;
  final Color? primary200;
  final Color? onPrimary200;
  final Color? primary200Container;
  final Color? onPrimary200Container;
  final Color? sourcePrimary300;
  final Color? primary300;
  final Color? onPrimary300;
  final Color? primary300Container;
  final Color? onPrimary300Container;
  final Color? sourcePrimary500;
  final Color? primary500;
  final Color? onPrimary500;
  final Color? primary500Container;
  final Color? onPrimary500Container;
  final Color? sourcePrimary600;
  final Color? primary600;
  final Color? onPrimary600;
  final Color? primary600Container;
  final Color? onPrimary600Container;
  final Color? sourcePrimary700;
  final Color? primary700;
  final Color? onPrimary700;
  final Color? primary700Container;
  final Color? onPrimary700Container;
  final Color? sourcePrimary800;
  final Color? primary800;
  final Color? onPrimary800;
  final Color? primary800Container;
  final Color? onPrimary800Container;
  final Color? sourcePrimary900;
  final Color? primary900;
  final Color? onPrimary900;
  final Color? primary900Container;
  final Color? onPrimary900Container;
  final Color? sourceSecondary1100;
  final Color? secondary1100;
  final Color? onSecondary1100;
  final Color? secondary1100Container;
  final Color? onSecondary1100Container;
  final Color? sourceSecondary1200;
  final Color? secondary1200;
  final Color? onSecondary1200;
  final Color? secondary1200Container;
  final Color? onSecondary1200Container;
  final Color? sourceSecondary1300;
  final Color? secondary1300;
  final Color? onSecondary1300;
  final Color? secondary1300Container;
  final Color? onSecondary1300Container;
  final Color? sourceSecondary1default;
  final Color? secondary1default;
  final Color? onSecondary1default;
  final Color? secondary1defaultContainer;
  final Color? onSecondary1defaultContainer;
  final Color? sourceSecondary2100;
  final Color? secondary2100;
  final Color? onSecondary2100;
  final Color? secondary2100Container;
  final Color? onSecondary2100Container;
  final Color? sourceSecondary2200;
  final Color? secondary2200;
  final Color? onSecondary2200;
  final Color? secondary2200Container;
  final Color? onSecondary2200Container;
  final Color? sourceSecondary2300;
  final Color? secondary2300;
  final Color? onSecondary2300;
  final Color? secondary2300Container;
  final Color? onSecondary2300Container;
  final Color? sourceSecondary2400;
  final Color? secondary2400;
  final Color? onSecondary2400;
  final Color? secondary2400Container;
  final Color? onSecondary2400Container;
  final Color? sourceSecondary2default;
  final Color? secondary2default;
  final Color? onSecondary2default;
  final Color? secondary2defaultContainer;
  final Color? onSecondary2defaultContainer;
  final Color? sourceSuccess100;
  final Color? success100;
  final Color? onSuccess100;
  final Color? success100Container;
  final Color? onSuccess100Container;
  final Color? sourceSuccess200;
  final Color? success200;
  final Color? onSuccess200;
  final Color? success200Container;
  final Color? onSuccess200Container;
  final Color? sourceSuccess300;
  final Color? success300;
  final Color? onSuccess300;
  final Color? success300Container;
  final Color? onSuccess300Container;
  final Color? sourceSuccess400;
  final Color? success400;
  final Color? onSuccess400;
  final Color? success400Container;
  final Color? onSuccess400Container;
  final Color? sourceSuccess500;
  final Color? success500;
  final Color? onSuccess500;
  final Color? success500Container;
  final Color? onSuccess500Container;
  final Color? sourceLink100;
  final Color? link100;
  final Color? onLink100;
  final Color? link100Container;
  final Color? onLink100Container;
  final Color? sourceLink200;
  final Color? link200;
  final Color? onLink200;
  final Color? link200Container;
  final Color? onLink200Container;
  final Color? sourceLink300;
  final Color? link300;
  final Color? onLink300;
  final Color? link300Container;
  final Color? onLink300Container;
  final Color? sourceLink400;
  final Color? link400;
  final Color? onLink400;
  final Color? link400Container;
  final Color? onLink400Container;
  final Color? sourceLink500;
  final Color? link500;
  final Color? onLink500;
  final Color? link500Container;
  final Color? onLink500Container;
  final Color? sourceWarning100;
  final Color? warning100;
  final Color? onWarning100;
  final Color? warning100Container;
  final Color? onWarning100Container;
  final Color? sourceWarning200;
  final Color? warning200;
  final Color? onWarning200;
  final Color? warning200Container;
  final Color? onWarning200Container;
  final Color? sourceWarning300;
  final Color? warning300;
  final Color? onWarning300;
  final Color? warning300Container;
  final Color? onWarning300Container;
  final Color? sourceWarning400;
  final Color? warning400;
  final Color? onWarning400;
  final Color? warning400Container;
  final Color? onWarning400Container;
  final Color? sourceWarning500;
  final Color? warning500;
  final Color? onWarning500;
  final Color? warning500Container;
  final Color? onWarning500Container;
  final Color? sourceWarning250;
  final Color? warning250;
  final Color? onWarning250;
  final Color? warning250Container;
  final Color? onWarning250Container;
  final Color? sourceYellow;
  final Color? yellow;
  final Color? onYellow;
  final Color? yellowContainer;
  final Color? onYellowContainer;
  final Color? sourceError100;
  final Color? error100;
  final Color? onError100;
  final Color? error100Container;
  final Color? onError100Container;
  final Color? sourceError200;
  final Color? error200;
  final Color? onError200;
  final Color? error200Container;
  final Color? onError200Container;
  final Color? sourceError300;
  final Color? error300;
  final Color? onError300;
  final Color? error300Container;
  final Color? onError300Container;
  final Color? sourceError400;
  final Color? error400;
  final Color? onError400;
  final Color? error400Container;
  final Color? onError400Container;
  final Color? sourceError500;
  final Color? error500;
  final Color? onError500;
  final Color? error500Container;
  final Color? onError500Container;
  final Color? sourceBackgroundwhite;
  final Color? backgroundwhite;
  final Color? onBackgroundwhite;
  final Color? backgroundwhiteContainer;
  final Color? onBackgroundwhiteContainer;
  final Color? sourceBackgroundgrey100;
  final Color? backgroundgrey100;
  final Color? onBackgroundgrey100;
  final Color? backgroundgrey100Container;
  final Color? onBackgroundgrey100Container;
  final Color? sourceBackgroundgrey200;
  final Color? backgroundgrey200;
  final Color? onBackgroundgrey200;
  final Color? backgroundgrey200Container;
  final Color? onBackgroundgrey200Container;
  final Color? sourceBackgroundgrey300;
  final Color? backgroundgrey300;
  final Color? onBackgroundgrey300;
  final Color? backgroundgrey300Container;
  final Color? onBackgroundgrey300Container;
  final Color? sourceBackgroundgrey400;
  final Color? backgroundgrey400;
  final Color? onBackgroundgrey400;
  final Color? backgroundgrey400Container;
  final Color? onBackgroundgrey400Container;
  final Color? sourceBackgroundgrey500;
  final Color? backgroundgrey500;
  final Color? onBackgroundgrey500;
  final Color? backgroundgrey500Container;
  final Color? onBackgroundgrey500Container;
  final Color? sourceBackgroundgrey600;
  final Color? backgroundgrey600;
  final Color? onBackgroundgrey600;
  final Color? backgroundgrey600Container;
  final Color? onBackgroundgrey600Container;
  final Color? sourceBackgroundgrey700;
  final Color? backgroundgrey700;
  final Color? onBackgroundgrey700;
  final Color? backgroundgrey700Container;
  final Color? onBackgroundgrey700Container;
  final Color? sourceBackgroundgrey800;
  final Color? backgroundgrey800;
  final Color? onBackgroundgrey800;
  final Color? backgroundgrey800Container;
  final Color? onBackgroundgrey800Container;
  final Color? sourceBackgroundgrey900;
  final Color? backgroundgrey900;
  final Color? onBackgroundgrey900;
  final Color? backgroundgrey900Container;
  final Color? onBackgroundgrey900Container;
  final Color? sourceGeyser;
  final Color? geyser;
  final Color? onGeyser;
  final Color? geyserContainer;
  final Color? onGeyserContainer;
  final Color? sourceGrey;
  final Color? grey;
  final Color? onGrey;
  final Color? greyContainer;
  final Color? onGreyContainer;
  final Color? sourceBackgroundblack;
  final Color? backgroundblack;
  final Color? onBackgroundblack;
  final Color? backgroundblackContainer;
  final Color? onBackgroundblackContainer;
  final Color? sourceSkirretgreen;
  final Color? skirretgreen;
  final Color? onSkirretgreen;
  final Color? skirretgreenContainer;
  final Color? onSkirretgreenContainer;

  @override
  CustomColors copyWith({
    Color? sourcePrimarymain,
    Color? primarymain,
    Color? onPrimarymain,
    Color? primarymainContainer,
    Color? onPrimarymainContainer,
    Color? sourcePrimary50,
    Color? primary50,
    Color? onPrimary50,
    Color? primary50Container,
    Color? onPrimary50Container,
    Color? sourcePrimary100,
    Color? primary100,
    Color? onPrimary100,
    Color? primary100Container,
    Color? onPrimary100Container,
    Color? sourcePrimary200,
    Color? primary200,
    Color? onPrimary200,
    Color? primary200Container,
    Color? onPrimary200Container,
    Color? sourcePrimary300,
    Color? primary300,
    Color? onPrimary300,
    Color? primary300Container,
    Color? onPrimary300Container,
    Color? sourcePrimary500,
    Color? primary500,
    Color? onPrimary500,
    Color? primary500Container,
    Color? onPrimary500Container,
    Color? sourcePrimary600,
    Color? primary600,
    Color? onPrimary600,
    Color? primary600Container,
    Color? onPrimary600Container,
    Color? sourcePrimary700,
    Color? primary700,
    Color? onPrimary700,
    Color? primary700Container,
    Color? onPrimary700Container,
    Color? sourcePrimary800,
    Color? primary800,
    Color? onPrimary800,
    Color? primary800Container,
    Color? onPrimary800Container,
    Color? sourcePrimary900,
    Color? primary900,
    Color? onPrimary900,
    Color? primary900Container,
    Color? onPrimary900Container,
    Color? sourceSecondary1100,
    Color? secondary1100,
    Color? onSecondary1100,
    Color? secondary1100Container,
    Color? onSecondary1100Container,
    Color? sourceSecondary1200,
    Color? secondary1200,
    Color? onSecondary1200,
    Color? secondary1200Container,
    Color? onSecondary1200Container,
    Color? sourceSecondary1300,
    Color? secondary1300,
    Color? onSecondary1300,
    Color? secondary1300Container,
    Color? onSecondary1300Container,
    Color? sourceSecondary1default,
    Color? secondary1default,
    Color? onSecondary1default,
    Color? secondary1defaultContainer,
    Color? onSecondary1defaultContainer,
    Color? sourceSecondary2100,
    Color? secondary2100,
    Color? onSecondary2100,
    Color? secondary2100Container,
    Color? onSecondary2100Container,
    Color? sourceSecondary2200,
    Color? secondary2200,
    Color? onSecondary2200,
    Color? secondary2200Container,
    Color? onSecondary2200Container,
    Color? sourceSecondary2300,
    Color? secondary2300,
    Color? onSecondary2300,
    Color? secondary2300Container,
    Color? onSecondary2300Container,
    Color? sourceSecondary2400,
    Color? secondary2400,
    Color? onSecondary2400,
    Color? secondary2400Container,
    Color? onSecondary2400Container,
    Color? sourceSecondary2default,
    Color? secondary2default,
    Color? onSecondary2default,
    Color? secondary2defaultContainer,
    Color? onSecondary2defaultContainer,
    Color? sourceSuccess100,
    Color? success100,
    Color? onSuccess100,
    Color? success100Container,
    Color? onSuccess100Container,
    Color? sourceSuccess200,
    Color? success200,
    Color? onSuccess200,
    Color? success200Container,
    Color? onSuccess200Container,
    Color? sourceSuccess300,
    Color? success300,
    Color? onSuccess300,
    Color? success300Container,
    Color? onSuccess300Container,
    Color? sourceSuccess400,
    Color? success400,
    Color? onSuccess400,
    Color? success400Container,
    Color? onSuccess400Container,
    Color? sourceSuccess500,
    Color? success500,
    Color? onSuccess500,
    Color? success500Container,
    Color? onSuccess500Container,
    Color? sourceLink100,
    Color? link100,
    Color? onLink100,
    Color? link100Container,
    Color? onLink100Container,
    Color? sourceLink200,
    Color? link200,
    Color? onLink200,
    Color? link200Container,
    Color? onLink200Container,
    Color? sourceLink300,
    Color? link300,
    Color? onLink300,
    Color? link300Container,
    Color? onLink300Container,
    Color? sourceLink400,
    Color? link400,
    Color? onLink400,
    Color? link400Container,
    Color? onLink400Container,
    Color? sourceLink500,
    Color? link500,
    Color? onLink500,
    Color? link500Container,
    Color? onLink500Container,
    Color? sourceWarning100,
    Color? warning100,
    Color? onWarning100,
    Color? warning100Container,
    Color? onWarning100Container,
    Color? sourceWarning200,
    Color? warning200,
    Color? onWarning200,
    Color? warning200Container,
    Color? onWarning200Container,
    Color? sourceWarning300,
    Color? warning300,
    Color? onWarning300,
    Color? warning300Container,
    Color? onWarning300Container,
    Color? sourceWarning400,
    Color? warning400,
    Color? onWarning400,
    Color? warning400Container,
    Color? onWarning400Container,
    Color? sourceWarning500,
    Color? warning500,
    Color? onWarning500,
    Color? warning500Container,
    Color? onWarning500Container,
    Color? sourceWarning250,
    Color? warning250,
    Color? onWarning250,
    Color? warning250Container,
    Color? onWarning250Container,
    Color? sourceYellow,
    Color? yellow,
    Color? onYellow,
    Color? yellowContainer,
    Color? onYellowContainer,
    Color? sourceError100,
    Color? error100,
    Color? onError100,
    Color? error100Container,
    Color? onError100Container,
    Color? sourceError200,
    Color? error200,
    Color? onError200,
    Color? error200Container,
    Color? onError200Container,
    Color? sourceError300,
    Color? error300,
    Color? onError300,
    Color? error300Container,
    Color? onError300Container,
    Color? sourceError400,
    Color? error400,
    Color? onError400,
    Color? error400Container,
    Color? onError400Container,
    Color? sourceError500,
    Color? error500,
    Color? onError500,
    Color? error500Container,
    Color? onError500Container,
    Color? sourceBackgroundwhite,
    Color? backgroundwhite,
    Color? onBackgroundwhite,
    Color? backgroundwhiteContainer,
    Color? onBackgroundwhiteContainer,
    Color? sourceBackgroundgrey100,
    Color? backgroundgrey100,
    Color? onBackgroundgrey100,
    Color? backgroundgrey100Container,
    Color? onBackgroundgrey100Container,
    Color? sourceBackgroundgrey200,
    Color? backgroundgrey200,
    Color? onBackgroundgrey200,
    Color? backgroundgrey200Container,
    Color? onBackgroundgrey200Container,
    Color? sourceBackgroundgrey300,
    Color? backgroundgrey300,
    Color? onBackgroundgrey300,
    Color? backgroundgrey300Container,
    Color? onBackgroundgrey300Container,
    Color? sourceBackgroundgrey400,
    Color? backgroundgrey400,
    Color? onBackgroundgrey400,
    Color? backgroundgrey400Container,
    Color? onBackgroundgrey400Container,
    Color? sourceBackgroundgrey500,
    Color? backgroundgrey500,
    Color? onBackgroundgrey500,
    Color? backgroundgrey500Container,
    Color? onBackgroundgrey500Container,
    Color? sourceBackgroundgrey600,
    Color? backgroundgrey600,
    Color? onBackgroundgrey600,
    Color? backgroundgrey600Container,
    Color? onBackgroundgrey600Container,
    Color? sourceBackgroundgrey700,
    Color? backgroundgrey700,
    Color? onBackgroundgrey700,
    Color? backgroundgrey700Container,
    Color? onBackgroundgrey700Container,
    Color? sourceBackgroundgrey800,
    Color? backgroundgrey800,
    Color? onBackgroundgrey800,
    Color? backgroundgrey800Container,
    Color? onBackgroundgrey800Container,
    Color? sourceBackgroundgrey900,
    Color? backgroundgrey900,
    Color? onBackgroundgrey900,
    Color? backgroundgrey900Container,
    Color? onBackgroundgrey900Container,
    Color? sourceGeyser,
    Color? geyser,
    Color? onGeyser,
    Color? geyserContainer,
    Color? onGeyserContainer,
    Color? sourceGrey,
    Color? grey,
    Color? onGrey,
    Color? greyContainer,
    Color? onGreyContainer,
    Color? sourceBackgroundblack,
    Color? backgroundblack,
    Color? onBackgroundblack,
    Color? backgroundblackContainer,
    Color? onBackgroundblackContainer,
    Color? sourceSkirretgreen,
    Color? skirretgreen,
    Color? onSkirretgreen,
    Color? skirretgreenContainer,
    Color? onSkirretgreenContainer,
  }) {
    return CustomColors(
      sourcePrimarymain: sourcePrimarymain ?? this.sourcePrimarymain,
      primarymain: primarymain ?? this.primarymain,
      onPrimarymain: onPrimarymain ?? this.onPrimarymain,
      primarymainContainer: primarymainContainer ?? this.primarymainContainer,
      onPrimarymainContainer: onPrimarymainContainer ?? this.onPrimarymainContainer,
      sourcePrimary50: sourcePrimary50 ?? this.sourcePrimary50,
      primary50: primary50 ?? this.primary50,
      onPrimary50: onPrimary50 ?? this.onPrimary50,
      primary50Container: primary50Container ?? this.primary50Container,
      onPrimary50Container: onPrimary50Container ?? this.onPrimary50Container,
      sourcePrimary100: sourcePrimary100 ?? this.sourcePrimary100,
      primary100: primary100 ?? this.primary100,
      onPrimary100: onPrimary100 ?? this.onPrimary100,
      primary100Container: primary100Container ?? this.primary100Container,
      onPrimary100Container: onPrimary100Container ?? this.onPrimary100Container,
      sourcePrimary200: sourcePrimary200 ?? this.sourcePrimary200,
      primary200: primary200 ?? this.primary200,
      onPrimary200: onPrimary200 ?? this.onPrimary200,
      primary200Container: primary200Container ?? this.primary200Container,
      onPrimary200Container: onPrimary200Container ?? this.onPrimary200Container,
      sourcePrimary300: sourcePrimary300 ?? this.sourcePrimary300,
      primary300: primary300 ?? this.primary300,
      onPrimary300: onPrimary300 ?? this.onPrimary300,
      primary300Container: primary300Container ?? this.primary300Container,
      onPrimary300Container: onPrimary300Container ?? this.onPrimary300Container,
      sourcePrimary500: sourcePrimary500 ?? this.sourcePrimary500,
      primary500: primary500 ?? this.primary500,
      onPrimary500: onPrimary500 ?? this.onPrimary500,
      primary500Container: primary500Container ?? this.primary500Container,
      onPrimary500Container: onPrimary500Container ?? this.onPrimary500Container,
      sourcePrimary600: sourcePrimary600 ?? this.sourcePrimary600,
      primary600: primary600 ?? this.primary600,
      onPrimary600: onPrimary600 ?? this.onPrimary600,
      primary600Container: primary600Container ?? this.primary600Container,
      onPrimary600Container: onPrimary600Container ?? this.onPrimary600Container,
      sourcePrimary700: sourcePrimary700 ?? this.sourcePrimary700,
      primary700: primary700 ?? this.primary700,
      onPrimary700: onPrimary700 ?? this.onPrimary700,
      primary700Container: primary700Container ?? this.primary700Container,
      onPrimary700Container: onPrimary700Container ?? this.onPrimary700Container,
      sourcePrimary800: sourcePrimary800 ?? this.sourcePrimary800,
      primary800: primary800 ?? this.primary800,
      onPrimary800: onPrimary800 ?? this.onPrimary800,
      primary800Container: primary800Container ?? this.primary800Container,
      onPrimary800Container: onPrimary800Container ?? this.onPrimary800Container,
      sourcePrimary900: sourcePrimary900 ?? this.sourcePrimary900,
      primary900: primary900 ?? this.primary900,
      onPrimary900: onPrimary900 ?? this.onPrimary900,
      primary900Container: primary900Container ?? this.primary900Container,
      onPrimary900Container: onPrimary900Container ?? this.onPrimary900Container,
      sourceSecondary1100: sourceSecondary1100 ?? this.sourceSecondary1100,
      secondary1100: secondary1100 ?? this.secondary1100,
      onSecondary1100: onSecondary1100 ?? this.onSecondary1100,
      secondary1100Container: secondary1100Container ?? this.secondary1100Container,
      onSecondary1100Container: onSecondary1100Container ?? this.onSecondary1100Container,
      sourceSecondary1200: sourceSecondary1200 ?? this.sourceSecondary1200,
      secondary1200: secondary1200 ?? this.secondary1200,
      onSecondary1200: onSecondary1200 ?? this.onSecondary1200,
      secondary1200Container: secondary1200Container ?? this.secondary1200Container,
      onSecondary1200Container: onSecondary1200Container ?? this.onSecondary1200Container,
      sourceSecondary1300: sourceSecondary1300 ?? this.sourceSecondary1300,
      secondary1300: secondary1300 ?? this.secondary1300,
      onSecondary1300: onSecondary1300 ?? this.onSecondary1300,
      secondary1300Container: secondary1300Container ?? this.secondary1300Container,
      onSecondary1300Container: onSecondary1300Container ?? this.onSecondary1300Container,
      sourceSecondary1default: sourceSecondary1default ?? this.sourceSecondary1default,
      secondary1default: secondary1default ?? this.secondary1default,
      onSecondary1default: onSecondary1default ?? this.onSecondary1default,
      secondary1defaultContainer: secondary1defaultContainer ?? this.secondary1defaultContainer,
      onSecondary1defaultContainer: onSecondary1defaultContainer ?? this.onSecondary1defaultContainer,
      sourceSecondary2100: sourceSecondary2100 ?? this.sourceSecondary2100,
      secondary2100: secondary2100 ?? this.secondary2100,
      onSecondary2100: onSecondary2100 ?? this.onSecondary2100,
      secondary2100Container: secondary2100Container ?? this.secondary2100Container,
      onSecondary2100Container: onSecondary2100Container ?? this.onSecondary2100Container,
      sourceSecondary2200: sourceSecondary2200 ?? this.sourceSecondary2200,
      secondary2200: secondary2200 ?? this.secondary2200,
      onSecondary2200: onSecondary2200 ?? this.onSecondary2200,
      secondary2200Container: secondary2200Container ?? this.secondary2200Container,
      onSecondary2200Container: onSecondary2200Container ?? this.onSecondary2200Container,
      sourceSecondary2300: sourceSecondary2300 ?? this.sourceSecondary2300,
      secondary2300: secondary2300 ?? this.secondary2300,
      onSecondary2300: onSecondary2300 ?? this.onSecondary2300,
      secondary2300Container: secondary2300Container ?? this.secondary2300Container,
      onSecondary2300Container: onSecondary2300Container ?? this.onSecondary2300Container,
      sourceSecondary2400: sourceSecondary2400 ?? this.sourceSecondary2400,
      secondary2400: secondary2400 ?? this.secondary2400,
      onSecondary2400: onSecondary2400 ?? this.onSecondary2400,
      secondary2400Container: secondary2400Container ?? this.secondary2400Container,
      onSecondary2400Container: onSecondary2400Container ?? this.onSecondary2400Container,
      sourceSecondary2default: sourceSecondary2default ?? this.sourceSecondary2default,
      secondary2default: secondary2default ?? this.secondary2default,
      onSecondary2default: onSecondary2default ?? this.onSecondary2default,
      secondary2defaultContainer: secondary2defaultContainer ?? this.secondary2defaultContainer,
      onSecondary2defaultContainer: onSecondary2defaultContainer ?? this.onSecondary2defaultContainer,
      sourceSuccess100: sourceSuccess100 ?? this.sourceSuccess100,
      success100: success100 ?? this.success100,
      onSuccess100: onSuccess100 ?? this.onSuccess100,
      success100Container: success100Container ?? this.success100Container,
      onSuccess100Container: onSuccess100Container ?? this.onSuccess100Container,
      sourceSuccess200: sourceSuccess200 ?? this.sourceSuccess200,
      success200: success200 ?? this.success200,
      onSuccess200: onSuccess200 ?? this.onSuccess200,
      success200Container: success200Container ?? this.success200Container,
      onSuccess200Container: onSuccess200Container ?? this.onSuccess200Container,
      sourceSuccess300: sourceSuccess300 ?? this.sourceSuccess300,
      success300: success300 ?? this.success300,
      onSuccess300: onSuccess300 ?? this.onSuccess300,
      success300Container: success300Container ?? this.success300Container,
      onSuccess300Container: onSuccess300Container ?? this.onSuccess300Container,
      sourceSuccess400: sourceSuccess400 ?? this.sourceSuccess400,
      success400: success400 ?? this.success400,
      onSuccess400: onSuccess400 ?? this.onSuccess400,
      success400Container: success400Container ?? this.success400Container,
      onSuccess400Container: onSuccess400Container ?? this.onSuccess400Container,
      sourceSuccess500: sourceSuccess500 ?? this.sourceSuccess500,
      success500: success500 ?? this.success500,
      onSuccess500: onSuccess500 ?? this.onSuccess500,
      success500Container: success500Container ?? this.success500Container,
      onSuccess500Container: onSuccess500Container ?? this.onSuccess500Container,
      sourceLink100: sourceLink100 ?? this.sourceLink100,
      link100: link100 ?? this.link100,
      onLink100: onLink100 ?? this.onLink100,
      link100Container: link100Container ?? this.link100Container,
      onLink100Container: onLink100Container ?? this.onLink100Container,
      sourceLink200: sourceLink200 ?? this.sourceLink200,
      link200: link200 ?? this.link200,
      onLink200: onLink200 ?? this.onLink200,
      link200Container: link200Container ?? this.link200Container,
      onLink200Container: onLink200Container ?? this.onLink200Container,
      sourceLink300: sourceLink300 ?? this.sourceLink300,
      link300: link300 ?? this.link300,
      onLink300: onLink300 ?? this.onLink300,
      link300Container: link300Container ?? this.link300Container,
      onLink300Container: onLink300Container ?? this.onLink300Container,
      sourceLink400: sourceLink400 ?? this.sourceLink400,
      link400: link400 ?? this.link400,
      onLink400: onLink400 ?? this.onLink400,
      link400Container: link400Container ?? this.link400Container,
      onLink400Container: onLink400Container ?? this.onLink400Container,
      sourceLink500: sourceLink500 ?? this.sourceLink500,
      link500: link500 ?? this.link500,
      onLink500: onLink500 ?? this.onLink500,
      link500Container: link500Container ?? this.link500Container,
      onLink500Container: onLink500Container ?? this.onLink500Container,
      sourceWarning100: sourceWarning100 ?? this.sourceWarning100,
      warning100: warning100 ?? this.warning100,
      onWarning100: onWarning100 ?? this.onWarning100,
      warning100Container: warning100Container ?? this.warning100Container,
      onWarning100Container: onWarning100Container ?? this.onWarning100Container,
      sourceWarning200: sourceWarning200 ?? this.sourceWarning200,
      warning200: warning200 ?? this.warning200,
      onWarning200: onWarning200 ?? this.onWarning200,
      warning200Container: warning200Container ?? this.warning200Container,
      onWarning200Container: onWarning200Container ?? this.onWarning200Container,
      sourceWarning300: sourceWarning300 ?? this.sourceWarning300,
      warning300: warning300 ?? this.warning300,
      onWarning300: onWarning300 ?? this.onWarning300,
      warning300Container: warning300Container ?? this.warning300Container,
      onWarning300Container: onWarning300Container ?? this.onWarning300Container,
      sourceWarning400: sourceWarning400 ?? this.sourceWarning400,
      warning400: warning400 ?? this.warning400,
      onWarning400: onWarning400 ?? this.onWarning400,
      warning400Container: warning400Container ?? this.warning400Container,
      onWarning400Container: onWarning400Container ?? this.onWarning400Container,
      sourceWarning500: sourceWarning500 ?? this.sourceWarning500,
      warning500: warning500 ?? this.warning500,
      onWarning500: onWarning500 ?? this.onWarning500,
      warning500Container: warning500Container ?? this.warning500Container,
      onWarning500Container: onWarning500Container ?? this.onWarning500Container,
      sourceWarning250: sourceWarning250 ?? this.sourceWarning250,
      warning250: warning250 ?? this.warning250,
      onWarning250: onWarning250 ?? this.onWarning250,
      warning250Container: warning250Container ?? this.warning250Container,
      onWarning250Container: onWarning250Container ?? this.onWarning250Container,
      sourceYellow: sourceYellow ?? this.sourceYellow,
      yellow: yellow ?? this.yellow,
      onYellow: onYellow ?? this.onYellow,
      yellowContainer: yellowContainer ?? this.yellowContainer,
      onYellowContainer: onYellowContainer ?? this.onYellowContainer,
      sourceError100: sourceError100 ?? this.sourceError100,
      error100: error100 ?? this.error100,
      onError100: onError100 ?? this.onError100,
      error100Container: error100Container ?? this.error100Container,
      onError100Container: onError100Container ?? this.onError100Container,
      sourceError200: sourceError200 ?? this.sourceError200,
      error200: error200 ?? this.error200,
      onError200: onError200 ?? this.onError200,
      error200Container: error200Container ?? this.error200Container,
      onError200Container: onError200Container ?? this.onError200Container,
      sourceError300: sourceError300 ?? this.sourceError300,
      error300: error300 ?? this.error300,
      onError300: onError300 ?? this.onError300,
      error300Container: error300Container ?? this.error300Container,
      onError300Container: onError300Container ?? this.onError300Container,
      sourceError400: sourceError400 ?? this.sourceError400,
      error400: error400 ?? this.error400,
      onError400: onError400 ?? this.onError400,
      error400Container: error400Container ?? this.error400Container,
      onError400Container: onError400Container ?? this.onError400Container,
      sourceError500: sourceError500 ?? this.sourceError500,
      error500: error500 ?? this.error500,
      onError500: onError500 ?? this.onError500,
      error500Container: error500Container ?? this.error500Container,
      onError500Container: onError500Container ?? this.onError500Container,
      sourceBackgroundwhite: sourceBackgroundwhite ?? this.sourceBackgroundwhite,
      backgroundwhite: backgroundwhite ?? this.backgroundwhite,
      onBackgroundwhite: onBackgroundwhite ?? this.onBackgroundwhite,
      backgroundwhiteContainer: backgroundwhiteContainer ?? this.backgroundwhiteContainer,
      onBackgroundwhiteContainer: onBackgroundwhiteContainer ?? this.onBackgroundwhiteContainer,
      sourceBackgroundgrey100: sourceBackgroundgrey100 ?? this.sourceBackgroundgrey100,
      backgroundgrey100: backgroundgrey100 ?? this.backgroundgrey100,
      onBackgroundgrey100: onBackgroundgrey100 ?? this.onBackgroundgrey100,
      backgroundgrey100Container: backgroundgrey100Container ?? this.backgroundgrey100Container,
      onBackgroundgrey100Container: onBackgroundgrey100Container ?? this.onBackgroundgrey100Container,
      sourceBackgroundgrey200: sourceBackgroundgrey200 ?? this.sourceBackgroundgrey200,
      backgroundgrey200: backgroundgrey200 ?? this.backgroundgrey200,
      onBackgroundgrey200: onBackgroundgrey200 ?? this.onBackgroundgrey200,
      backgroundgrey200Container: backgroundgrey200Container ?? this.backgroundgrey200Container,
      onBackgroundgrey200Container: onBackgroundgrey200Container ?? this.onBackgroundgrey200Container,
      sourceBackgroundgrey300: sourceBackgroundgrey300 ?? this.sourceBackgroundgrey300,
      backgroundgrey300: backgroundgrey300 ?? this.backgroundgrey300,
      onBackgroundgrey300: onBackgroundgrey300 ?? this.onBackgroundgrey300,
      backgroundgrey300Container: backgroundgrey300Container ?? this.backgroundgrey300Container,
      onBackgroundgrey300Container: onBackgroundgrey300Container ?? this.onBackgroundgrey300Container,
      sourceBackgroundgrey400: sourceBackgroundgrey400 ?? this.sourceBackgroundgrey400,
      backgroundgrey400: backgroundgrey400 ?? this.backgroundgrey400,
      onBackgroundgrey400: onBackgroundgrey400 ?? this.onBackgroundgrey400,
      backgroundgrey400Container: backgroundgrey400Container ?? this.backgroundgrey400Container,
      onBackgroundgrey400Container: onBackgroundgrey400Container ?? this.onBackgroundgrey400Container,
      sourceBackgroundgrey500: sourceBackgroundgrey500 ?? this.sourceBackgroundgrey500,
      backgroundgrey500: backgroundgrey500 ?? this.backgroundgrey500,
      onBackgroundgrey500: onBackgroundgrey500 ?? this.onBackgroundgrey500,
      backgroundgrey500Container: backgroundgrey500Container ?? this.backgroundgrey500Container,
      onBackgroundgrey500Container: onBackgroundgrey500Container ?? this.onBackgroundgrey500Container,
      sourceBackgroundgrey600: sourceBackgroundgrey600 ?? this.sourceBackgroundgrey600,
      backgroundgrey600: backgroundgrey600 ?? this.backgroundgrey600,
      onBackgroundgrey600: onBackgroundgrey600 ?? this.onBackgroundgrey600,
      backgroundgrey600Container: backgroundgrey600Container ?? this.backgroundgrey600Container,
      onBackgroundgrey600Container: onBackgroundgrey600Container ?? this.onBackgroundgrey600Container,
      sourceBackgroundgrey700: sourceBackgroundgrey700 ?? this.sourceBackgroundgrey700,
      backgroundgrey700: backgroundgrey700 ?? this.backgroundgrey700,
      onBackgroundgrey700: onBackgroundgrey700 ?? this.onBackgroundgrey700,
      backgroundgrey700Container: backgroundgrey700Container ?? this.backgroundgrey700Container,
      onBackgroundgrey700Container: onBackgroundgrey700Container ?? this.onBackgroundgrey700Container,
      sourceBackgroundgrey800: sourceBackgroundgrey800 ?? this.sourceBackgroundgrey800,
      backgroundgrey800: backgroundgrey800 ?? this.backgroundgrey800,
      onBackgroundgrey800: onBackgroundgrey800 ?? this.onBackgroundgrey800,
      backgroundgrey800Container: backgroundgrey800Container ?? this.backgroundgrey800Container,
      onBackgroundgrey800Container: onBackgroundgrey800Container ?? this.onBackgroundgrey800Container,
      sourceBackgroundgrey900: sourceBackgroundgrey900 ?? this.sourceBackgroundgrey900,
      backgroundgrey900: backgroundgrey900 ?? this.backgroundgrey900,
      onBackgroundgrey900: onBackgroundgrey900 ?? this.onBackgroundgrey900,
      backgroundgrey900Container: backgroundgrey900Container ?? this.backgroundgrey900Container,
      onBackgroundgrey900Container: onBackgroundgrey900Container ?? this.onBackgroundgrey900Container,
      sourceGeyser: sourceGeyser ?? this.sourceGeyser,
      geyser: geyser ?? this.geyser,
      onGeyser: onGeyser ?? this.onGeyser,
      geyserContainer: geyserContainer ?? this.geyserContainer,
      onGeyserContainer: onGeyserContainer ?? this.onGeyserContainer,
      sourceGrey: sourceGrey ?? this.sourceGrey,
      grey: grey ?? this.grey,
      onGrey: onGrey ?? this.onGrey,
      greyContainer: greyContainer ?? this.greyContainer,
      onGreyContainer: onGreyContainer ?? this.onGreyContainer,
      sourceBackgroundblack: sourceBackgroundblack ?? this.sourceBackgroundblack,
      backgroundblack: backgroundblack ?? this.backgroundblack,
      onBackgroundblack: onBackgroundblack ?? this.onBackgroundblack,
      backgroundblackContainer: backgroundblackContainer ?? this.backgroundblackContainer,
      onBackgroundblackContainer: onBackgroundblackContainer ?? this.onBackgroundblackContainer,
      sourceSkirretgreen: sourceSkirretgreen ?? this.sourceSkirretgreen,
      skirretgreen: skirretgreen ?? this.skirretgreen,
      onSkirretgreen: onSkirretgreen ?? this.onSkirretgreen,
      skirretgreenContainer: skirretgreenContainer ?? this.skirretgreenContainer,
      onSkirretgreenContainer: onSkirretgreenContainer ?? this.onSkirretgreenContainer,
    );
  }

  @override
  CustomColors lerp(ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) {
      return this;
    }
    return CustomColors(
      sourcePrimarymain: Color.lerp(sourcePrimarymain, other.sourcePrimarymain, t),
      primarymain: Color.lerp(primarymain, other.primarymain, t),
      onPrimarymain: Color.lerp(onPrimarymain, other.onPrimarymain, t),
      primarymainContainer: Color.lerp(primarymainContainer, other.primarymainContainer, t),
      onPrimarymainContainer: Color.lerp(onPrimarymainContainer, other.onPrimarymainContainer, t),
      sourcePrimary50: Color.lerp(sourcePrimary50, other.sourcePrimary50, t),
      primary50: Color.lerp(primary50, other.primary50, t),
      onPrimary50: Color.lerp(onPrimary50, other.onPrimary50, t),
      primary50Container: Color.lerp(primary50Container, other.primary50Container, t),
      onPrimary50Container: Color.lerp(onPrimary50Container, other.onPrimary50Container, t),
      sourcePrimary100: Color.lerp(sourcePrimary100, other.sourcePrimary100, t),
      primary100: Color.lerp(primary100, other.primary100, t),
      onPrimary100: Color.lerp(onPrimary100, other.onPrimary100, t),
      primary100Container: Color.lerp(primary100Container, other.primary100Container, t),
      onPrimary100Container: Color.lerp(onPrimary100Container, other.onPrimary100Container, t),
      sourcePrimary200: Color.lerp(sourcePrimary200, other.sourcePrimary200, t),
      primary200: Color.lerp(primary200, other.primary200, t),
      onPrimary200: Color.lerp(onPrimary200, other.onPrimary200, t),
      primary200Container: Color.lerp(primary200Container, other.primary200Container, t),
      onPrimary200Container: Color.lerp(onPrimary200Container, other.onPrimary200Container, t),
      sourcePrimary300: Color.lerp(sourcePrimary300, other.sourcePrimary300, t),
      primary300: Color.lerp(primary300, other.primary300, t),
      onPrimary300: Color.lerp(onPrimary300, other.onPrimary300, t),
      primary300Container: Color.lerp(primary300Container, other.primary300Container, t),
      onPrimary300Container: Color.lerp(onPrimary300Container, other.onPrimary300Container, t),
      sourcePrimary500: Color.lerp(sourcePrimary500, other.sourcePrimary500, t),
      primary500: Color.lerp(primary500, other.primary500, t),
      onPrimary500: Color.lerp(onPrimary500, other.onPrimary500, t),
      primary500Container: Color.lerp(primary500Container, other.primary500Container, t),
      onPrimary500Container: Color.lerp(onPrimary500Container, other.onPrimary500Container, t),
      sourcePrimary600: Color.lerp(sourcePrimary600, other.sourcePrimary600, t),
      primary600: Color.lerp(primary600, other.primary600, t),
      onPrimary600: Color.lerp(onPrimary600, other.onPrimary600, t),
      primary600Container: Color.lerp(primary600Container, other.primary600Container, t),
      onPrimary600Container: Color.lerp(onPrimary600Container, other.onPrimary600Container, t),
      sourcePrimary700: Color.lerp(sourcePrimary700, other.sourcePrimary700, t),
      primary700: Color.lerp(primary700, other.primary700, t),
      onPrimary700: Color.lerp(onPrimary700, other.onPrimary700, t),
      primary700Container: Color.lerp(primary700Container, other.primary700Container, t),
      onPrimary700Container: Color.lerp(onPrimary700Container, other.onPrimary700Container, t),
      sourcePrimary800: Color.lerp(sourcePrimary800, other.sourcePrimary800, t),
      primary800: Color.lerp(primary800, other.primary800, t),
      onPrimary800: Color.lerp(onPrimary800, other.onPrimary800, t),
      primary800Container: Color.lerp(primary800Container, other.primary800Container, t),
      onPrimary800Container: Color.lerp(onPrimary800Container, other.onPrimary800Container, t),
      sourcePrimary900: Color.lerp(sourcePrimary900, other.sourcePrimary900, t),
      primary900: Color.lerp(primary900, other.primary900, t),
      onPrimary900: Color.lerp(onPrimary900, other.onPrimary900, t),
      primary900Container: Color.lerp(primary900Container, other.primary900Container, t),
      onPrimary900Container: Color.lerp(onPrimary900Container, other.onPrimary900Container, t),
      sourceSecondary1100: Color.lerp(sourceSecondary1100, other.sourceSecondary1100, t),
      secondary1100: Color.lerp(secondary1100, other.secondary1100, t),
      onSecondary1100: Color.lerp(onSecondary1100, other.onSecondary1100, t),
      secondary1100Container: Color.lerp(secondary1100Container, other.secondary1100Container, t),
      onSecondary1100Container: Color.lerp(onSecondary1100Container, other.onSecondary1100Container, t),
      sourceSecondary1200: Color.lerp(sourceSecondary1200, other.sourceSecondary1200, t),
      secondary1200: Color.lerp(secondary1200, other.secondary1200, t),
      onSecondary1200: Color.lerp(onSecondary1200, other.onSecondary1200, t),
      secondary1200Container: Color.lerp(secondary1200Container, other.secondary1200Container, t),
      onSecondary1200Container: Color.lerp(onSecondary1200Container, other.onSecondary1200Container, t),
      sourceSecondary1300: Color.lerp(sourceSecondary1300, other.sourceSecondary1300, t),
      secondary1300: Color.lerp(secondary1300, other.secondary1300, t),
      onSecondary1300: Color.lerp(onSecondary1300, other.onSecondary1300, t),
      secondary1300Container: Color.lerp(secondary1300Container, other.secondary1300Container, t),
      onSecondary1300Container: Color.lerp(onSecondary1300Container, other.onSecondary1300Container, t),
      sourceSecondary1default: Color.lerp(sourceSecondary1default, other.sourceSecondary1default, t),
      secondary1default: Color.lerp(secondary1default, other.secondary1default, t),
      onSecondary1default: Color.lerp(onSecondary1default, other.onSecondary1default, t),
      secondary1defaultContainer: Color.lerp(secondary1defaultContainer, other.secondary1defaultContainer, t),
      onSecondary1defaultContainer: Color.lerp(onSecondary1defaultContainer, other.onSecondary1defaultContainer, t),
      sourceSecondary2100: Color.lerp(sourceSecondary2100, other.sourceSecondary2100, t),
      secondary2100: Color.lerp(secondary2100, other.secondary2100, t),
      onSecondary2100: Color.lerp(onSecondary2100, other.onSecondary2100, t),
      secondary2100Container: Color.lerp(secondary2100Container, other.secondary2100Container, t),
      onSecondary2100Container: Color.lerp(onSecondary2100Container, other.onSecondary2100Container, t),
      sourceSecondary2200: Color.lerp(sourceSecondary2200, other.sourceSecondary2200, t),
      secondary2200: Color.lerp(secondary2200, other.secondary2200, t),
      onSecondary2200: Color.lerp(onSecondary2200, other.onSecondary2200, t),
      secondary2200Container: Color.lerp(secondary2200Container, other.secondary2200Container, t),
      onSecondary2200Container: Color.lerp(onSecondary2200Container, other.onSecondary2200Container, t),
      sourceSecondary2300: Color.lerp(sourceSecondary2300, other.sourceSecondary2300, t),
      secondary2300: Color.lerp(secondary2300, other.secondary2300, t),
      onSecondary2300: Color.lerp(onSecondary2300, other.onSecondary2300, t),
      secondary2300Container: Color.lerp(secondary2300Container, other.secondary2300Container, t),
      onSecondary2300Container: Color.lerp(onSecondary2300Container, other.onSecondary2300Container, t),
      sourceSecondary2400: Color.lerp(sourceSecondary2400, other.sourceSecondary2400, t),
      secondary2400: Color.lerp(secondary2400, other.secondary2400, t),
      onSecondary2400: Color.lerp(onSecondary2400, other.onSecondary2400, t),
      secondary2400Container: Color.lerp(secondary2400Container, other.secondary2400Container, t),
      onSecondary2400Container: Color.lerp(onSecondary2400Container, other.onSecondary2400Container, t),
      sourceSecondary2default: Color.lerp(sourceSecondary2default, other.sourceSecondary2default, t),
      secondary2default: Color.lerp(secondary2default, other.secondary2default, t),
      onSecondary2default: Color.lerp(onSecondary2default, other.onSecondary2default, t),
      secondary2defaultContainer: Color.lerp(secondary2defaultContainer, other.secondary2defaultContainer, t),
      onSecondary2defaultContainer: Color.lerp(onSecondary2defaultContainer, other.onSecondary2defaultContainer, t),
      sourceSuccess100: Color.lerp(sourceSuccess100, other.sourceSuccess100, t),
      success100: Color.lerp(success100, other.success100, t),
      onSuccess100: Color.lerp(onSuccess100, other.onSuccess100, t),
      success100Container: Color.lerp(success100Container, other.success100Container, t),
      onSuccess100Container: Color.lerp(onSuccess100Container, other.onSuccess100Container, t),
      sourceSuccess200: Color.lerp(sourceSuccess200, other.sourceSuccess200, t),
      success200: Color.lerp(success200, other.success200, t),
      onSuccess200: Color.lerp(onSuccess200, other.onSuccess200, t),
      success200Container: Color.lerp(success200Container, other.success200Container, t),
      onSuccess200Container: Color.lerp(onSuccess200Container, other.onSuccess200Container, t),
      sourceSuccess300: Color.lerp(sourceSuccess300, other.sourceSuccess300, t),
      success300: Color.lerp(success300, other.success300, t),
      onSuccess300: Color.lerp(onSuccess300, other.onSuccess300, t),
      success300Container: Color.lerp(success300Container, other.success300Container, t),
      onSuccess300Container: Color.lerp(onSuccess300Container, other.onSuccess300Container, t),
      sourceSuccess400: Color.lerp(sourceSuccess400, other.sourceSuccess400, t),
      success400: Color.lerp(success400, other.success400, t),
      onSuccess400: Color.lerp(onSuccess400, other.onSuccess400, t),
      success400Container: Color.lerp(success400Container, other.success400Container, t),
      onSuccess400Container: Color.lerp(onSuccess400Container, other.onSuccess400Container, t),
      sourceSuccess500: Color.lerp(sourceSuccess500, other.sourceSuccess500, t),
      success500: Color.lerp(success500, other.success500, t),
      onSuccess500: Color.lerp(onSuccess500, other.onSuccess500, t),
      success500Container: Color.lerp(success500Container, other.success500Container, t),
      onSuccess500Container: Color.lerp(onSuccess500Container, other.onSuccess500Container, t),
      sourceLink100: Color.lerp(sourceLink100, other.sourceLink100, t),
      link100: Color.lerp(link100, other.link100, t),
      onLink100: Color.lerp(onLink100, other.onLink100, t),
      link100Container: Color.lerp(link100Container, other.link100Container, t),
      onLink100Container: Color.lerp(onLink100Container, other.onLink100Container, t),
      sourceLink200: Color.lerp(sourceLink200, other.sourceLink200, t),
      link200: Color.lerp(link200, other.link200, t),
      onLink200: Color.lerp(onLink200, other.onLink200, t),
      link200Container: Color.lerp(link200Container, other.link200Container, t),
      onLink200Container: Color.lerp(onLink200Container, other.onLink200Container, t),
      sourceLink300: Color.lerp(sourceLink300, other.sourceLink300, t),
      link300: Color.lerp(link300, other.link300, t),
      onLink300: Color.lerp(onLink300, other.onLink300, t),
      link300Container: Color.lerp(link300Container, other.link300Container, t),
      onLink300Container: Color.lerp(onLink300Container, other.onLink300Container, t),
      sourceLink400: Color.lerp(sourceLink400, other.sourceLink400, t),
      link400: Color.lerp(link400, other.link400, t),
      onLink400: Color.lerp(onLink400, other.onLink400, t),
      link400Container: Color.lerp(link400Container, other.link400Container, t),
      onLink400Container: Color.lerp(onLink400Container, other.onLink400Container, t),
      sourceLink500: Color.lerp(sourceLink500, other.sourceLink500, t),
      link500: Color.lerp(link500, other.link500, t),
      onLink500: Color.lerp(onLink500, other.onLink500, t),
      link500Container: Color.lerp(link500Container, other.link500Container, t),
      onLink500Container: Color.lerp(onLink500Container, other.onLink500Container, t),
      sourceWarning100: Color.lerp(sourceWarning100, other.sourceWarning100, t),
      warning100: Color.lerp(warning100, other.warning100, t),
      onWarning100: Color.lerp(onWarning100, other.onWarning100, t),
      warning100Container: Color.lerp(warning100Container, other.warning100Container, t),
      onWarning100Container: Color.lerp(onWarning100Container, other.onWarning100Container, t),
      sourceWarning200: Color.lerp(sourceWarning200, other.sourceWarning200, t),
      warning200: Color.lerp(warning200, other.warning200, t),
      onWarning200: Color.lerp(onWarning200, other.onWarning200, t),
      warning200Container: Color.lerp(warning200Container, other.warning200Container, t),
      onWarning200Container: Color.lerp(onWarning200Container, other.onWarning200Container, t),
      sourceWarning300: Color.lerp(sourceWarning300, other.sourceWarning300, t),
      warning300: Color.lerp(warning300, other.warning300, t),
      onWarning300: Color.lerp(onWarning300, other.onWarning300, t),
      warning300Container: Color.lerp(warning300Container, other.warning300Container, t),
      onWarning300Container: Color.lerp(onWarning300Container, other.onWarning300Container, t),
      sourceWarning400: Color.lerp(sourceWarning400, other.sourceWarning400, t),
      warning400: Color.lerp(warning400, other.warning400, t),
      onWarning400: Color.lerp(onWarning400, other.onWarning400, t),
      warning400Container: Color.lerp(warning400Container, other.warning400Container, t),
      onWarning400Container: Color.lerp(onWarning400Container, other.onWarning400Container, t),
      sourceWarning500: Color.lerp(sourceWarning500, other.sourceWarning500, t),
      warning500: Color.lerp(warning500, other.warning500, t),
      onWarning500: Color.lerp(onWarning500, other.onWarning500, t),
      warning500Container: Color.lerp(warning500Container, other.warning500Container, t),
      onWarning500Container: Color.lerp(onWarning500Container, other.onWarning500Container, t),
      sourceWarning250: Color.lerp(sourceWarning250, other.sourceWarning250, t),
      warning250: Color.lerp(warning250, other.warning250, t),
      onWarning250: Color.lerp(onWarning250, other.onWarning250, t),
      warning250Container: Color.lerp(warning250Container, other.warning250Container, t),
      onWarning250Container: Color.lerp(onWarning250Container, other.onWarning250Container, t),
      sourceYellow: Color.lerp(sourceYellow, other.sourceYellow, t),
      yellow: Color.lerp(yellow, other.yellow, t),
      onYellow: Color.lerp(onYellow, other.onYellow, t),
      yellowContainer: Color.lerp(yellowContainer, other.yellowContainer, t),
      onYellowContainer: Color.lerp(onYellowContainer, other.onYellowContainer, t),
      sourceError100: Color.lerp(sourceError100, other.sourceError100, t),
      error100: Color.lerp(error100, other.error100, t),
      onError100: Color.lerp(onError100, other.onError100, t),
      error100Container: Color.lerp(error100Container, other.error100Container, t),
      onError100Container: Color.lerp(onError100Container, other.onError100Container, t),
      sourceError200: Color.lerp(sourceError200, other.sourceError200, t),
      error200: Color.lerp(error200, other.error200, t),
      onError200: Color.lerp(onError200, other.onError200, t),
      error200Container: Color.lerp(error200Container, other.error200Container, t),
      onError200Container: Color.lerp(onError200Container, other.onError200Container, t),
      sourceError300: Color.lerp(sourceError300, other.sourceError300, t),
      error300: Color.lerp(error300, other.error300, t),
      onError300: Color.lerp(onError300, other.onError300, t),
      error300Container: Color.lerp(error300Container, other.error300Container, t),
      onError300Container: Color.lerp(onError300Container, other.onError300Container, t),
      sourceError400: Color.lerp(sourceError400, other.sourceError400, t),
      error400: Color.lerp(error400, other.error400, t),
      onError400: Color.lerp(onError400, other.onError400, t),
      error400Container: Color.lerp(error400Container, other.error400Container, t),
      onError400Container: Color.lerp(onError400Container, other.onError400Container, t),
      sourceError500: Color.lerp(sourceError500, other.sourceError500, t),
      error500: Color.lerp(error500, other.error500, t),
      onError500: Color.lerp(onError500, other.onError500, t),
      error500Container: Color.lerp(error500Container, other.error500Container, t),
      onError500Container: Color.lerp(onError500Container, other.onError500Container, t),
      sourceBackgroundwhite: Color.lerp(sourceBackgroundwhite, other.sourceBackgroundwhite, t),
      backgroundwhite: Color.lerp(backgroundwhite, other.backgroundwhite, t),
      onBackgroundwhite: Color.lerp(onBackgroundwhite, other.onBackgroundwhite, t),
      backgroundwhiteContainer: Color.lerp(backgroundwhiteContainer, other.backgroundwhiteContainer, t),
      onBackgroundwhiteContainer: Color.lerp(onBackgroundwhiteContainer, other.onBackgroundwhiteContainer, t),
      sourceBackgroundgrey100: Color.lerp(sourceBackgroundgrey100, other.sourceBackgroundgrey100, t),
      backgroundgrey100: Color.lerp(backgroundgrey100, other.backgroundgrey100, t),
      onBackgroundgrey100: Color.lerp(onBackgroundgrey100, other.onBackgroundgrey100, t),
      backgroundgrey100Container: Color.lerp(backgroundgrey100Container, other.backgroundgrey100Container, t),
      onBackgroundgrey100Container: Color.lerp(onBackgroundgrey100Container, other.onBackgroundgrey100Container, t),
      sourceBackgroundgrey200: Color.lerp(sourceBackgroundgrey200, other.sourceBackgroundgrey200, t),
      backgroundgrey200: Color.lerp(backgroundgrey200, other.backgroundgrey200, t),
      onBackgroundgrey200: Color.lerp(onBackgroundgrey200, other.onBackgroundgrey200, t),
      backgroundgrey200Container: Color.lerp(backgroundgrey200Container, other.backgroundgrey200Container, t),
      onBackgroundgrey200Container: Color.lerp(onBackgroundgrey200Container, other.onBackgroundgrey200Container, t),
      sourceBackgroundgrey300: Color.lerp(sourceBackgroundgrey300, other.sourceBackgroundgrey300, t),
      backgroundgrey300: Color.lerp(backgroundgrey300, other.backgroundgrey300, t),
      onBackgroundgrey300: Color.lerp(onBackgroundgrey300, other.onBackgroundgrey300, t),
      backgroundgrey300Container: Color.lerp(backgroundgrey300Container, other.backgroundgrey300Container, t),
      onBackgroundgrey300Container: Color.lerp(onBackgroundgrey300Container, other.onBackgroundgrey300Container, t),
      sourceBackgroundgrey400: Color.lerp(sourceBackgroundgrey400, other.sourceBackgroundgrey400, t),
      backgroundgrey400: Color.lerp(backgroundgrey400, other.backgroundgrey400, t),
      onBackgroundgrey400: Color.lerp(onBackgroundgrey400, other.onBackgroundgrey400, t),
      backgroundgrey400Container: Color.lerp(backgroundgrey400Container, other.backgroundgrey400Container, t),
      onBackgroundgrey400Container: Color.lerp(onBackgroundgrey400Container, other.onBackgroundgrey400Container, t),
      sourceBackgroundgrey500: Color.lerp(sourceBackgroundgrey500, other.sourceBackgroundgrey500, t),
      backgroundgrey500: Color.lerp(backgroundgrey500, other.backgroundgrey500, t),
      onBackgroundgrey500: Color.lerp(onBackgroundgrey500, other.onBackgroundgrey500, t),
      backgroundgrey500Container: Color.lerp(backgroundgrey500Container, other.backgroundgrey500Container, t),
      onBackgroundgrey500Container: Color.lerp(onBackgroundgrey500Container, other.onBackgroundgrey500Container, t),
      sourceBackgroundgrey600: Color.lerp(sourceBackgroundgrey600, other.sourceBackgroundgrey600, t),
      backgroundgrey600: Color.lerp(backgroundgrey600, other.backgroundgrey600, t),
      onBackgroundgrey600: Color.lerp(onBackgroundgrey600, other.onBackgroundgrey600, t),
      backgroundgrey600Container: Color.lerp(backgroundgrey600Container, other.backgroundgrey600Container, t),
      onBackgroundgrey600Container: Color.lerp(onBackgroundgrey600Container, other.onBackgroundgrey600Container, t),
      sourceBackgroundgrey700: Color.lerp(sourceBackgroundgrey700, other.sourceBackgroundgrey700, t),
      backgroundgrey700: Color.lerp(backgroundgrey700, other.backgroundgrey700, t),
      onBackgroundgrey700: Color.lerp(onBackgroundgrey700, other.onBackgroundgrey700, t),
      backgroundgrey700Container: Color.lerp(backgroundgrey700Container, other.backgroundgrey700Container, t),
      onBackgroundgrey700Container: Color.lerp(onBackgroundgrey700Container, other.onBackgroundgrey700Container, t),
      sourceBackgroundgrey800: Color.lerp(sourceBackgroundgrey800, other.sourceBackgroundgrey800, t),
      backgroundgrey800: Color.lerp(backgroundgrey800, other.backgroundgrey800, t),
      onBackgroundgrey800: Color.lerp(onBackgroundgrey800, other.onBackgroundgrey800, t),
      backgroundgrey800Container: Color.lerp(backgroundgrey800Container, other.backgroundgrey800Container, t),
      onBackgroundgrey800Container: Color.lerp(onBackgroundgrey800Container, other.onBackgroundgrey800Container, t),
      sourceBackgroundgrey900: Color.lerp(sourceBackgroundgrey900, other.sourceBackgroundgrey900, t),
      backgroundgrey900: Color.lerp(backgroundgrey900, other.backgroundgrey900, t),
      onBackgroundgrey900: Color.lerp(onBackgroundgrey900, other.onBackgroundgrey900, t),
      backgroundgrey900Container: Color.lerp(backgroundgrey900Container, other.backgroundgrey900Container, t),
      onBackgroundgrey900Container: Color.lerp(onBackgroundgrey900Container, other.onBackgroundgrey900Container, t),
      sourceGeyser: Color.lerp(sourceGeyser, other.sourceGeyser, t),
      geyser: Color.lerp(geyser, other.geyser, t),
      onGeyser: Color.lerp(onGeyser, other.onGeyser, t),
      geyserContainer: Color.lerp(geyserContainer, other.geyserContainer, t),
      onGeyserContainer: Color.lerp(onGeyserContainer, other.onGeyserContainer, t),
      sourceGrey: Color.lerp(sourceGrey, other.sourceGrey, t),
      grey: Color.lerp(grey, other.grey, t),
      onGrey: Color.lerp(onGrey, other.onGrey, t),
      greyContainer: Color.lerp(greyContainer, other.greyContainer, t),
      onGreyContainer: Color.lerp(onGreyContainer, other.onGreyContainer, t),
      sourceBackgroundblack: Color.lerp(sourceBackgroundblack, other.sourceBackgroundblack, t),
      backgroundblack: Color.lerp(backgroundblack, other.backgroundblack, t),
      onBackgroundblack: Color.lerp(onBackgroundblack, other.onBackgroundblack, t),
      backgroundblackContainer: Color.lerp(backgroundblackContainer, other.backgroundblackContainer, t),
      onBackgroundblackContainer: Color.lerp(onBackgroundblackContainer, other.onBackgroundblackContainer, t),
      sourceSkirretgreen: Color.lerp(sourceSkirretgreen, other.sourceSkirretgreen, t),
      skirretgreen: Color.lerp(skirretgreen, other.skirretgreen, t),
      onSkirretgreen: Color.lerp(onSkirretgreen, other.onSkirretgreen, t),
      skirretgreenContainer: Color.lerp(skirretgreenContainer, other.skirretgreenContainer, t),
      onSkirretgreenContainer: Color.lerp(onSkirretgreenContainer, other.onSkirretgreenContainer, t),
    );
  }

  /// Returns an instance of [CustomColors] in which the following custom
  /// colors are harmonized with [dynamic]'s [ColorScheme.primary].
  ///
  /// See also:
  ///   * <https://m3.material.io/styles/color/the-color-system/custom-colors#harmonization>
  CustomColors harmonized(ColorScheme dynamic) {
    return copyWith(
    );
  }
}

extension CustomColorExtension on ThemeData? {
  CustomColors getCustomColor(BuildContext context) {
    return Theme.of(context).extension<CustomColors>()!;
  }
}


