import 'package:flutter/material.dart';

class GenericErrorMessageWidget extends StatelessWidget {
  final IconData iconData;
  final String message;

  const GenericErrorMessageWidget({
    Key key,
    this.iconData,
    this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.7,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildIconWidget(context),
              _buildTextWidget(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconWidget(BuildContext context) {
    return Icon(
      this.iconData ?? Icons.error,
      size: Theme.of(context).textTheme.headline3.fontSize,
    );
  }

  Widget _buildTextWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      child: Text(
        this.message ?? "Oops, Something went wrong! This was not supposed to happen. We are sorry about that!",
        style: Theme.of(context).textTheme.bodyText1.copyWith(fontWeight: FontWeight.bold, height: 1.25),
        textAlign: TextAlign.center,
        maxLines: 5,
      ),
    );
  }
}