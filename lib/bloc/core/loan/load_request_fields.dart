import 'package:jiffy/jiffy.dart';
import 'package:packet_tea/bloc/util/custom_formz_input.dart';

enum LoanAmountError {empty, exceeded, invalidPattern}

extension LoanAmountErrorMessage on LoanAmountError {
  String get message {
    switch (this) {
      case LoanAmountError.empty:
        return 'You cannot leave this blank';
      case LoanAmountError.invalidPattern:
        return 'You can only include numbers!';
      case LoanAmountError.exceeded:
        return "Too many characters (max: ${LoanAmountField.maxCharacters})";
      default:
        return null;
    }
  }
}

class LoanAmountField extends CustomFormzInput<String, LoanAmountError>{

  LoanAmountField.pure([String value = ""]) : super.pure(value);
  LoanAmountField.dirty(String value) : super.dirty(value);

  static final RegExp loanAmountPattern = RegExp("^[0-9]+\$");
  static final int maxCharacters = 30;

  @override
  LoanAmountError validator(String value) {
    if (value == null || value.trim().isEmpty) {
      return LoanAmountError.empty;
    }if(value.length > maxCharacters){
      return LoanAmountError.exceeded;
    }if(!loanAmountPattern.hasMatch(value)){
      return LoanAmountError.invalidPattern;
    }return null;
  }
  String getErrorMessageIfExists() {
    if (!this.invalid) {return null;}
    return this.error == null ? null : this.error.message;
  }
}

enum LoanDateError { empty }
extension LoanDateErrorMessage on LoanDateError {
  String get message {
    switch (this) {
      case LoanDateError.empty:
        return 'You cannot leave this blank';
      default:
        return null;
    }
  }
}

class LoanDateField
    extends CustomFormzInput<DateTime, LoanDateError> {
  const LoanDateField.pure(DateTime value) : super.pure(value);

  const LoanDateField.dirty(DateTime value) : super.dirty(value);

  String getValueFormatted() {
    return Jiffy(value).Hm;
  }

  @override
  LoanDateError validator(DateTime value) {
    /// Here we only check whether its empty or not.
    if (value == null) {
      return LoanDateError.empty;
    }
    return null;
  }

  @override
  String getErrorMessageIfExists() {
    if (!this.invalid) {return null;}
    return this.error == null ? null : this.error.message;
  }
}
enum LoanNoteError {lessCharacterCount, characterCountExceeded, invalidPattern}

extension LoanNoteErrorMessage on LoanNoteError {
  String get message {
    switch (this) {
      case LoanNoteError.invalidPattern:
        return 'Notes can only contain alphabetic characters! ';
      default:
        return null;
    }
  }
}

class LoanNotesField extends CustomFormzInput<String, LoanNoteError>{

  LoanNotesField.pure([String value = ""]) : super.pure(value);
  LoanNotesField.dirty(String value) : super.dirty(value);

  static final RegExp namePattern = RegExp("^[a-zA-Z ]+\$");

  @override
  LoanNoteError validator(String value) {
    if (value != null || value.trim().isNotEmpty) {
      if (!namePattern.hasMatch(value)) {
        return LoanNoteError.invalidPattern;
      }
    }return null;
  }

  String getErrorMessageIfExists() {
    if (!this.invalid) {return null;}
    return this.error == null ? null : this.error.message;
  }
}
