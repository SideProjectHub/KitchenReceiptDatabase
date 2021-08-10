import 'package:flutter/material.dart';
import 'package:project/services/firebase_auth_service.dart';
import 'package:provider/provider.dart';

class KitchenDrawer extends StatelessWidget {
  const KitchenDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _DrawClipper(),
      child: Container(
        width: 200,
        child: Drawer(
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(30),
              padding: const EdgeInsets.only(top: 48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  DrawerItem(
                    text: "Profile",
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  DrawerItem(
                    text: "Setting",
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  DrawerItem(
                    text: "Signout",
                    onPressed: () {
                      Provider.of<FirebaseAuthService>(context, listen: false)
                          .firebaseAuth
                          .signOut();
                      Navigator.of(context).pop();
                      _openSignOutDrawer(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _openSignOutDrawer(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding:
                const EdgeInsets.only(top: 32, bottom: 32, left: 48, right: 48),
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'Are you sure you want to sign out?',
                    style: TextStyle(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Expanded(
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          _Signout(context);
                        },
                        color: Theme.of(context).scaffoldBackgroundColor,
                        child: Text(
                          "Sign out",
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("Cancel",
                            style: TextStyle(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            )),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }
}

//@TODO
void _Signout(BuildContext context) {
  Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
}

class _DrawClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.moveTo(50, 0);
    path.quadraticBezierTo(0, size.height / 2, 50, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class DrawerItem extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const DrawerItem({Key? key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5, bottom: 5),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
