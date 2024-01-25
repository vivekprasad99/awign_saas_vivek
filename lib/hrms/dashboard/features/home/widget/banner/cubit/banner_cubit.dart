import 'package:bloc/bloc.dart';

import 'banner_state.dart';

class BannerCubit extends Cubit<BannerState> {
  BannerCubit() : super(const BannerState());

  void updateCurrentPageIndex(int index) {
    emit(state.copyWith(currentPageIndex: index));
  }
}
