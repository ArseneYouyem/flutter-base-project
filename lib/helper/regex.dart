class RegexValidator {
  static bool isEmail(String string) {
    if (string.isEmpty) {
      return false;
    }
    const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    final regExp = RegExp(pattern);

    if (!regExp.hasMatch(string)) {
      return false;
    }
    return true;
  }

  static bool isValidPhoneNumber(String phone) {
    final regExp = RegExp(r"^[+]?[0-9]{10,13}$");
    return regExp.hasMatch(phone);
  }

  static bool isNumber(str) {
    if (str == null) {
      return false;
    }
    return int.tryParse(str) != null || double.tryParse(str) != null;
  }

  static bool isIntNumber(String str) {
    return int.tryParse(str) != null && !str.contains(".");
  }
}
