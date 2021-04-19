import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:packet_tea/ui/screens/home/home_screen.dart';
import 'package:packet_tea/ui/screens/home/home_screen_view.dart';
import 'package:packet_tea/ui/themes/app_theme_data.dart';

import 'bloc/core/home/home_cubit.dart';

class PacketTeaApp extends StatefulWidget{

  @override
  _PacketTeaAppState createState() => _PacketTeaAppState();
}

class _PacketTeaAppState extends State<PacketTeaApp> {
  final GlobalKey<ScaffoldState> _materialAppKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            return HomeCubit(
              HomeState(
                currentView: HomeScreenView.home,
                selectedBottomTabIndex: 0,
              ),
            );
          },
        ),
      ],
      child: MaterialApp(
        key: _materialAppKey,
        theme: AppThemeData,
        debugShowCheckedModeBanner: false,
        home: Builder(
          builder: (context) {
            return HomePage();
            // return FutureBuilder(
            //   future: Future.wait([_sp.isLoggedIn()]),
            //   builder: (_, AsyncSnapshot<List<bool>> snapshot) {
            //     if (snapshot.connectionState == ConnectionState.done) {
            //       return snapshot.data[0]
            //           ? HomePage()
            //           : CustomerAuthActionScreen();
            //     } else {
            //       return Center(child: CircularProgressIndicator());
            //     }
            //   },
            // );
          },
        ),
        // builder: EasyLoading.init(),
      ),
    );
  }
}