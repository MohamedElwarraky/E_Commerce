import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class Auth {
  final _auth = FirebaseAuth.instance;

  // Future to return when createUserWithEmailAndPassword fun finished and avoiding null
  Future<AuthResult> signup(
      {@required String email, @required String password}) async {
    // async to activate await
    // await is for waiting till the called thread finished then store value in userCredential
    final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(), password: password.trim());
    return userCredential;
  }

  // Future to return when signInWithEmailAndPassword fun finished and avoiding null
  Future<AuthResult> signIn(
      {@required String email, @required String password}) async {
    // async to activate await
    // await is for waiting till the called thread finished then store value in userCredential
    final userCredential = await _auth.signInWithEmailAndPassword(
        email: email.trim(), password: password.trim());
    return userCredential;
  }

  Future<FirebaseUser> getUser() async{
    return await _auth.currentUser();
  }

  Future<void> signOut() async{
    await _auth.signOut();
  }
}
