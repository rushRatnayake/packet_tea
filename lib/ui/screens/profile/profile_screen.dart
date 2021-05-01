import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:packet_tea/data/services/secure_storage.dart';
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
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: 15),
            _buildProfilePicture(context),
            SizedBox(height: 20),
            _buildProfileDetails(context),
            SizedBox(height: 20),
            _buildLogOutButton(context)
          ],
        ),
      ),
    );
  }

  Widget _buildProfilePicture(BuildContext context) {
    return Container(
      height: 180,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(blurRadius: 20.0, color: AppColors.grey.withOpacity(0.8))
      ], shape: BoxShape.circle, color: AppColors.white),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(300.0),
        clipBehavior: Clip.antiAlias,
        child: CachedNetworkImage(
          imageUrl:
          "https://surpasssoftware.com/wp-content/uploads/2019/11/avatar-1.jpg",
          placeholder: (context, url) => Container(
            child: Image.asset(
              //TODO : Change the placeholder image
              "assets/placeholders/groceries_placeholder.jpg",
              fit: BoxFit.fill,
            ),
          ),
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget _buildProfileDetails(BuildContext context) {
    return Column(
      children: [
        Text(
          "Dissara Dissanayake",
          style: Theme.of(context).textTheme.headline6.copyWith(
            fontSize: 18,
            color: AppColors.appGreen1,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        SizedBox(height: 10),
        Text(
          "ddissanayake@gmail.com",
          style: Theme.of(context).textTheme.headline6.copyWith(
            fontSize: 16,
            color: AppColors.appGreen1,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ],
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