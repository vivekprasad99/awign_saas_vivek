import 'package:bloc/bloc.dart';

import '../flavor_config.dart';

part 'flavor_state.dart';

class FlavorCubit extends Cubit<FlavorState> {
  final FlavorConfig flavorConfig;

  FlavorCubit(this.flavorConfig)
      : super(FlavorState(flavorConfig: flavorConfig));
}
