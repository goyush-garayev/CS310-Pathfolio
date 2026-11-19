/// Validation functions for forms. Each returns an error message or null if OK.
class Validators {
  Validators._();

  static String? required(String? v, [String field = 'This field']) {
    if (v == null || v.trim().isEmpty) return '$field is required';
    return null;
  }

  static String? name(String? v) {
    final r = required(v, 'Name');
    if (r != null) return r;
    if (v!.trim().length < 2) return 'Name must be at least 2 letters';
    return null;
  }

  static String? email(String? v) {
    final r = required(v, 'Email');
    if (r != null) return r;
    final ok = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(v!.trim());
    return ok ? null : 'Enter a valid email, like name@mail.com';
  }

  static String? password(String? v) {
    final r = required(v, 'Password');
    if (r != null) return r;
    if (v!.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  /// Time in 24h format: 09:00, 16:30
  static String? time(String? v) {
    final r = required(v, 'Time');
    if (r != null) return r;
    final ok = RegExp(r'^([01]\d|2[0-3]):[0-5]\d$').hasMatch(v!.trim());
    return ok ? null : 'Use HH:MM, like 14:30';
  }

  static String? cost(String? v) {
    final r = required(v, 'Cost');
    if (r != null) return r;
    final n = double.tryParse(v!.trim());
    if (n == null) return 'Enter a number';
    if (n < 0) return 'Cost can\'t be negative';
    if (n > 10000) return 'That looks too high';
    return null;
  }

  static String? duration(String? v) {
    final r = required(v, 'Duration');
    if (r != null) return r;
    final n = double.tryParse(v!.trim());
    if (n == null || n <= 0) return 'Enter hours, like 1.5';
    if (n > 24) return 'Max 24 hours';
    return null;
  }
}
