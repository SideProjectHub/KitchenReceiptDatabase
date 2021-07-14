import 'package:flutter/material.dart';
import 'package:project/screens/FoodPage/Components/food_list.dart';

class FridgeCard extends StatelessWidget {
  final String title;
  final int foodAmount;
  final Color color;
  const FridgeCard({
    Key? key,
    required this.title,
    required this.foodAmount,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      borderOnForeground: true,
      color: color,
      elevation: 5,
      child: InkWell(
        splashColor: color.withAlpha(30),
        onTap: () {
          print("Card tapped.");
        },
        child: SizedBox(
          width: 300,
          height: 100,
          child: Positioned(
            child: Row(
              children: <Widget>[
                Text(title),
                Text("Food Amount: " + foodAmount.toString()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
