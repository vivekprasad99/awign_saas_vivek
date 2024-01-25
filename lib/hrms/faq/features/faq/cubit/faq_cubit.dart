import 'package:awign_saas/core/data/model/ui_state.dart';
import 'package:awign_saas/core/exception/exception.dart';
import 'package:awign_saas/core/utils/app_log.dart';
import 'package:awign_saas/hrms/faq/data/model/faq_response.dart';
import 'package:awign_saas/hrms/faq/data/network/repository/faq_remote_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:get/get.dart';
import '../../../../../core/data/model/button_state.dart';
import '../../../data/model/faq_navbar_data.dart';
import 'faq_state.dart';

class FaqCubit extends Cubit<FaqState> {
  final FaqRemoteRepository _faqRemoteRepository;
  FaqCubit(this._faqRemoteRepository) : super(const FaqState());

  void updateNavBar(int index, NavBarData navBarData,bool value) {
    List<NavBarData>? navBarDataList = [];
     navBarDataList.addAll(state.navbar!);
    var navBarData = navBarDataList![index];
    for (var name in navBarDataList) {
      name.isSelected = false;
    }
    if (!navBarDataList[index].isSelected) {
      navBarDataList[index].navBarItem = navBarData.navBarItem;
      navBarDataList[index].isSelected = true;
      emit(state.copyWith(navbar: navBarDataList,isSelected: !value));
      getFaq(navBarDataList[index].navBarItem!.toLowerCase());
    }
  }

  void getFaq(String type) async {
    try {
      emit(state.copyWith(isSearchFaqLoading: true));
      FaqResponse faqResponse = await _faqRemoteRepository.getFaq(type);
      emit(state.copyWith(faqs: faqResponse.faqs,isSearchFaqLoading: false));
    } on ServerException catch (e) {
      emit(state.copyWith(
          isSearchFaqLoading: false,
          faqs: null,
          uiState: UIState(failedWithoutAlertMessage: e.message!)));
    } on FailureException catch (e) {
      emit(state.copyWith(
          isSearchFaqLoading: false,
          faqs: null,
          uiState: UIState(failedWithoutAlertMessage: e.message!)));
    } catch (e, st) {
      AppLog.e('getFaq : ${e.toString()} \n${st.toString()}');
      emit(state.copyWith(uiState: UIState(failedWithoutAlertMessage: 'we_regret_the_technical_error'.tr)));
    }
  }

  void getFaqType() async {
    try {
      FaqsTypeResponse faqsTypeResponse = await _faqRemoteRepository.getFaqType();
      List<NavBarData> navBarDataList = <NavBarData>[];
      for (int i = 0; i < faqsTypeResponse.types!.length; i++) {
        if (i == 0) {
          NavBarData navBarData =
          NavBarData(navBarItem: faqsTypeResponse.types![i], isSelected: true);
          navBarDataList.add(navBarData);
        } else {
          var navBarData = NavBarData(navBarItem: faqsTypeResponse.types![i]);
          navBarDataList.add(navBarData);
        }
      }
      getFaq(faqsTypeResponse.types![0]);
      emit(state.copyWith(navbar: navBarDataList));
    } on ServerException catch (e) {
      emit(state.copyWith(
          navbar: null,
          uiState: UIState(failedWithoutAlertMessage: e.message!)));
    } on FailureException catch (e) {
      emit(state.copyWith(
          navbar: null,
          uiState: UIState(failedWithoutAlertMessage: e.message!)));
    } catch (e, st) {
      AppLog.e('getFaqType : ${e.toString()} \n${st.toString()}');
      emit(state.copyWith(uiState: UIState(failedWithoutAlertMessage: 'we_regret_the_technical_error'.tr)));
    }
  }
}
