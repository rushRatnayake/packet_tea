import 'package:jiffy/jiffy.dart';
import 'package:packet_tea/bloc/util/custom_formz_input.dart';

enum ManureWeightError {empty, invalidPattern}

extension ManureWeightErrorMessage on ManureWeightError {
  String get message {
    switch (this) {
      case ManureWeightError.empty:
        return 'You cannot leave this blank';
      case ManureWeightError.invalidPattern:
        return 'You can only include numbers!';
      default:
        return null;
    }
  }
}

class ManureWeightField extends CustomFormzInput<String, ManureWeightError>{

  ManureWeightField.pure([String value = ""]) : super.pure(value);
  ManureWeightField.dirty(String value) : super.dirty(value);

  static final RegExp manureWeightPattern = RegExp("^[0-9]+\$");

  @override
  ManureWeightError validator(String value) {
    if (value == null || value.trim().isEmpty) {
      return ManureWeightError.empty;
    }if(!manureWeightPattern.hasMatch(value)){
      return ManureWeightError.invalidPattern;
    }return null;
  }
  String getErrorMessageIfExists() {
    if (!this.invalid) {return null;}
    return this.error == null ? null : this.error.message;
  }
}

enum ManureContactError {empty, invalidPattern,characterLength}

extension ManureContactErrorMessage on ManureContactError {
  String get message {
    switch (this) {
      case ManureContactError.empty:
        return 'You cannot leave this blank';
      case ManureContactError.invalidPattern:
        return 'You can only include numbers!';
      case ManureContactError.characterLength:
        return '10 digits required!';
      default:
        return null;
    }
  }
}

class ManureContactField extends CustomFormzInput<String, ManureContactError>{

  ManureContactField.pure([String value = ""]) : super.pure(value);
  ManureContactField.dirty(String value) : super.dirty(value);

  static final RegExp manureContactPattern = RegExp("^[0-9]+\$");
  static final numberOfCharacters = 10;

  @override
  ManureContactError validator(String value) {
    if (value == null || value.trim().isEmpty) {
      return ManureContactError.empty;
    }if(!manureContactPattern.hasMatch(value)){
      return ManureContactError.invalidPattern;
    }if(value.length != numberOfCharacters){
      return ManureContactError.characterLength;
    }return null;
  }
  String getErrorMessageIfExists() {
    if (!this.invalid) {return null;}
    return this.error == null ? null : this.error.message;
  }
}

enum ManureContactNameError {empty, invalidPattern, characterLength}

extension ManureContactNameErrorMessage on ManureContactNameError {
  String get message {
    switch (this) {
      case ManureContactNameError.empty:
        return 'You cannot leave this blank';
      case ManureContactNameError.invalidPattern:
        return 'You can only include numbers!';
      default:
        return null;
    }
  }
}

class ManureContactNameField extends CustomFormzInput<String, ManureContactNameError>{

  ManureContactNameField.pure([String value = ""]) : super.pure(value);
  ManureContactNameField.dirty(String value) : super.dirty(value);

  static final RegExp manureContactNamePattern = RegExp("^[a-zA-Z ]+\$");

  @override
  ManureContactNameError validator(String value) {
    if (value == null || value.trim().isEmpty) {
      return ManureContactNameError.empty;
    }if(!manureContactNamePattern.hasMatch(value)){
      return ManureContactNameError.invalidPattern;
    }return null;

  }
  String getErrorMessageIfExists() {
    if (!this.invalid) {return null;}
    return this.error == null ? null : this.error.message;
  }
}


enum ManureTypeError {empty}

class ManureTypeField extends CustomFormzInput<String, ManureTypeError>{

  ManureTypeField.pure([String value = ""]) : super.pure(value);
  ManureTypeField.dirty(String value) : super.dirty(value);


  @override
  ManureTypeError validator(String value) {
    if (value == null || value.trim().isEmpty) {
      return ManureTypeError.empty;
    }return null;
  }
  String getErrorMessageIfExists() {
    if (!this.invalid) {return null;}
    return this.error == null ? null : "Null";
  }
}
