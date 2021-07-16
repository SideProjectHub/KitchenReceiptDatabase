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
      child: Material(
          elevation: 8.0,
          shape: CircleBorder(),
          child: CircleAvatar(
            backgroundColor: Colors.grey[100],
            child: FlutterLogo(
              size: 50.0,
            ),
            radius: 50.0,
          )),
    );
  }
}
