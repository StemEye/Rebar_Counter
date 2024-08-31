class Validator {
  Validator._();

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    final emailRegularExp =
        RegExp(r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9]+\.[a-z]{2,4}$');

    if (!emailRegularExp.hasMatch(value)) {
      return 'Enter a valid Email';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }

    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must contain at least 1 uppercase letter';
    }

    if (!RegExp(r'[^\w\s]').hasMatch(value)) {
      return 'Password must contain at least 1 special character';
    }

    return null; // Password is valid
  }
}
