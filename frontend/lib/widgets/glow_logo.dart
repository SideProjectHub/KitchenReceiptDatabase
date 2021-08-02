import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';

class GlowLogo extends StatelessWidget {
  const GlowLogo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AvatarGlow(
        endRadius: 90,
        duration: Duration(seconds: 2),
        glowColor: Colors.white24,
        repeat: true,
        repeatPauseDuration: Duration(seconds: 2),
        startDelay: Duration(seconds: 1), 
        child: CircleAvatar(
          radius: 70,
          backgroundColor: Colors.transparent,
          child: Image(
            height: 900,
            width: 900,
            image: AssetImage('assets/images/kartlogo.png'),
          ),
          
        ));
  }
}
