

class FCMNotificationHelper {
  static const openWorkList = "";
  static const actionApplicationWorkListing = "";

  // static void launchWidgetFromFCMAction(
  //     String? action, FCMViewBody? fcmViewBody) async {
  //   SPUtil? spUtil = await SPUtil.getInstance();
  //   UserData? currentUser = spUtil?.getUserData();
  //   if (currentUser?.id == null || currentUser?.id == -1) {
  //     MRouter.pushNamedAndRemoveUntil(MRouter.onboardingIntroWidget);
  //   } else if (currentUser?.email == null) {
  //     MRouter.pushNamedAndRemoveUntil(MRouter.userEmailWidget);
  //   } else {
  //     switch (action) {
  //       case openWorkList:
  //         _openWorkListing(currentUser, fcmViewBody);
  //         break;
  //       case actionApplicationWorkListing:
  //       case openCategory:
  //       case openJobs:
  //         _openJobs(currentUser, fcmViewBody);
  //         break;
  //       case openCategoryDetails:
  //         _openCategoryDetails(currentUser, fcmViewBody);
  //         break;
  //       case openBanner:
  //         break;
  //       default:
  //         MRouter.pushNamedAndRemoveUntil(MRouter.categoryListingWidget);
  //     }
  //   }
  // }

  // static _openWorkListing(UserData? currentUser, FCMViewBody? fcmViewBody) {
  //   if ((currentUser?.permissions?.awign
  //           ?.contains(AwignPermissionConstants.listings) ??
  //       false)) {
  //     MRouter.pushNamedAndRemoveUntil(MRouter.categoryListingWidget);
  //     MRouter.pushNamed(MRouter.workListingDetailsWidget,
  //         arguments: WorkListingDetailsArguments(
  //             fcmViewBody?.intentData?.workListingID?.toString() ?? ''));
  //   } else {
  //     MRouter.pushNamedAndRemoveUntil(MRouter.categoryListingWidget);
  //   }
  // }
}
