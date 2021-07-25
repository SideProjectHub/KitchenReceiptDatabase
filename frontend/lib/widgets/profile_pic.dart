import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../app/models/kartUser.dart';

class ProfilePic extends StatelessWidget {
  final double diameter;

  const ProfilePic({Key? key, required this.diameter}) : super(key: key);

  Widget _picture(String? url, BuildContext context) {
    if (url != null) {
      return Container(
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Theme.of(context).primaryColor),
          image: DecorationImage(
            image: NetworkImage(
              url,
            ),
            fit: BoxFit.cover,
          ),
        ),
      );
    } else {
      return Container(
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Theme.of(context).primaryColor),
        ),
        child: Icon(
          Icons.person,
          color: Theme.of(context).primaryColor,
        ),
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
        child: _picture(Provider.of<kartUser?>(context)?.photoURL, context),
      ),
    );
  }
}
