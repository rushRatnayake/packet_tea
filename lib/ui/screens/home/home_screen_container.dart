import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:packet_tea/ui/screens/login/login_screen.dart';
import 'package:packet_tea/ui/themes/appColors.dart';

class HomeScreenContainer extends StatelessWidget{
  const HomeScreenContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          GestureDetector(
            child: Container(
              color: AppColors.appGreen1,
              child: Text("LogIn"),
            ),
            onTap:(){
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return LogInScreen();
              }));
            },
          )
        ],
      ),
    );
  }

}