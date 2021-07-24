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

class MyApp extends StatefulWidget {
  @override
  LoginPage createState() => LoginPage();
}

// class _LoginBody extends State<MyApp> with SingleTickerProviderStateMixin {
//   final int delayedAmount = 500;
//   double _scale = 0.0;
//   late AnimationController _controller;
//   @override
//   void initState() {
//     _controller = AnimationController(
//       vsync: this,
//       duration: Duration(
//         milliseconds: 200,
//       ),
//       lowerBound: 0.0,
//       upperBound: 0.1,
//     )..addListener(() {
//         setState(() {});
//       });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final color = Colors.white;
//     _scale = 1 - _controller.value;
//     return MaterialApp(
//       theme: CustomDefaultTheme.defaultTheme,
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//           backgroundColor: Color(0xFF9575CD),
//           body: Center(
//             child: Column(
//               children: <Widget>[
//                 GlowLogo(),
//                 DelayedAnimation(
//                   child: Text(
//                     "Hi There",
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 35.0,
//                         color: color),
//                   ),
//                   delay: delayedAmount + 1000,
//                 ),
//                 DelayedAnimation(
//                   child: Text(
//                     "I'm Kart",
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 35.0,
//                         color: color),
//                   ),
//                   delay: delayedAmount + 2000,
//                 ),
//                 SizedBox(
//                   height: 30.0,
//                 ),
//                 DelayedAnimation(
//                   child: Text(
//                     "Your New Personal",
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 20.0,
//                         color: color),
//                   ),
//                   delay: delayedAmount + 3000,
//                 ),
//                 DelayedAnimation(
//                   child: Text(
//                     "Kitchen Inventory",
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 20,
//                         color: color),
//                   ),
//                   delay: delayedAmount + 3000,
//                 ),
//                 SizedBox(height: 30),
//                 DelayedAnimation(
//                   child: GestureDetector(
//                     onTapDown: _onTapDown,
//                     onTapUp: _onTapUp,
//                     child: Transform.scale(
//                       scale: _scale,
//                       child: GoogleSignInButton(),
//                     ),
//                   ),
//                   delay: delayedAmount + 4000,
//                 ),
//                 SizedBox(
//                   height: 50.0,
//                 ),
//               ],
//             ),
//           )),
//     );
//   }

//   void _onTapDown(TapDownDetails details) {
//     _controller.forward();
//   }

//   void _onTapUp(TapUpDetails details) {
//     _controller.reverse();
//   }
// }
