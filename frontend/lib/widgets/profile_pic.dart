import 'package:flutter/material.dart';

class ProfilePic extends StatelessWidget {
  final double diameter;

  const ProfilePic({Key? key, required this.diameter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        height: diameter,
        width: diameter,
        child: Container(
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Theme.of(context).primaryColor),
          ),
          child: Icon(
            Icons.person,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
