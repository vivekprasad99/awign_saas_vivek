import 'package:awign_saas/core/data/model/button_state.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/data/local/database/model/current_user/tenant.dart';
import '../../../../../core/data/local/database/model/current_user/user.dart';
import '../../../../../core/data/model/ui_state.dart';

part 'select_organisation_state.g.dart';

@CopyWith()
class SelectOrganisationState extends Equatable {
  final UIState? uiState;
  final User? user;
  final bool? otpVerified;
  final List<Tenant>? tenants;
  final ButtonState? buttonState;
  final Tenant? selectedTenant;

  const SelectOrganisationState(
      {this.uiState, this.user, this.otpVerified, this.tenants, this.buttonState, this.selectedTenant});

  @override
  List<Object?> get props => [uiState, user, otpVerified, tenants, buttonState, selectedTenant];
}
