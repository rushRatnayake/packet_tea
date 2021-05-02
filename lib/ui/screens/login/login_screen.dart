import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:packet_tea/bloc/core/login/login_bloc.dart';
import 'package:packet_tea/ui/screens/common_widgets/app_button.dart';
import 'package:packet_tea/ui/screens/common_widgets/loader.dart';
import 'package:packet_tea/ui/screens/home/home_screen.dart';
import 'package:packet_tea/ui/themes/appColors.dart';
import 'package:packet_tea/ui/themes/app_theme_data.dart';

class LogInScreen extends StatefulWidget {
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
                              image: AssetImage('assets/images/logo-png.png'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Text(
                        "Log in".toUpperCase(),
                        style: Theme.of(context).textTheme.headline5.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.appGreen1.withOpacity(1)),
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
            children: [],
          ),
        ),
      ),
      onWillPop: () => Future.value(true),
    );
  }

  Widget _buildChild(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: BlocConsumer<LoginBloc, LoginState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status == FormzStatus.submissionInProgress) {
            Loader.show(status: "Signing in");
          } else if (state.status == FormzStatus.submissionSuccess) {
            Loader.hide();
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => HomePage(),
            ));
          } else if (state.status == FormzStatus.submissionFailure) {
            Loader.error(error: "Log in Failed");
          } else {
            Loader.hide();
          }
        },
        builder: (context, state) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildUserNameField(context),
                _buildPasswordField(context),
                if(state.status == FormzStatus.submissionFailure)...[
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "Username or password is incorrect",
                    style: Theme.of(context).textTheme.bodyText2.copyWith(color: AppColors.red),
                  )
                ],
                SizedBox(
                  height: 20,
                ),
                _buildBottomAppBarWithActionButton(context)
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildUserNameField(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context,state){
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: TextFormField(
            key: const Key("log_in_username_field_key"),
            controller: _userNameController,
            focusNode: _userNameFocusNode,
            enableInteractiveSelection: false,
            showCursor: true,
            readOnly: false,
            autofocus: true,
            decoration: lightModeInputDecoration().copyWith(
              hintText: "Enter User Name",
              labelText: "User Name",
            ),
            initialValue: state.username,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
            onChanged: (value) {
              context.read<LoginBloc>().add(
                LoginEmailChanged(username: value),
              );
            },
          ),
        );
      },
    );

  }

  Widget _buildPasswordField(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context,state){
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: TextFormField(
            key: const Key("log_in_password_field_key"),
            controller: _passwordController,
            focusNode: _passwordFocusNode,
            enableInteractiveSelection: false,
            showCursor: true,
            readOnly: false,
            autofocus: true,
            initialValue: state.password,
            autocorrect: false,
            keyboardType: TextInputType.text,
            obscureText : true,
            textInputAction: TextInputAction.done,
            onChanged: (value) {
              context.read<LoginBloc>().add(
                LoginPasswordChanged(pwd: value),
              );
            },
            decoration: lightModeInputDecoration().copyWith(
              hintText: "Enter Password",
              labelText: "Password",
            ),
          ),
        );
      },
    );

  }

  Widget _buildBottomAppBarWithActionButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: IntrinsicHeight(
        child: Container(
          child: AppButton(
            text: "Login",
            onPressed: () {
              context.read<LoginBloc>().add(LogInSubmissionEvent());
            },
          ),
        ),
      ),
    );
  }
}
