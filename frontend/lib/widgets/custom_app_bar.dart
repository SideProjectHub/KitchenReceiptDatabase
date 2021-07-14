import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final Widget leading, trailing, child;
  final double height, childHeight;
  final String title;
  final bool isBig;

  const CustomAppBar({
    Key? key,
    required this.leading,
    required this.trailing,
    required this.title,
    required this.childHeight,
    required this.height,
    required this.isBig,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipPath(
          clipper: _AppBarClipper(
            isBig: isBig,
            childHeight: childHeight,
          ),
          child: Container(
            padding: const EdgeInsets.only(top: 32),
            color: Theme.of(context).primaryColor,
            height: height,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                leading,
                TextButton(
                  onPressed: null,
                  child: Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                  ),
                ),
                trailing,
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: isBig ? child : Container(),
          ),
        ),
      ],
    );
  }
}

class _AppBarClipper extends CustomClipper<Path> {
  final bool isBig;
  final double childHeight;

  const _AppBarClipper({
    required this.isBig,
    required this.childHeight,
  });

  @override
  Path getClip(Size size) {
    double height = isBig ? size.height - (childHeight / 4) : size.height;

    Path path = Path();

    path.moveTo(0, height - 40);
    path.quadraticBezierTo(size.width / 2, height, size.width, height - 40);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
