class Validation {
  static bool isCash(String value) {
    final regex = RegExp(r"""^\d+\,\d{2}$""");
    final matches = regex.allMatches(value);
    return matches.length == 1;
  }

  static bool isValidPercent(String value){
    final isValid = RegExp(r"^\d+$").allMatches(value).length == 1;
    return isValid && int.parse(value) >= 30;
  }

}
