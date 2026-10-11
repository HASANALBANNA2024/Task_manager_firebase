import 'package:cloud_firestore/cloud_firestore.dart';

/// simple Error Message
class AppException implements Exception {
  const AppException(this.message);
  final String message;
}

String errorMessage(Object error) {
  if (error is AppException) return error.message;
  if (error is FirebaseException) return error.message ?? 'Database Error.';
  return 'Something went wrong. Please try Again.';
}
