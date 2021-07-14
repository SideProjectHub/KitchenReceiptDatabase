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
    return ListView(
      children: <Widget>[
        CarouselSlider(
            options: CarouselOptions(
              height: 180.0,
              enlargeCenterPage: true,
              autoPlay: true,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              viewportFraction: 0.8,
            ),
            items: cards)
      ],
    );
  }
}
