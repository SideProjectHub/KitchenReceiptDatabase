import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'fridge_card.dart';

class FridgeDashBoard extends StatelessWidget {
  final List<FridgeCard> cards;
  const FridgeDashBoard({
    Key? key,
    required this.cards,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView(
        children: <Widget>[
          CarouselSlider(
              options: CarouselOptions(
                height: 125.0,
                enlargeCenterPage: true,
                autoPlayCurve: Curves.fastOutSlowIn,
                viewportFraction: 0.8,
                enableInfiniteScroll: true,
              ),
              items: cards)
        ],
      ),
    );
  }
}
