import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Loader {

  static void show({final BuildContext context, String status}) {
    EasyLoading.instance.indicatorType = EasyLoadingIndicatorType.circle;
    EasyLoading.show(status: status ?? "Loading...");
  }

  static void error({final BuildContext context, String error}) {
    EasyLoading.showError(error);
    Future.delayed(Duration(seconds: 4), () => Loader.hide());
  }

  static void success({final BuildContext context, String status}) {
    EasyLoading.showSuccess(status);
    Future.delayed(Duration(seconds: 3), () => Loader.hide());
  }

  static void hide({final BuildContext context}) {
    EasyLoading.dismiss();
  }
}