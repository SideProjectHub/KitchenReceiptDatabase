import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
      return kartUser(
        uid: null,
        email: null,
        displayName: null,
      );
    }
    return kartUser(
      uid: user.uid,
      email: user.email,
      displayName: user.displayName,
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
    //sendUserInfo(user, credential.idToken);
    return user;
  }

  /// sends the user information to the backend
  /// our_user.User : our overriden class specified
  /// @TODO: add proper implementation and documentation
  void postUser(kartUser user) async {
    Map<String, dynamic> body = {
      "displayName": user.displayName,
      "uid": user.uid,
      "email": user.email,
      //"fridge": null,
    };
    final response = await http.post(
      Uri.parse("http://localhost:5000/routes/addUser"),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json'
      },
      body: json.encode(body),
    );
    print(response.body);
  }

}
