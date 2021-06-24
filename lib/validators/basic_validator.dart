class BasicValidator {
  static String validBasic(String value) {
    if (value.isEmpty) {
      return 'Não deixar campos vazios';
    }
    return null;
  }

  static String validEmail(String value) {
    if (value.isEmpty) {
      return 'Não deixar campos vazios';
    }
    return null;
  }
}
