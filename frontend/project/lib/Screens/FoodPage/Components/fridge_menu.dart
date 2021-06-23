import 'package:flutter/material.dart';
import 'dart:math';
import 'package:vector_math/vector_math.dart' show radians;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FridgeMenu extends StatefulWidget {
  createState() => _FridgeMenuState();
}

class _FridgeMenuState extends State<FridgeMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: Duration(milliseconds: 900), vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return RadialAnimation(controller: controller);
  }
}

class RadialAnimation extends StatelessWidget {
  RadialAnimation({Key? key, required this.controller})
      : scale = Tween<double>(
          begin: 1.5,
          end: 0.0,
        ).animate(
          CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn),
        ),
        super(key: key);

  final AnimationController controller;
  final Animation<double> scale;

  build(context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (context, builder) {
          return Stack(alignment: Alignment.center, children: [
            Transform.scale(
              scale: scale.value - 1.5,
              child: new IconButton(
                  icon: Image.asset('assets/images/opened_fridge.png'),
                  iconSize: 100,
                  onPressed: _close),
            ),
            Transform.scale(
              scale: scale.value,
              child: new IconButton(
                  icon: Image.asset('assets/images/closed_fridge.PNG'),
                  iconSize: 100,
                  onPressed: _open),
            ),
          ]);
        });
  }

  _open() {
    controller.forward();
  }

  _close() {
    controller.reverse();
  }
}
