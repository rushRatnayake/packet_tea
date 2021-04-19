import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:packet_tea/ui/screens/manure/add_manure_form.dart';
import 'package:packet_tea/ui/themes/appColors.dart';

class ManureScreen extends StatelessWidget {
  const ManureScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Text("Manure Listing Comes Here")
        ),
        floatingActionButton: _buildFloatingButton(context));
  }

  Widget _buildFloatingButton(BuildContext context){
    return FloatingActionButton(
      child: IconButton(
        onPressed: () => {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return AddManureForm();
          }))
        },
        icon: Icon(Icons.add),
        color: AppColors.white,
      ),
      backgroundColor: AppColors.appGreen1,
    );
  }
}
