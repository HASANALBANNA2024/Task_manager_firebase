import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_task_manager/core/app_exception.dart';
import 'package:firebase_task_manager/services/auth_error_messages.dart';

/// firebase authentication service
class AuthService {
  AuthService(this._auth, this._google);

  final FirebaseAuth _auth;
  final GoogleSignIn _google;

  Stream<User?> authStateChanges() => _auth.authStateChanges();

  Future<void> signIn(String email, String password) => _run(() =>
      _auth.signInWithEmailAndPassword(email: email.trim(), password: password));

  Future<void> signUp(String email, String password) => _run(() =>
      _auth.createUserWithEmailAndPassword(email: email.trim(), password: password));

  Future<void> signInWithGoogle() => _run(() async {
        final account = await _google.signIn();
        if (account == null) throw const AppException('Google sign-in was cancelled.');
        final auth = await account.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: auth.accessToken,
          idToken: auth.idToken,
        );
        await _auth.signInWithCredential(credential);
        return null;
      });

  Future<void> sendPasswordReset(String email) =>
      _run(() => _auth.sendPasswordResetEmail(email: email.trim()));

  Future<void> signOut() => _run(() async {
        await _google.signOut();
        await _auth.signOut();
        return null;
      });

  Future<void> _run(Future<Object?> Function() action) async {
    try {
      await action();
    } on AppException {
      rethrow;
    } on FirebaseAuthException catch (e) {
      throw AppException(authErrorMessage(e.code));
    } catch (_) {
      throw const AppException('Something went wrong. Please try again.');
    }
  }
}
