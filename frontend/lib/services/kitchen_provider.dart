import 'dart:js';

import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';
import 'package:project/services/rest_api_service.dart';
import 'package:provider/provider.dart';
import 'package:project/services/firebase_auth_service.dart';

import '../main.dart';
import 'firebase_auth_service.dart';

class KitchenProvider {
  /// Initializes all providers necessary for the app
  ///
  KitchenProvider(MyApp app) {
    runApp(
      MultiProvider(
        providers: [
          Provider(
            create: (_) => FirebaseAuthService(),
          ),
          StreamProvider(
            create: (context) =>
                context.read<FirebaseAuthService>().onAuthStateChanged,
            initialData: null,
          ),
        ],
        child: MyApp(),
      ),
    );
  }
}
