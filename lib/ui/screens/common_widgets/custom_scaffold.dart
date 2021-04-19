import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:packet_tea/ui/themes/appColors.dart';

@immutable
class CustomizedScaffold extends StatelessWidget {
  final String title;
  final String description;
  final String altTitle;
  final VoidCallback onBackButtonPressed;
  final Widget bottomActionButton;
  final Widget tailingActionWidget;
  final Widget appbarCenterWidget;
  final Widget child;

  CustomizedScaffold({
    Key key,
    this.title,
    @required this.bottomActionButton,
    this.description,
    this.altTitle,
    this.onBackButtonPressed,
    this.tailingActionWidget,
    this.appbarCenterWidget,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      key: const Key("form_stepper_wizard"),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: _buildAppBarLeadingAction(context),
        title: Text(this.title),
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (this.description != null) ...[
                    Text(
                      this.description,
                      style: Theme.of(context).textTheme.bodyText1,
                      textAlign: TextAlign.left,
                    ),
                  ],
                  SizedBox(height: 20),
                  this.child
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomAppBarWithActionButton(context),
    );
  }

  Widget _buildAppBarLeadingAction(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  Widget _buildBottomAppBarWithActionButton(BuildContext context) {
    return BottomAppBar(
      color: AppColors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: IntrinsicHeight(
          child: this.bottomActionButton,
        ),
      ),
    );
  }
}
