import 'package:awign_saas/core/data/model/button_state.dart';
import 'package:awign_saas/core/data/model/ui_state.dart';
import 'package:awign_saas/hrms/faq/data/model/faq_response.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

import '../../../data/model/faq_navbar_data.dart';

part 'faq_state.g.dart';


@CopyWith()
class FaqState extends Equatable {
  final UIState? uiState;
  final ButtonState? buttonState;
  final List<NavBarData>? navbar;
  final bool isSelected;
  final bool? isSearchFaqLoading;
  final List<Faqs>? faqs;

  const FaqState(
      {this.uiState, this.buttonState,this.navbar,this.isSelected = false,this.isSearchFaqLoading,this.faqs});

  @override
  List<Object?> get props => [uiState, buttonState,navbar,isSelected,isSearchFaqLoading,faqs];

}
