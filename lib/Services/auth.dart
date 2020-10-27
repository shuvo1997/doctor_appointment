import 'package:firebase_auth/firebase_auth.dart';
import 'package:doctorappointment/models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user from firebase user
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged
        //.map((FirebaseUser user) => _userFromFirebaseUser(user)); evabeo kora jay
        .map(_userFromFirebaseUser);
  }

  // sign in anonymously
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register using email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      switch (e.code) {
        case 'ERROR_WEAK_PASSWORD':
          return 'This password is too weak';
          break;
        case 'ERROR_INVALID_EMAIL':
          return 'This email is invalid';
          break;
        case 'ERROR_EMAIL_ALREADY_IN_USE':
          return 'This email is already in use';
          break;
        case 'ERROR_NETWORK_REQUEST_FAILED':
          return 'Please connect to the internet';
          break;
      }
    }
  }

  //sign in using email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      switch (e.code) {
        case 'ERROR_WRONG_PASSWORD':
          return 'This password is invalid';
          break;
        case 'ERROR_INVALID_EMAIL':
          return 'This email is invalid';
          break;
        case 'ERROR_NETWORK_REQUEST_FAILED':
          return 'Please connect to the internet';
          break;
      }
    }
  }

  //Sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
