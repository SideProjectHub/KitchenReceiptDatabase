import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import './services/firebase_auth_service.dart';
import './screens/login_page.dart';
import '../services/kitchen_provider.dart';
import 'package:project/screens/tab_page.dart';

void main() async {
  /// initializes all providers necessary

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([]);
  await Firebase.initializeApp();

  KitchenProvider(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  MyApp({Key? key}) : super(key: key);

  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget build(BuildContext context) {
    var signInUser = Provider.of<FirebaseAuthService>(context);
    var currentUser = signInUser.firebaseAuth.currentUser;
    Widget homePage;
    if (currentUser != null) {
      signInUser.inUser.add(signInUser.userFromFirebase(currentUser));
      homePage = TabPage();
    } else {
      homePage = LoginPage();
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: homePage,
    );
  }
}
