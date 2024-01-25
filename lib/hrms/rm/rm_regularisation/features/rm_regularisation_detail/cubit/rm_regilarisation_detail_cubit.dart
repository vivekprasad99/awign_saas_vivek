
import 'package:awign_saas/hrms/rm/rm_regularisation/data/network/repository/rm_regularisation_remote_repository.dart';
import 'package:awign_saas/hrms/rm/rm_regularisation/features/rm_regularisation_detail/cubit/rm_regilarisation_detail_state.dart';
import 'package:bloc/bloc.dart';

class RmRegilarisationDetailCubit extends Cubit<RmRegilarisationDetailState> {
  final RMRegularisationRemoteRepository _rMRegularisationRemoteRepository;

  RmRegilarisationDetailCubit(this._rMRegularisationRemoteRepository)
      : super(const RmRegilarisationDetailState());

}
