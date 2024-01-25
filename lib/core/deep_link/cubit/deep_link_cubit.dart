import 'dart:async';

import 'package:awign_saas/hrms/dashboard/data/search_notification_response.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import '../../data/local/database/user_preferences/user_preferences.dart';
import '../../router/router.dart';

part 'deep_link_state.dart';

class DeepLinkCubit extends Cubit<DeepLinkState> {
  static const leave = 'leave';
  static const regulariszation = 'regularization';
  static const reimbursement = 'reimbursement';

  Uri? initialURI;
  String? deepLinkURL;

  StreamSubscription? _streamSubscription;

  DeepLinkCubit() : super(DeepLinkInitial());

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }

  /// Todo later
  // Future<void> initURIHandler() async {
  //   try {
  //     initialURI = await getInitialUri();
  //     AppLog.i("Initial URI received $initialURI");
  //   } on PlatformException {
  //     AppLog.e("Failed to receive initial uri");
  //   } on FormatException catch (err) {
  //     AppLog.e('Malformed Initial URI received');
  //   }
  // }

  /// Todo later
  // void incomingLinkHandler() {
  //   if (kIsWeb) {
  //   } else {
  //     _streamSubscription = uriLinkStream.listen((Uri? uri) {
  //       AppLog.i('Received URI: $uri');
  //         if (uri != null) {
  //         launchWidgetFromDeepLink(uri.path);
  //       }
  //     }, onError: (Object err) {
  //       AppLog.e('Error occurred: $err');
  //     });
  //   }
  // }

  void launchWidgetFromDeepLink(NotificationData notificationData, {bool fromNotificationWidget = false}) async {
    if(UserPreferences.getInstance().getCurrentUser() != null) {
      if(notificationData.deeplink != null) {
        if(notificationData.deeplink!.contains(leave)) {
          if(!fromNotificationWidget) {
            MRouter.pushNamedAndRemoveUntil(MRouter.dashboardWidget);
          }
          MRouter.pushNamed(MRouter.leavesListingWidget);
          MRouter.pushNamed(MRouter.leaveDetailsWidget, arguments: int.parse(notificationData.deeplink!.split("/").last));
        } else if(notificationData.deeplink!.contains(regulariszation)) {
          if(!fromNotificationWidget) {
            MRouter.pushNamedAndRemoveUntil(MRouter.dashboardWidget);
          }
          MRouter.pushNamed(MRouter.regularisationDashboardWidget);
        } else if(notificationData.deeplink!.contains(reimbursement)) {
          if(!fromNotificationWidget) {
            MRouter.pushNamedAndRemoveUntil(MRouter.dashboardWidget);
          }
          MRouter.pushNamed(MRouter.reimbursementsWidget);
          MRouter.pushNamed(MRouter.reimbursementsDetailWidget, arguments: notificationData.deeplink!.split("/").last);
        }
      } else {
        MRouter.pushNamedAndRemoveUntil(MRouter.dashboardWidget);
      }
    } else {
      MRouter.pushNamedAndRemoveUntil(MRouter.loginViaMobileWidget);
    }
  }
}
