import 'package:awign_saas/core/data/network/firebase/push_notification/firebase_messaging_service.dart';
import 'package:awign_saas/hrms/auth/data/model/device_info.dart';
import 'package:bloc/bloc.dart';
import '../../../../../core/utils/app_log.dart';
import '../../../../auth/data/network/repository/auth_remote_repository.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final AuthRemoteRepository _authRemoteRepository;
  HomeCubit(this._authRemoteRepository) : super(const HomeState());

  void updateDeviceInfo() async {
    try {
      String? fcmToken = await FirebaseMessagingService().getFCMToken();
      if(fcmToken == null) {
        return;
      }
      DeviceInfo deviceInfo = DeviceInfo(fcmToken: fcmToken);
      await _authRemoteRepository.updateDeviceInfo(deviceInfo);
    } catch (e, st) {
      AppLog.e('updateDeviceInfo : ${e.toString()} \n${st.toString()}');
    }
  }

}
