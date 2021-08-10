import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import './services/firebase_auth_service.dart';
import './screens/login_page.dart';
import '../services/kitchen_provider.dart';
import 'package:project/screens/tab_page.dart';

void main() {
  /// initializes all providers necessary
  KitchenProvider(MyApp());

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([]);
}

class MyApp extends StatefulWidget {
  @override
  // MyApp({Key? key, required context}) : super(key: key);
  // var signInUser =
  //     Provider.of<FirebaseAuthService>(this.context).firebaseAuth.currentUser;

  LoginPage createState() => LoginPage();
}
