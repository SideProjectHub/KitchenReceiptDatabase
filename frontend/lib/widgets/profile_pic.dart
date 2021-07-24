import 'package:flutter/material.dart';

class ProfilePic extends StatelessWidget {
  final double diameter;

  const ProfilePic({Key? key, required this.diameter}) : super(key: key);

  Widget _picture(String? url, BuildContext context) {
    if (url != null) {
      return Image.network(url, fit: BoxFit.fill);
    } else {
      return Icon(
        Icons.person,
        color: Theme.of(context).primaryColor,
      );
    }
  }

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
          child: _picture(
              "https://pbs.twimg.com/profile_images/1367536399117910018/pRJrxQQr.jpg",
              context),
        ),
      ),
    );
  }
}
