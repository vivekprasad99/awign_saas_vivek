import 'package:equatable/equatable.dart';

class SearchNotificationResponse {
  List<NotificationEntity>? notifications;

  SearchNotificationResponse({this.notifications});

  SearchNotificationResponse.fromJson(Map<String, dynamic> json) {
    if (json['notifications'] != null) {
      notifications = <NotificationEntity>[];
      json['notifications'].forEach((v) {
        notifications!.add(NotificationEntity.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (notifications != null) {
      data['notifications'] =
          notifications!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NotificationEntity extends Equatable {
  String? title;
  String? message;
  NotificationData? notificationData;
  String? status;

  NotificationEntity({this.title, this.message, this.notificationData, this.status});

  NotificationEntity.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    message = json['message'];
    notificationData = json['data'] != null
        ? NotificationData.fromJson(json['data'])
        : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['message'] = message;
    if (notificationData != null) {
      data['data'] = notificationData!.toJson();
    }
    data['status'] = status;
    return data;
  }

  @override
  List<Object?> get props => [title, message, notificationData, status];
}

class NotificationData extends Equatable {
  String? title;
  String? message;
  String? deeplink;

  NotificationData({this.title, this.message, this.deeplink});

  NotificationData.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    message = json['message'];
    deeplink = json['deeplink'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['message'] = message;
    data['deeplink'] = deeplink;
    return data;
  }

  @override
  List<Object?> get props => [title, message, deeplink];
}