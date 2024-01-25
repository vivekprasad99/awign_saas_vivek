import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/data/model/button_state.dart';
import '../../../../../core/data/model/ui_state.dart';
part 'login_via_number_state.g.dart';

@CopyWith()
class LoginViaNumberState extends Equatable {
  final UIState? uiState;
  final ButtonState? buttonState;
  final String? mobileNumber;
  final String? mobileNumberError;

  const LoginViaNumberState({this.uiState, this.buttonState, this.mobileNumber, this.mobileNumberError});

  @override
  List<Object?> get props => [uiState, buttonState, mobileNumber, mobileNumberError];
}
