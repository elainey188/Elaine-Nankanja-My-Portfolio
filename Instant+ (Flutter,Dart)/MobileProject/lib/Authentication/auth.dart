import 'package:firebase_auth/firebase_auth.dart';

/*
  Description:

This class is used to handle Firebase Authentication*/

/*
  Todo:

Create a sign out button. Should be in ProfilePage*/

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Method to create a new user with email and password
  Future<User?> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        showToast(message: 'The email address is already in use.');
      } else {
        showToast(message: 'An error occurred: ${e.code}');
      }
      return null;
    }
  }

  /// Method to sign in with email and password
  Future<User?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        showToast(message: 'Invalid email or password.');
      } else {
        showToast(message: 'An error occurred: ${e.code}');
      }
      return null;
    }
  }

  /// Method to sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  /// Stream to listen for authentication state changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();
}

/// Function to show toast messages
/// Replace this with your preferred toast/snackbar implementation
void showToast({required String message}) {
  // Example placeholder
  print(message); // Replace this with an actual toast or notification in your app
}