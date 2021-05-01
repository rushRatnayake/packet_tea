import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:packet_tea/bloc/core/home/home_cubit.dart';
import 'package:packet_tea/data/services/shared_preferences_services.dart';
import 'package:packet_tea/ui/screens/harvest/harvest_screen.dart';
import 'package:packet_tea/ui/screens/home/home_estate_selector.dart';
import 'package:packet_tea/ui/screens/home/home_screen_container.dart';
import 'package:packet_tea/ui/screens/loans/loan_screen.dart';
import 'package:packet_tea/ui/screens/manure/manure_screen.dart';
import 'package:packet_tea/ui/screens/profile/profile_screen.dart';
import 'package:packet_tea/ui/themes/appColors.dart';

import 'home_screen_view.dart';

class HomePage extends StatefulWidget {
  static const List<Widget> pages = [
    HomeScreenContainer(key: const Key("deals_page")),
    ManureScreen(key: const Key("picks_page")),
    LoanScreen(key: const Key("loan_page")),
    HarvestScreen(key: const Key("harvest_page")),
    ProfileScreen(key: const Key("account_page")),
  ];

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final SharedPreferenceService _preferenceService = GetIt.I.get<SharedPreferenceService>();

  String name = "";
  String username="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadEstate();

  }

  Future _loadEstate() async{
    String estate =  await _preferenceService.getEstateName();
    String username =  await _preferenceService.getUserName();
    setState(()  {
      name = estate;
      username =username;
    });
  }

  @override
  Widget build(BuildContext parentContext) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Builder(
        builder: (contextA) {
          return BlocBuilder<HomeCubit, HomeState>(
            cubit: BlocProvider.of<HomeCubit>(contextA),
            builder: (context, state) {
              return Scaffold(
                key: const Key("HomeScreenScaffold"),
                appBar: _mapAppBarToScaffold(context, state.currentView),
                backgroundColor: Theme.of(contextA).scaffoldBackgroundColor,
                body: Scrollbar(
                  child: SingleChildScrollView(
                    child: SafeArea(
                      child: (() {
                        var screen = HomePage.pages[state.selectedBottomTabIndex];
                        return screen;
                      })(),
                    ),
                  ),
                ),
                bottomNavigationBar: _buildBottomBarWidget(),
              );
            },
          );
        },
      ),
    );
  }

  /// Dynamic bottom navigation widgets
  Widget _buildBottomBarWidget() {
    return Builder(
      builder: (context) {
        return BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: AppColors.somewhatBlack,
                    blurRadius: 5.0,
                  ),
                ],
              ),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: state.selectedBottomTabIndex,
                onTap: (int index) {
                  context
                      .read<HomeCubit>()
                      .changeHomeScreenViewTab(selectedBottomTabIndex: index);
                },
                items: _buildBottomNavigationBar(),
              ),
            );
          },
        );
      },
    );
  }

  List<BottomNavigationBarItem> _buildBottomNavigationBar() {
    return <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.line_style), //linestyle
        label: 'Manure',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.local_atm),
        label: 'Loans',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.grass),
        label: 'Harvest',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.account_circle),
        label: 'Profile',
      ),
    ];
  }

  /// Dynamic AppBars --
  Widget _mapAppBarToScaffold(BuildContext context, HomeScreenView view) {
    if (view == HomeScreenView.home) {
      return _buildDealsPageAppBar(context);
    } else if (view == HomeScreenView.manure) {
      return _buildAlertsPageAppBar();
    } else if (view == HomeScreenView.loan) {
      return _buildCheckInPageAppBar();
    } else if (view == HomeScreenView.harvest) {
      return _buildHarvestPageAppBar(context);
    } else if (view == HomeScreenView.profile) {
      return _buildAccountPageAppBar(context);
    } else {
      return _defaultAppBar();
    }
  }

  AppBar _buildDealsPageAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title:Builder(
        builder: (context) {
          return _buildTitle(context);
        },
      ),
      elevation: 3,
      shadowColor: AppColors.appGreen2.withOpacity(1),
    );
  }

  Widget _buildTitle(BuildContext context){
    return FutureBuilder(
      future: Future.wait([_preferenceService.getUserName(), _preferenceService.getEstateName()]),
      builder: (_, AsyncSnapshot<List<String>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.location_on,
                  color: AppColors.appGreen1,
                  size: 25,
                ),
                Expanded(
                  flex: 0,
                  child: InkWell(
                    onTap: () {
                      _buildBottomSheet(context);
                    },
                    child: Container(
                      child: Text(
                        snapshot.data[1],
                        style: Theme.of(context).textTheme.headline6.copyWith(
                          fontSize: 13,
                          color: AppColors.appGreen1,
                          // fontWeight: FontWeight.bold
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    "Hi, ${snapshot.data[0]}!",
                    style: Theme.of(context).textTheme.headline6.copyWith(
                      fontSize: 20,
                      color: AppColors.appGreen1,
                      // fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
                SizedBox(width: 5),
              ],
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  AppBar _buildAlertsPageAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text("Manure", style: TextStyle(fontSize: 20,  color: AppColors.appGreen1,letterSpacing: 1)),
    );
  }

  AppBar _buildCheckInPageAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Container(
        child: const Text("Loan", style: TextStyle(fontSize: 20,  color: AppColors.appGreen1, letterSpacing: 1)),
      ),
    );
  }
  Widget _buildHarvestPageAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Container(
        child: const Text("Harvest", style: TextStyle(fontSize: 20,  color: AppColors.appGreen1,letterSpacing: 1),
        ),
      ),
    );
  }

  Widget _buildAccountPageAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Container(
        child: const Text("Profile", style: TextStyle(fontSize: 20,  color: AppColors.appGreen1,letterSpacing: 1),
        ),
      ),
    );
  }

  /// Should render this if there's no mapping appbar for the navigation screens.
  AppBar _defaultAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Container(
        child: Text("Placeholder AppBar"),
      ),
    );
  }

  ///Bottom Modal Sheet - Address onTap
  _buildBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return HomeEstateSelector();
      },
    );
  }
}
