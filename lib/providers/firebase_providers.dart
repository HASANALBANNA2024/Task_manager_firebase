import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

/// firebase provider
final firebaseAuthProvider = Provider<FirebaseAuth>((_) => FirebaseAuth.instance);
final firestoreProvider = Provider<FirebaseFirestore>((_) => FirebaseFirestore.instance);
final messagingProvider = Provider<FirebaseMessaging>((_) => FirebaseMessaging.instance);
final googleSignInProvider = Provider<GoogleSignIn>((_) => GoogleSignIn());
final notificationsPluginProvider =
    Provider<FlutterLocalNotificationsPlugin>((_) => FlutterLocalNotificationsPlugin());
