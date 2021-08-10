import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project/app/models/kartUser.dart';
import 'package:project/services/firebase_auth_service.dart';
import 'package:project/widgets/glow_logo.dart';
import 'package:project/widgets/sign_in_google_button.dart';

import '../delayed_animation.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginPage({Key? key}) : super(key: key);

  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final int delayedAmount = 500;
  double _scale = 0.0;
  late AnimationController _controller;

  // _loginbody() : super();

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 200,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("Building LoginPage");
    print(Provider.of<FirebaseAuthService>(context).firebaseAuth.currentUser);
    print("Printing UID");
    print(Provider.of<kartUser?>(context)?.uid);
    final color = Colors.white;
    _scale = 1 - _controller.value;
    return Scaffold(
        backgroundColor: Color(0xFF9575CD),
        body: Center(
          child: Column(
            children: <Widget>[
              GlowLogo(),
              SizedBox(
                height: 20,
              ),
              DelayedAnimation(
                child: Text(
                  "Hi There",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 35.0,
                      color: color),
                ),
                delay: delayedAmount + 1000,
              ),
              SizedBox(height: 10),
              DelayedAnimation(
                child: Text(
                  "I'm Kart",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 35.0,
                      color: color),
                ),
                delay: delayedAmount + 2000,
              ),
              SizedBox(
                height: 120.0,
              ),
              DelayedAnimation(
                child: Text(
                  "Your New Personal",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color: color),
                ),
                delay: delayedAmount + 3000,
              ),
              DelayedAnimation(
                child: Text(
                  "Kitchen Inventory",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20, color: color),
                ),
                delay: delayedAmount + 3000,
              ),
              SizedBox(height: 120),
              DelayedAnimation(
                child: GestureDetector(
                  onTapDown: _onTapDown,
                  onTapUp: _onTapUp,
                  child: Transform.scale(
                    scale: _scale,
                    child: GoogleSignInButton(),
                  ),
                ),
                delay: delayedAmount + 4000,
              ),
            ],
          ),
        ));
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }
}
