import 'dart:async';
import 'package:awign_saas/hrms/auth/features/splash/cubit/splash_state.dart';
import 'package:bloc/bloc.dart';
import '../../../../../core/utils/constants.dart';
import '../../../data/network/repository/auth_remote_repository.dart';

class SplashCubit extends Cubit<SplashState> {
  final AuthRemoteRepository _authRemoteRepository;

  SplashCubit(this._authRemoteRepository) : super(const SplashState()) {
    Timer(const Duration(seconds: AppDuration.second_3), () {
      emit(state.copyWith(isTimerCompleted: true));
    });
  }
}
