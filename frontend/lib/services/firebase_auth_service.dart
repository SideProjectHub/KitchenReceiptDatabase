import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
//our_user is an overriden class, User is defined by Firestore Auth, holds
//our oauth info

import 'package:mongo_dart/mongo_dart.dart';
import './strings.dart';

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  FirebaseAuthService({FirebaseAuth firebaseAuth, GoogleSignIn googleSignin})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignin ?? GoogleSignIn();

  // User _userFromFirebase(User user) {
  //   if (user == null) {
  //     return null;
  //   }
  //   return user; 
    
  // }

  // Stream<User> get onAuthStateChanged {
  //   return _firebaseAuth.authStateChanges().
  // }

  Future<User> signInWithGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final authResult = await _firebaseAuth.signInWithCredential(credential);
    print('after google_sign_in');
    await sendUserInfo(authResult.user, credential.idToken);
    return authResult.user;
  }

  /// sends the user information to the backend
  /// our_user.User : our overriden class specified
  /// @TODO: add proper implementation and documentation
  void sendUserInfo(User user, String id) async {
    var db = Db(uri_string); //temp user
    await db.open();
    var userCol = db.collection('test');
    print(await userCol.find().toList()); 
    
    // await userCol.insert({
    //   'Name': user.displayName,
    //   '_id': null,
    //   'Fridge': null,
    //   'id_token': id
    // });
  }
}
