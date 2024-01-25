import 'package:bloc/bloc.dart';

import '../../../../../leaves/data/model/leave.dart';
import 'rm_leave_details_state.dart';

class RMLeaveDetailsCubit extends Cubit<RMLeaveDetailsState> {
  RMLeaveDetailsCubit() : super(const RMLeaveDetailsState());

  updateLeave(Leave leave) {
    emit(state.copyWith(leave: leave));
  }
}
