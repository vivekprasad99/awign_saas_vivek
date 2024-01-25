import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/data/model/ui_state.dart';
import '../../../data/notification_filter.dart';
import '../../../data/search_notification_response.dart';

part 'notifications_state.g.dart';

@CopyWith()
class NotificationsState extends Equatable {
  final UIState? uiState;
  final bool? isLoading;
  final List<NotificationEntity>? notificationList;
  final List<NotificationFilter>? notificationFilterList;
  final NotificationFilter? selectedNotificationFilter;
  const NotificationsState({this.uiState, this.isLoading, this.notificationList,
    this.notificationFilterList, this.selectedNotificationFilter});

  @override
  List<Object?> get props => [uiState, isLoading, notificationList, notificationFilterList,
    selectedNotificationFilter];
}
