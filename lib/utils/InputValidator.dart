class InputValidator {
  static String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Inserisci l\'username';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Inserisci l\'indirizzo email';
    }
    if (!_isValidEmail(value)) {
      return 'Indirizzo email non valido';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Inserisci la password';
    }
    return null;
  }

  static bool _isValidEmail(String value) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(value);
  }
}
