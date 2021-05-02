import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
// import 'lottie_asset.dart';

class NoItemsToShowMessageWidget extends StatelessWidget {
  final String message;

  const NoItemsToShowMessageWidget({Key key, @required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 650,
      child: Opacity(
        opacity: 0.2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 3,
              child: Lottie.asset( "assets/animations/sad_face.json"),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 40,
              ),
              child: Text(
                this.message,
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                  fontWeight: FontWeight.bold,
                  height: 1.25,
                ),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}