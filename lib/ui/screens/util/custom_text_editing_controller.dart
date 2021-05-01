import 'package:flutter/material.dart';

class CustomTextEditingController extends TextEditingController {
  CustomTextEditingController({String text}) : super(text: text);

  set text(String newText) {
    value = value.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
      composing: TextRange.empty,
    );
  }
}
