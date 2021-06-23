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
    controller = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
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
        translation = Tween<double>(
          begin: 0.0,
          end: 150.0,
        ).animate(CurvedAnimation(
          parent: controller,
          curve: Curves.elasticOut,
        )),
        super(key: key);

  final AnimationController controller;
  final Animation<double> scale;
  final Animation<double> translation;

  build(context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (context, builder) {
          return Stack(alignment: Alignment.center, children: [
            _buildButton(330,
                color: Colors.red,
                icon: Image.asset('assets/icons/fruits.png')),
            _buildButton(30,
                color: Colors.green,
                icon: Image.asset('assets/icons/veggies.png')),
            _buildButton(90,
                color: Colors.brown,
                icon: Image.asset('assets/icons/meat.png')),
            _buildButton(150,
                color: Colors.grey, icon: Image.asset('assets/icons/misc.png')),
            _buildButton(210,
                color: Colors.yellow,
                icon: Image.asset('assets/icons/grains.png')),
            _buildButton(270,
                color: Colors.blue,
                icon: Image.asset('assets/icons/diary.png')),
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

  _buildButton(double angle, {required Color color, required Image icon}) {
    final double rad = radians(angle);
    return Transform(
      transform: Matrix4.identity()
        ..translate(
          (translation.value) * cos(rad),
          (translation.value) * sin(rad),
        ),
      child: Center(
          child: new Ink(
        decoration: new ShapeDecoration(
          color: color,
          shape: CircleBorder(),
        ),
        child: new IconButton(
            icon: icon, iconSize: 50, color: Colors.white, onPressed: _close),
      )),
    );
  }

  _open() {
    controller.forward();
  }

  _close() {
    print("Hello");
    controller.reverse();
  }
}
