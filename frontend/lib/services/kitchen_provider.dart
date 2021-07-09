import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:reflectly_flutter_app/services/firebase_auth_service.dart';

import '../main.dart';

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
