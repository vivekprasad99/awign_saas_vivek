import 'package:awign_saas/core/extension/string_extension.dart';
import 'package:awign_saas/hrms/dashboard/data/notification_type.dart';

class NotificationFilter {
  NotificationType? notificationType;
  bool isSelected;

  NotificationFilter({required this.notificationType, this.isSelected = false});

  String? getTitle() {
    return notificationType?.value.replaceAll('_', ' ').toTitleCase();
  }
}
