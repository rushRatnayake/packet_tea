import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:get_it/get_it.dart';
import 'package:packet_tea/bloc/core/profile/profile_bloc.dart';
import 'package:packet_tea/data/services/secure_storage.dart';
import 'package:packet_tea/ui/screens/common_widgets/generic_error_message.dart';
import 'package:packet_tea/ui/screens/common_widgets/no_items_widget.dart';
import 'package:packet_tea/ui/screens/login/login_screen.dart';
import 'package:packet_tea/ui/themes/appColors.dart';

class ProfileScreen extends StatefulWidget{
  const ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final SecureStorageService _secureStorageService =
  GetIt.I.get<SecureStorageService>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: _createBlocProviders(context),
      child: Builder(
        builder: (context) {
          return Scaffold(
              body: _buildChild(context)
              );
        },
      ),
    );

  }

  Widget _buildChild(BuildContext context){
    return BlocBuilder<ProfileBloc, ProfileState>(
      cubit: BlocProvider.of<ProfileBloc>(context),
      builder: (BuildContext context, ProfileState state) {
        if (state is ProfileInitial || state is ProfileInProgress) {
          return Center(child: CircularProgressIndicator());
        } else if (state is ProfileSuccess) {
          if (state.user == null) {
            return NoItemsToShowMessageWidget(
              message: "No Manure Requests",
            );
          } else {
            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: 15),
                    _buildProfilePicture(context),
                    SizedBox(height: 20),
                    DetailsItem(
                      fieldName: "Name",
                      fieldValue: "${state.user.name}",
                    ),
                    SizedBox(height: 20),
                    DetailsItem(
                      fieldName: "Email\nAddress",
                      fieldValue: "${state.user.email}",
                    ),
                    SizedBox(height: 20),
                    DetailsItem(
                      fieldName: "Phone\nNumber",
                      fieldValue: "${state.user.phoneNumber}",
                    ),
                    SizedBox(height: 20),
                    ProfileFeatureItem(
                      title: "Change Password",
                      desc: "Navigate to change your password",
                      errorText: false,
                      action: IconButton(
                          icon: Icon(Icons.navigate_next),),
                    ),
                    SizedBox(height: 20),
                    _buildLogOutButton(context)
                  ],
                ),
              ),
            );
          }
        } else {
          assert(state is ProfileFailed);
          return GenericErrorMessageWidget();
        }
      },
    );
  }

  List<BlocProvider> _createBlocProviders(final BuildContext context) {
    return [
      BlocProvider<ProfileBloc>(
        create: (context) {
          final bloc = ProfileBloc();
          bloc.add(ProfileFetchEvent());
          return bloc;
        },
      ),
    ];
  }

  Widget _buildProfilePicture(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(blurRadius: 10.0, color: AppColors.grey.withOpacity(0.8))
      ], shape: BoxShape.circle,
          color: AppColors.white
      ),
      child: Icon(
        Icons.account_circle,
        size: 200,
        color: AppColors.appGreen1,
      ),
    );
  }

  Widget _buildLogOutButton(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          boxShadow: [
            BoxShadow(
                blurRadius: 10.0, color: AppColors.someGrey.withOpacity(0.5))
          ],
          color: AppColors.white),
      child: GestureDetector(
        //TODO : On  Tap implementation
        onTap: () async{
          await _secureStorageService.deleteSecureData("AccessToken");
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) {
              return LogInScreen();
            }),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Log Out",
              style: Theme.of(context).textTheme.headline6.copyWith(
                fontSize: 18,
                color: AppColors.red,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: 5),
            Icon(
              Icons.power_settings_new,
              color: AppColors.red,
              size: 35,
            ),
          ],
        ),
      ),
    );
  }
}


class ProfileFeatureItem extends StatelessWidget {
  final Widget action;
  final String title;
  final String desc;
  final bool errorText;

  const ProfileFeatureItem({
    Key key,
    this.action,
    @required this.errorText,
    @required this.title,
    @required this.desc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      duration: Duration(milliseconds: 500),
      child: IntrinsicHeight(
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface.withOpacity(0.5),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          width: double.infinity,
          child: Row(
            children: [
              _buildLead(context),
              _buildAction(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAction() {
    return Flexible(
      flex: 3,
      child: Container(
        width: double.infinity,
        child: Align(
          alignment: Alignment.centerRight,
          child: action ?? Container(),
        ),
      ),
    );
  }

  Widget _buildLead(BuildContext context) {
    return Flexible(
      flex: 9,
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: errorText ?Theme.of(context).textTheme.headline6.copyWith(
                color: AppColors.red,
                fontWeight: FontWeight.bold,
              ): Theme.of(context).textTheme.headline6.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              desc,
              style: errorText ?Theme.of(context).textTheme.bodyText2.copyWith(
                  color: AppColors.red):Theme.of(context).textTheme.bodyText2,
            ),
          ],
        ),
      ),
    );
  }
}

class DetailsItem extends StatelessWidget{

  final String fieldName;
  final String fieldValue;

  const DetailsItem({Key key, @required this.fieldName, @required this.fieldValue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface.withOpacity(0.5),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "${fieldName}",
            style: Theme.of(context).textTheme.bodyText1.copyWith(
              fontWeight: FontWeight.normal,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            fieldValue,
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.bodyText1.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

}