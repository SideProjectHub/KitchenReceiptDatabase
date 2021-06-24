import 'package:flutter/material.dart';

class FoodList extends StatefulWidget {
  const FoodList({Key? key, required this.foods}) : super(key: key);

  //Takes in list of foods
  final List<Food> foods;

  @override
  _FoodListState createState() => _FoodListState();
}

class _FoodListState extends State<FoodList> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class FoodListItem extends StatelessWidget {
  const FoodListItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class Food {
  const Food({required this.name});
  final String name;
}
