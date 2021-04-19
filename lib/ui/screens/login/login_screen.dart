import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:packet_tea/ui/themes/appColors.dart';
import 'package:packet_tea/ui/themes/app_theme_data.dart';

class LogInScreen extends StatefulWidget{
  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  TextEditingController _userNameController;
  TextEditingController _passwordController;

  FocusNode _userNameFocusNode;
  FocusNode _passwordFocusNode;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        body: Scrollbar(
          child: SingleChildScrollView(
            child: Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      // height: MediaQuery.of(context).size.height / 8 * 3,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Image(
                              width: MediaQuery.of(context).size.width / 3 * 2,
                              image:
                              AssetImage('assets/images/logo-png.png'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      child: Text(
                        "Log in".toUpperCase(),
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            .copyWith(fontWeight: FontWeight.bold, color: AppColors.appGreen1.withOpacity(1)),
                      ),
                    ),
                    Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        child: _buildChild(context)),
                  ],
                )),
          ),
        ),
        bottomNavigationBar: Container(
          height: MediaQuery.of(context).size.height / 10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Text(
              //   "New to RewardsTick?",
              //   style: Theme.of(context)
              //       .textTheme
              //       .bodyText2
              //       .copyWith(fontWeight: FontWeight.w200),
              // ),
              // const SizedBox(width: 5),
            ],
          ),
        ),
      ),
      onWillPop: () => Future.value(true),
    );
  }

  Widget _buildChild(BuildContext context){
    return Column(
      children: [
        _buildUserNameField(context),
        SizedBox(height: 20,),
        _buildPasswordField(context),
        SizedBox(height: 20,)

      ],
    );
  }

  Widget _buildUserNameField (BuildContext context){
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child:TextFormField(
        key: const Key("log_in_username_field_key"),
        controller: _userNameController,
        focusNode: _userNameFocusNode,
        enableInteractiveSelection: false,
        showCursor: true,
        readOnly: true,
        autofocus: true,
        decoration:lightModeInputDecoration().copyWith(
          hintText: "Enter User Name",
          labelText: "User Name",
        ),
      ),
    );
  }


  Widget _buildPasswordField (BuildContext context){
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child:TextFormField(
        key: const Key("log_in_password_field_key"),
        controller: _passwordController,
        focusNode: _passwordFocusNode,
        enableInteractiveSelection: false,
        showCursor: true,
        readOnly: true,
        autofocus: true,
        decoration:lightModeInputDecoration().copyWith(
          hintText: "Enter Password",
          labelText: "Password",
        ),
      ),
    );
  }


}