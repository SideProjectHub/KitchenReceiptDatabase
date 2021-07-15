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
        splashColor: Colors.black.withAlpha(30),
        onTap: () {
          print("Card tapped.");
        },
        child: SizedBox(
          height: 100,
          child: Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(10),
                child: Align(
                  child: Text(
                    title,
                    style: TextStyle(fontSize: 15),
                  ),
                  alignment: Alignment.bottomLeft,
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: Align(
                  child: Text(
                    "Food Amount: " + foodAmount.toString(),
                    style: TextStyle(fontSize: 15),
                  ),
                  alignment: Alignment.bottomRight,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
