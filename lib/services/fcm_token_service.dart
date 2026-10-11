import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// FCM token save
class FcmTokenService {
  FcmTokenService(this._firestore, this._auth);

  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  Future<void> save(String token) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return;
    await _firestore.collection('users').doc(uid).set(
      {'fcmToken': token, 'tokenUpdatedAt': Timestamp.now()},
      SetOptions(merge: true),
    );
  }
}
