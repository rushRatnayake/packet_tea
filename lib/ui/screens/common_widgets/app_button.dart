import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:packet_tea/ui/themes/appColors.dart';

@immutable
class AppButton extends StatelessWidget {
  final double width, height; // Adjustable
  final String text;
  final VoidCallback onPressed;
  final bool disabled;

  AppButton({
    Key key,
    this.width,
    this.height,
    this.disabled = false,
    @required this.text,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.all(1),
        width: this.width,
        height: this.height,
        decoration: _getButtonDecoration(),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: disabled ? AppColors.transparent : AppColors.black.withOpacity(0.3),
            onTap: disabled ? (){}: this.onTapHandler,
            child: buildButtonTextWidget(context),
          ),
        ),
      ),
    );
  }

  Widget buildButtonTextWidget(final BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Center(
        child: Text(
          this.text.toUpperCase(),
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .button
              .copyWith(fontWeight: FontWeight.bold, color: AppColors.white, fontSize: 18),
        ),
      ),
    );
  }

  Decoration _getButtonDecoration() {
    if (disabled) {
      return BoxDecoration(color: AppColors.grey);
    }
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          AppColors.appGreen1.withOpacity(0.9),
          AppColors.appGreen2.withOpacity(0.7),
        ],
      ),
    );
  }

  void onTapHandler() {
    HapticFeedback.mediumImpact();
    this.onPressed();
  }
}
