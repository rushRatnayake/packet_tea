import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:packet_tea/ui/screens/home/home_screen_view.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit([HomeState initial]) : super(initial ?? HomeState());

  void changeHomeScreenViewTab({@required int selectedBottomTabIndex}) {
    HomeScreenView newView;
    if (selectedBottomTabIndex == 0) {
      newView = HomeScreenView.home;
    } else if (selectedBottomTabIndex == 1) {
      newView = HomeScreenView.manure;
    }else if (selectedBottomTabIndex == 2) {
      newView = HomeScreenView.loan;
    } else {
      newView = HomeScreenView.profile;
    }
    emit(state.copyWith(
      currentView: newView,
      selectedBottomTabIndex: selectedBottomTabIndex,
    ));
  }

  void changeHomeScreenViewTo(HomeScreenView view) {
    int index;
    if (view == HomeScreenView.home) {
      index = 0;
    } else if (view == HomeScreenView.manure) {
      index = 1;
    } else if (view == HomeScreenView.loan) {
      index = 2;
    } else {
      assert(view == HomeScreenView.profile);
      index = 3;
    }
    emit(state.copyWith(
      currentView: view,
      selectedBottomTabIndex: index,
    ));
  }
}
