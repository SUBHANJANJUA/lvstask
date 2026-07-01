import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService extends GetxService {
  static const String _webClientId =
      '565413593122-qqghr39dfgmt9jet22j9ll419s0po48e.apps.googleusercontent.com';

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Future<AuthService> init() async {
    await _googleSignIn.initialize(serverClientId: _webClientId);
    return this;
  }

  Future<UserCredential> signInWithGoogle() async {
    if (!_googleSignIn.supportsAuthenticate()) {
      throw UnsupportedError(
        'Google sign-in is not supported on this platform.',
      );
    }

    try {
      final googleUser = await _googleSignIn.authenticate();
      final googleAuth = googleUser.authentication;
      final idToken = googleAuth.idToken;

      if (idToken == null) {
        throw FirebaseAuthException(
          code: 'missing-google-id-token',
          message:
              'Google did not return an ID token. Add this app SHA in Firebase and download google-services.json again.',
        );
      }

      final credential = GoogleAuthProvider.credential(idToken: idToken);
      return _firebaseAuth.signInWithCredential(credential);
    } catch (error, stackTrace) {
      debugPrint('Google sign-in failed: $error');
      debugPrintStack(stackTrace: stackTrace);
      rethrow;
    }
  }

  Future<void> signOut() async {
    await Future.wait([_firebaseAuth.signOut(), _googleSignIn.signOut()]);
  }
}
