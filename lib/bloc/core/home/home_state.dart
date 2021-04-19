part of 'home_cubit.dart';

class HomeState extends Equatable {
  final int selectedBottomTabIndex;
  final HomeScreenView currentView;

  const HomeState({
    this.selectedBottomTabIndex,
    this.currentView,
  });

  HomeState copyWith({
    int selectedBottomTabIndex,
    HomeScreenView currentView,
  }) {
    return HomeState(
      currentView: currentView ?? this.currentView,
      selectedBottomTabIndex:
      selectedBottomTabIndex ?? this.selectedBottomTabIndex,
    );
  }

  @override
  List<Object> get props => [
    currentView,
    selectedBottomTabIndex,

  ];
}
