import 'package:flutter/material.dart';
import 'dart:math';
import 'package:vector_math/vector_math.dart' show radians;

class FridgeMenu extends StatefulWidget {
  final Function scrollEffect;

  const FridgeMenu({
    Key? key,
    required this.scrollEffect,
  }) : super(key: key);

  createState() => _FridgeMenuState();
}

class _FridgeMenuState extends State<FridgeMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      width: double.infinity,
      height: 300,
      child:
          RadialAnimation(controller: controller, clicked: widget.scrollEffect),
    );
  }
}

class RadialAnimation extends StatelessWidget {
  RadialAnimation({Key? key, required this.controller, required this.clicked})
      : scale = Tween<double>(
          begin: 1.5,
          end: 0.0,
        ).animate(
          CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn),
        ),
        translation = Tween<double>(
          begin: 0.0,
          end: 125.0,
        ).animate(CurvedAnimation(
          parent: controller,
          curve: Curves.elasticOut,
        )),
        super(key: key);

  final AnimationController controller;
  final Animation<double> scale;
  final Animation<double> translation;
  final Function clicked;

  build(context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (context, builder) {
          return Stack(alignment: Alignment.center, children: [
            _buildButton(330,
                color: Colors.red,
                icon: Image.asset('assets/icons/fruits.png'),
                clicked: () => clicked(0)),
            _buildButton(30,
                color: Colors.green,
                icon: Image.asset('assets/icons/veggies.png'),
                clicked: () => clicked(1)),
            _buildButton(210,
                color: Colors.yellow,
                icon: Image.asset('assets/icons/grains.png'),
                clicked: () => clicked(2)),
            _buildButton(270,
                color: Colors.blue,
                icon: Image.asset('assets/icons/diary.png'),
                clicked: () => clicked(3)),
            _buildButton(90,
                color: Colors.brown,
                icon: Image.asset('assets/icons/meat.png'),
                clicked: () => clicked(4)),
            _buildButton(150,
                color: Colors.grey,
                icon: Image.asset('assets/icons/misc.png'),
                clicked: () => clicked(5)),
            Transform.scale(
              scale: scale.value - 1.5,
              child: new IconButton(
                  icon: Image.asset('assets/images/opened_fridge.png'),
                  iconSize: 75,
                  onPressed: _close),
            ),
            Transform.scale(
              scale: scale.value,
              child: new IconButton(
                  icon: Image.asset('assets/images/closed_fridge.PNG'),
                  iconSize: 75,
                  onPressed: _open),
            ),
          ]);
        });
  }

  _buildButton(double angle,
      {required Color color, required Image icon, required Function clicked}) {
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
          icon: icon,
          iconSize: 30,
          color: Colors.white,
          onPressed: () => _close(clicked: clicked),
        ),
      )),
    );
  }

  _open() {
    print("open");
    controller.forward();
  }

  _close({Function? clicked}) {
    print("hello ");
    controller.reverse();
    if (clicked != null) {
      print("In");
      clicked();
    }
  }
}
