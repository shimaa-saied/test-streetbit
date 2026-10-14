class Validators {
  Validators._();

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) return 'emailRequired';
    final emailRegex = RegExp(r'^[\w\-.]+@[\w\-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(value.trim())) return 'emailInvalid';
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) return 'passwordRequired';
    if (value.length < 6) return 'passwordTooShort';
    return null;
  }

  static String? required(String? value, String errorKey) {
    if (value == null || value.trim().isEmpty) return errorKey;
    return null;
  }

  static String? confirmPassword(String? value, String original) {
    if (value == null || value.isEmpty) return 'confirmPasswordRequired';
    if (value != original) return 'passwordsDoNotMatch';
    return null;
  }
}
