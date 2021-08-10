import 'dart:js';

import 'package:flutter/widgets.dart';
import 'package:project/app/models/UserData.dart';
import 'package:provider/provider.dart';
import 'package:project/services/firebase_auth_service.dart';

import '../main.dart';
import 'firebase_auth_service.dart';
import '../../app/models/kartUser.dart';

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
            //Notifies listeners when the userWidget changes.
            updateShouldNotify: (kartUser? prev, kartUser? next) {
              print("In stream updating");
              return prev?.uid != next?.uid;
            },
          ),
          //Proxy Providers depend on the value of other providers. The following
          //checks when kartUser updates
          ChangeNotifierProxyProvider<kartUser?, UserData>(
            create: (context) =>
                UserData(fridgeTotal: 0, foodTotal: 0, eatenTotal: 0),
            update: (context, kart, previousUser) => (previousUser != null)
                ? previousUser.update(kart?.uid)
                : UserData(fridgeTotal: 0, foodTotal: 0, eatenTotal: 0),
          ),
        ],
        child: MyApp(),
      ),
    );
  }
}
