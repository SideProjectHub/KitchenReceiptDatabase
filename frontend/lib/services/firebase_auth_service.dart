import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project/screens/tab_page.dart';
import 'package:flutter/material.dart';
//our_user is an overriden class, User is defined by Firestore Auth, holds
//our oauth info
import '../app/models/user.dart' as our_user;
import 'package:mongo_dart/mongo_dart.dart';
import './strings.dart';

class FirebaseAuthService {
  late final FirebaseAuth _firebaseAuth;
  late final GoogleSignIn _googleSignIn;

  FirebaseAuthService({FirebaseAuth? firebaseAuth, GoogleSignIn? googleSignin})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignin ?? GoogleSignIn();

  our_user.User _userFromFirebase(User? user) {
    if (user == null) {
      return our_user.User(
        uid: null,
        email: null,
        displayName: null,
      );
    }
    return our_user.User(
      uid: user.uid,
      email: user.email,
      displayName: user.displayName,
    );
  }

  Stream<our_user.User> get onAuthStateChanged {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  Future<our_user.User?> signInWithGoogle(BuildContext context) async {
    final googleUser = await _googleSignIn.signIn();
    if (googleUser == null) {
      return null;
    }
    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final authResult = await _firebaseAuth.signInWithCredential(credential);
    var user = _userFromFirebase(authResult.user);
    sendUserInfo(user, credential.idToken);
    return user;
  }

  /// sends the user information to the backend
  /// our_user.User : our overriden class specified
  /// @TODO: add proper implementation and documentation
  void sendUserInfo(our_user.User user, String? id) async {
    var db = Db(uri_string); //temp user
    await db.open();
    var userCol = db.collection('user');
    await userCol.insert({
      'Name': user.displayName,
      '_id': null,
      'Fridge': null,
      'id_token': id
    });
  }
}
