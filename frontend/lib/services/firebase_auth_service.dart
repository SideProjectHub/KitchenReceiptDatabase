import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project/screens/tab_page.dart';
import 'package:flutter/material.dart';
//our_user is an overriden class, User is defined by Firestore Auth, holds
//our oauth info
import '../app/models/kartUser.dart';
import 'package:http/http.dart' as http;

class FirebaseAuthService {
  late final FirebaseAuth _firebaseAuth;
  late final GoogleSignIn _googleSignIn;

  FirebaseAuthService({FirebaseAuth? firebaseAuth, GoogleSignIn? googleSignin})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignin ?? GoogleSignIn();

  kartUser _userFromFirebase(User? user) {
    if (user == null) {
      print('user is null'); 
      return kartUser(
          uid: null, email: null, displayName: null, imageURL: null);
    } 
    print('user is not null'); 
    return kartUser(
      uid: user.uid,
      email: user.email,
      displayName: user.displayName,
      imageURL: user.photoURL,
    );
  }

  Stream<kartUser> get onAuthStateChanged {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  Future<kartUser?> signInWithGoogle() async {
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
    print(user.email);
    print(user.displayName);
    print(user.uid);
    postUser(user);
    //sendUserInfo(user, credential.idToken);
    return user;
  }

  /// sends the user information to the backend
  /// our_user.User : our overriden class specified
  /// @TODO: add proper implementation and documentation
  void postUser(kartUser user) async {
    Map<String, dynamic> body = {
      "displayName": user.displayName.toString(),
      "uid": user.uid.toString(),
      "email": user.email.toString(),
      "imageURL": user.imageURL.toString()
      //"fridge": null,
    };

    print(body.toString());
    String jsonBody = jsonEncode(body);
    final response = await http.post(
      Uri.parse("http://localhost:5000/routes/addUser"),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json'
      },
      body: jsonBody,
    );
    print('printing response');
    print(response.statusCode);
  }
}
