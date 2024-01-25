import 'dart:io';

import 'package:awign_saas/core/router/router.dart';
import 'package:awign_saas/core/utils/device_info_utils.dart';
import 'package:awign_saas/core/widget/buttons/custom_text_button.dart';
import 'package:awign_saas/hrms/auth/data/model/device_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:url_launcher/url_launcher.dart';
import '../../../data/model/app_upgrade_data.dart';
import '../../../data/network/firebase/remote_config/remote_config_helper.dart';
import '../../../utils/app_log.dart';
import '../../../utils/constants.dart';
import '../../theme/theme_manager.dart';

class AppUpgradeDialogHelper {
  static bool showAppUpgradeDialog = true;
  void checkVersionAndShowAppUpgradeDialog(BuildContext context) async {
    try {
      if(!showAppUpgradeDialog) {
        return;
      }
      /// Get Current installed version of app
      final DeviceInfo? deviceInfo = await DeviceInfoUtils.getDeviceInfoData();
      if(deviceInfo?.versionName == null) {
        return;
      }
      double currentVersion = double.parse(deviceInfo!.versionName!.trim().replaceAll(".", ""));
      AppUpgradeData? appUpgradeData =  RemoteConfigHelper.instance().appUpgradeData;
      if (kIsWeb) {
      } else if(appUpgradeData?.androidAppUpgradeData?.versionName != null && Platform.isAndroid) {
        int currentBuildNumber = int.parse(deviceInfo.versionNumber!);
        double newVersion = double.parse(appUpgradeData!.androidAppUpgradeData!.versionName!.trim().replaceAll(".", ""));
        int newBuildNumber = appUpgradeData.androidAppUpgradeData!.versionNumber!;
        bool showUpgradeDialog = false;
        if (newVersion > currentVersion) {
          showUpgradeDialog = true;
        } else if (newBuildNumber > currentBuildNumber) {
          showUpgradeDialog = true;
        }
        if(showUpgradeDialog) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) => AppUpgradeDialog(
                appUpgradeData: appUpgradeData!),
          );
        }
      } else if(appUpgradeData?.iosAppUpgradeData?.versionName != null && Platform.isIOS) {
        double newVersion = double.parse(appUpgradeData!.iosAppUpgradeData!.versionName!.trim().replaceAll(".", ""));
        if (newVersion > currentVersion) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) => AppUpgradeDialog(
                appUpgradeData: appUpgradeData!),
          );
        }
      }
    } catch (e, st) {
      AppLog.e('checkVersionAndShowAppUpgradeDialog : ${e.toString()} \n${st.toString()}');
    }
  }
}

class AppUpgradeDialog extends StatelessWidget {
  final AppUpgradeData appUpgradeData;

  const AppUpgradeDialog({required this.appUpgradeData, super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: Dimens.elevation_8,
      insetAnimationCurve: Curves.easeInOut,
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      insetPadding: const EdgeInsets.all(Dimens.padding_20),
      child: buildDialogContent(context),
    );
  }

  Widget buildDialogContent(BuildContext context) {
    String title = 'app_update'.tr;
    String subTitle = 'please_update_to_continue_using_the_app'.tr;
    String? releaseInfo;
    if (kIsWeb) {
    } else if(Platform.isAndroid) {
      if(appUpgradeData.androidAppUpgradeData?.title != null) {
        title = appUpgradeData.androidAppUpgradeData!.title!;
      }
      if(appUpgradeData.androidAppUpgradeData?.subTitle != null) {
        subTitle = appUpgradeData.androidAppUpgradeData!.subTitle!;
      }
      if(appUpgradeData.androidAppUpgradeData?.releaseInfo != null) {
        releaseInfo = appUpgradeData.androidAppUpgradeData!.releaseInfo!;
      }
    } else if(Platform.isIOS) {
      if(appUpgradeData.iosAppUpgradeData?.title != null) {
        title = appUpgradeData.iosAppUpgradeData!.title!;
      }
      if(appUpgradeData.iosAppUpgradeData?.subTitle != null) {
        subTitle = appUpgradeData.iosAppUpgradeData!.subTitle!;
      }
      if(appUpgradeData.iosAppUpgradeData?.releaseInfo != null) {
        releaseInfo = appUpgradeData.iosAppUpgradeData!.releaseInfo!;
      }
    }
    return Container(
      padding: const EdgeInsets.all(Dimens.padding_16),
      decoration: BoxDecoration(
        color: Get.theme.colorScheme.background,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(Dimens.radius_8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // To make the card compact
        children: <Widget>[
          const SizedBox(height: Dimens.margin_16),
          Text(
            title,
            textAlign: TextAlign.center,
            style: Get.textTheme.bodyLarge?.copyWith(fontSize: Dimens.font_20, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: Dimens.margin_16),
          Text(
            subTitle,
            textAlign: TextAlign.center,
            style: Get.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w400),
          ),
          buildReleaseInfo(releaseInfo),
          const SizedBox(height: Dimens.margin_16),
          Row(
            children: [
              buildLaterButton(context),
              const SizedBox(width: Dimens.margin_16),
              buildUpdateButton(context),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildReleaseInfo(String? releaseInfo) {
    if(releaseInfo != null) {
      return Column(
        children: [
          const SizedBox(height: Dimens.padding_16),
          Text(
            releaseInfo,
            textAlign: TextAlign.center,
            style: Get.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w400),
          ),
        ],
      );
    } else {
      return const SizedBox();
    }
  }

  Widget buildUpdateButton(BuildContext context) {
    return Expanded(
      child: CustomTextButton(
        text: 'update'.tr,
        backgroundColor: Get.theme.colorScheme.primary,
        borderColor: Get.theme.colorScheme.primary,
        textColor: Get.theme.getCustomColor(context).backgroundwhite,
        onPressed: () {
          _launchPlayStoreOrAppStore();
        },
      ),
    );
  }

  Widget buildLaterButton(BuildContext context) {
    bool isShowLaterButton = false;
    if (kIsWeb) {
    } else if(Platform.isAndroid) {
      if(appUpgradeData.androidAppUpgradeData?.releaseType == ReleaseType.recommended) {
        isShowLaterButton = true;
      }
    } else if(Platform.isIOS) {
      if(appUpgradeData.iosAppUpgradeData?.releaseType == ReleaseType.recommended) {
        isShowLaterButton = true;
      }
    }
    if(isShowLaterButton) {
      AppUpgradeDialogHelper.showAppUpgradeDialog = false;
      return Expanded(
        child: CustomTextButton(
          text: 'later'.tr,
          backgroundColor: AppColors.transparent,
          borderColor: Get.theme.colorScheme.primary,
          textColor: Get.theme.colorScheme.primary,
          onPressed: () {
            MRouter.pop(null);
          },
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  _launchPlayStoreOrAppStore() {
    if (kIsWeb) {
    } else if(Platform.isAndroid) {
      launchUrl(Uri.parse(Constants.awignHRMSPlayStoreURL), mode: LaunchMode.externalApplication);
    } else if(Platform.isIOS) {
      launchUrl(Uri.parse(Constants.awignHRMSAppStoreURL), mode: LaunchMode.externalApplication);
    }
  }
}
