

String authErrorMessage(String code) => switch (code) {
      'invalid-email' => 'The email address is not valid.',
      'user-disabled' => 'This account has been disabled.',
      'user-not-found' ||
      'wrong-password' ||
      'invalid-credential' =>
        'Incorrect email or password.',
      'email-already-in-use' => 'An account already exists for this email.',
      'weak-password' => 'Password is too weak (min 6 characters).',
      'network-request-failed' => 'No internet connection.',
      _ => 'Authentication failed. Please try again.',
    };
