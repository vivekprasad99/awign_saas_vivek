// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$NotificationsStateCWProxy {
  NotificationsState uiState(UIState? uiState);

  NotificationsState isLoading(bool? isLoading);

  NotificationsState notificationList(
      List<NotificationEntity>? notificationList);

  NotificationsState notificationFilterList(
      List<NotificationFilter>? notificationFilterList);

  NotificationsState selectedNotificationFilter(
      NotificationFilter? selectedNotificationFilter);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `NotificationsState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// NotificationsState(...).copyWith(id: 12, name: "My name")
  /// ````
  NotificationsState call({
    UIState? uiState,
    bool? isLoading,
    List<NotificationEntity>? notificationList,
    List<NotificationFilter>? notificationFilterList,
    NotificationFilter? selectedNotificationFilter,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfNotificationsState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfNotificationsState.copyWith.fieldName(...)`
class _$NotificationsStateCWProxyImpl implements _$NotificationsStateCWProxy {
  const _$NotificationsStateCWProxyImpl(this._value);

  final NotificationsState _value;

  @override
  NotificationsState uiState(UIState? uiState) => this(uiState: uiState);

  @override
  NotificationsState isLoading(bool? isLoading) => this(isLoading: isLoading);

  @override
  NotificationsState notificationList(
          List<NotificationEntity>? notificationList) =>
      this(notificationList: notificationList);

  @override
  NotificationsState notificationFilterList(
          List<NotificationFilter>? notificationFilterList) =>
      this(notificationFilterList: notificationFilterList);

  @override
  NotificationsState selectedNotificationFilter(
          NotificationFilter? selectedNotificationFilter) =>
      this(selectedNotificationFilter: selectedNotificationFilter);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `NotificationsState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// NotificationsState(...).copyWith(id: 12, name: "My name")
  /// ````
  NotificationsState call({
    Object? uiState = const $CopyWithPlaceholder(),
    Object? isLoading = const $CopyWithPlaceholder(),
    Object? notificationList = const $CopyWithPlaceholder(),
    Object? notificationFilterList = const $CopyWithPlaceholder(),
    Object? selectedNotificationFilter = const $CopyWithPlaceholder(),
  }) {
    return NotificationsState(
      uiState: uiState == const $CopyWithPlaceholder()
          ? _value.uiState
          // ignore: cast_nullable_to_non_nullable
          : uiState as UIState?,
      isLoading: isLoading == const $CopyWithPlaceholder()
          ? _value.isLoading
          // ignore: cast_nullable_to_non_nullable
          : isLoading as bool?,
      notificationList: notificationList == const $CopyWithPlaceholder()
          ? _value.notificationList
          // ignore: cast_nullable_to_non_nullable
          : notificationList as List<NotificationEntity>?,
      notificationFilterList:
          notificationFilterList == const $CopyWithPlaceholder()
              ? _value.notificationFilterList
              // ignore: cast_nullable_to_non_nullable
              : notificationFilterList as List<NotificationFilter>?,
      selectedNotificationFilter:
          selectedNotificationFilter == const $CopyWithPlaceholder()
              ? _value.selectedNotificationFilter
              // ignore: cast_nullable_to_non_nullable
              : selectedNotificationFilter as NotificationFilter?,
    );
  }
}

extension $NotificationsStateCopyWith on NotificationsState {
  /// Returns a callable class that can be used as follows: `instanceOfNotificationsState.copyWith(...)` or like so:`instanceOfNotificationsState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$NotificationsStateCWProxy get copyWith =>
      _$NotificationsStateCWProxyImpl(this);
}
