import 'package:contact/utils/app_strings.dart';

abstract class Validation {
  static bool isValidEmail(String email) {
    bool emailValid = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9-]+\.[a-zA-Z]+',
    ).hasMatch(email);
    return emailValid;
  }

  static String? notEmptyField(String? value, String message) {
    if (value == null || value.isEmpty) {
      return message;
    }
    return null;
  }

  static String? emailValidator(String? value) {
    String? result = notEmptyField(value, AppStrings.emptyEmail);
    if (result == null) {
      if (!isValidEmail(value!)) {
        result = AppStrings.emailNotValid;
      }
    }
    return result;
  }
}
