
/// Email Validator
abstract final class Validators {
  static String? notEmpty(String? value, [String field = 'This field']) =>
      (value == null || value.trim().isEmpty) ? '$field is required' : null;

  static String? email(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return 'Email is required';
    final valid = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(text);
    return valid ? null : 'Enter a valid email address';
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    return value.length < 6 ? 'Minimum 6 characters' : null;
  }

  static String? Function(String?) matches(String Function() other) =>
      (value) => value == other() ? null : 'Passwords do not match';
}
