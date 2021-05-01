import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:packet_tea/ui/themes/appColors.dart';

class HomeEstateSelector extends StatelessWidget{

  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      padding: EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(height: 5),
            Text("Select Tea Estate",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 15),
            _buildLocations(context, Icons.apartment, "Dissanayake Tea Estate", address: "Nuwaraeliya"),
            Divider(
              thickness: 2.0,
            ),
            _buildLocations(context, Icons.apartment, "John Tea Estate", address: "Ella"),
            Divider(
              thickness: 2.0,
            ),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
  Widget _buildLocations(BuildContext context, IconData iconData, String header,
      {String address}) {
    return Container(
      padding: EdgeInsets.only(top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: 10.0, bottom: 10.0, left: 10.0, right: 20),
            child: Icon(
              iconData,
              size: 25,
              color: AppColors.appGreen1,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(header,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(fontSize: 16, fontWeight: FontWeight.bold)),
              if (address != null && address != "") ...[
                Text(address,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(fontSize: 14, color: AppColors.grey))
              ]
            ],
          )
        ],
      ),
    );
  }

}
