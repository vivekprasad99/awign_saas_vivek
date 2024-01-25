import 'package:awign_saas/hrms/dashboard/data/notification_filter.dart';
import 'package:awign_saas/hrms/dashboard/data/search_notification_response.dart';
import 'package:awign_saas/hrms/dashboard/data/notification_type.dart';
import 'package:bloc/bloc.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../../../../core/data/model/advance_search/advance_search_request.dart';
import '../../../../../core/data/model/advance_search/operator.dart';
import '../../../../../core/data/model/ui_state.dart';
import '../../../../../core/exception/exception.dart';
import '../../../../../core/utils/app_log.dart';
import '../../../../auth/data/network/repository/auth_remote_repository.dart';
import 'notifications_state.dart';


class NotificationsCubit extends Cubit<NotificationsState> {
  final AuthRemoteRepository _authRemoteRepository;
  NotificationsCubit(this._authRemoteRepository) : super(const NotificationsState());

  loadNotificationFilterList() {
    List<NotificationType> notificationTypeList = [NotificationType.all, NotificationType.punchIn,
      NotificationType.punchOut, NotificationType.leave, NotificationType.regularization, NotificationType.reimbursement];
    List<NotificationFilter> notificationFilterList = [];
    for(int i = 0; i < notificationTypeList.length; i++) {
      notificationFilterList.add(NotificationFilter(notificationType: notificationTypeList[i], isSelected: i == 0 ? true : false));
    }
    emit(state.copyWith(notificationFilterList: notificationFilterList, selectedNotificationFilter: notificationFilterList.first));
    getNotificationList();
  }

  void getNotificationList() async {
    try {
      emit(state.copyWith(isLoading: true));
      AdvanceSearchRequestBuilder advancedSearchRequest = AdvanceSearchRequestBuilder();
      if(state.selectedNotificationFilter?.notificationType != NotificationType.all) {
        advancedSearchRequest
            .putPropertyToCondition(AdvancedSearchRequest.type, Operator.IN, [state.selectedNotificationFilter!.notificationType!.value]);
      }
      SearchNotificationResponse notificationResponse = await _authRemoteRepository.searchNotifications(advancedSearchRequest.build());
      emit(state.copyWith(isLoading: false, notificationList: notificationResponse.notifications));
    } on ServerException catch (e) {
      emit(state.copyWith(isLoading: false, notificationList: null, uiState: UIState(failedWithoutAlertMessage: e.message!)));
    } on FailureException catch (e) {
      emit(state.copyWith(isLoading: false, notificationList: null, uiState: UIState(failedWithoutAlertMessage: e.message!)));
    } catch (e, st) {
      AppLog.e('getNotificationList : ${e.toString()} \n${st.toString()}');
      emit(state.copyWith(isLoading: false, notificationList: null, uiState: UIState(failedWithoutAlertMessage: 'we_regret_the_technical_error'.tr)));
    }
  }

  void updateNotificationFilterList(int index, NotificationFilter notificationFilter) {
    List<NotificationFilter> notificationFilterList = state.notificationFilterList!;
    List<NotificationFilter> tempNotificationFilterList = [];
    tempNotificationFilterList.addAll(notificationFilterList);
    for(int i = 0; i < notificationFilterList.length; i++) {
      NotificationFilter notificationFilter = tempNotificationFilterList[i];
      notificationFilter.isSelected = false;
      tempNotificationFilterList[i] = notificationFilter;
    }
    notificationFilter.isSelected = true;
    tempNotificationFilterList[index] = notificationFilter;
    emit(state.copyWith(notificationFilterList: List.from(tempNotificationFilterList), selectedNotificationFilter: notificationFilter));
    getNotificationList();
  }
}
