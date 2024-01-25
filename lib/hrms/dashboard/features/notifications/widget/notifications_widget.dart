import 'package:awign_saas/core/extension/common_extension.dart';
import 'package:awign_saas/core/widget/scaffold/app_scaffold.dart';
import 'package:awign_saas/core/widget/theme/theme_manager.dart';
import 'package:awign_saas/hrms/dashboard/data/search_notification_response.dart';
import 'package:awign_saas/hrms/dashboard/features/notifications/widget/tile/notification_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../../core/data/model/ui_state.dart';
import '../../../../../core/deep_link/cubit/deep_link_cubit.dart';
import '../../../../../core/di/app_injection_container.dart';
import '../../../../../core/widget/app_bar/tenant_app_bar.dart';
import '../../../../../core/widget/dialog/loading/app_circular_progress_indicator.dart';
import '../../../../../core/widget/network_sensitive/internet_sensitive.dart';
import '../../../data/notification_filter.dart';
import '../cubit/notifications_cubit.dart';
import '../cubit/notifications_state.dart';
import 'tile/notification_filter_tile.dart';

class NotificationsWidget extends StatelessWidget {
  const NotificationsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<NotificationsCubit>().loadNotificationFilterList();
    return buildWidgetsForMobile();
  }

  Widget buildWidgetsForMobile() {
    return BlocConsumer<NotificationsCubit, NotificationsState>(
      listenWhen: (previous, current) {
        return previous.uiState != current.uiState;
      },
      listener: (context, state) {

      },
      buildWhen: (prev, cur) {
        return cur.uiState?.event == Event.reloadWidget;
      },
      builder: (context, state) {
        return AppScaffold(
          backgroundColor: Theme.of(context).extension<CustomColors>()!.secondary1200Container,
          body: SafeArea(
            child: Container(
              color: Get.theme.colorScheme.background,
              child: Column(
                children: [
                  const TenantAppBar(isTenantLogoVisible: true, isTenantNameVisible: true),
                  Expanded(
                    child: InternetSensitive(
                      child: Column(
                        children: [
                          buildNotificationFilterList(),
                          buildNotificationList(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildNotificationFilterList() {
    return BlocBuilder<NotificationsCubit, NotificationsState>(
      buildWhen: (preState, curState) {
        return (preState.notificationFilterList != curState.notificationFilterList);
      },
      builder: (context, state) {
        if (!state.notificationFilterList.isNullOrEmpty) {
          return Container(
              padding: const EdgeInsets.fromLTRB(Dimens.padding_16, Dimens.padding_16,
                  Dimens.padding_16, 0),
              child: SizedBox(
                height: Dimens.margin_40,
                child: ListView.builder(
                  itemCount: state.notificationFilterList!.length,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return NotificationFilterTile(
                      notificationFilter: state.notificationFilterList![index],
                      index: index,
                      onNotificationFilterTapped: _onNotificationFilterTapped,
                    );
                  },),
              )
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  _onNotificationFilterTapped(BuildContext context, int index, NotificationFilter notificationFilter) {
    context.read<NotificationsCubit>().updateNotificationFilterList(index, notificationFilter);
  }

  Widget buildNotificationList() {
    return BlocBuilder<NotificationsCubit, NotificationsState>(
      buildWhen: (preState, curState) {
        return (preState.notificationList != curState.notificationList);
      },
      builder: (context, state) {
        if(state.isLoading ?? false) {
          return const Expanded(child: AppCircularProgressIndicator());
        } else if(!state.notificationList.isNullOrEmpty) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimens.padding_16),
              child: ListView.separated(
                itemCount: state.notificationList!.length,
                padding: const EdgeInsets.symmetric(vertical: Dimens.padding_16),
                itemBuilder: (context, i) {
                  return NotificationTile(index: i, notificationEntity: state.notificationList![i],
                      onNotificationTapped: _onNotificationTapped);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: Dimens.padding_16);
                },
              ),
            ),
          );
        } else {
          return buildEmptyWidgets(context);
        }
      },
    );
  }

  _onNotificationTapped(BuildContext context, int index, NotificationEntity notificationEntity) {
    if(notificationEntity.notificationData?.deeplink != null) {
      sl<DeepLinkCubit>().launchWidgetFromDeepLink(notificationEntity.notificationData!, fromNotificationWidget: true);
    }
  }

  Widget buildEmptyWidgets(BuildContext context) {
    String message = 'notification_not_available'.tr;
    return Expanded(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              'assets/images/ic_no_data_found.svg',
            ),
            const SizedBox(height: Dimens.padding_16),
            Text(message, style: Get.textTheme.titleMedium?.copyWith(color:
            Theme.of(context).getCustomColor(context).secondary1300, fontSize: Dimens.font_18),),
          ],
        ),
      ),
    );
  }
}
