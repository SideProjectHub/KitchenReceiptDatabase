import 'dart:html';

import 'package:flutter/material.dart';
import 'Components/fridge_menu.dart';
import 'Components/food_list.dart';

class UserFoodPage extends StatefulWidget {
  const UserFoodPage({Key? key}) : super(key: key);

  @override
  _UserFoodPageState createState() => _UserFoodPageState();
}

class _UserFoodPageState extends State<UserFoodPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Hello World"),
      ),
      body: Center(
        child: FoodList(
          foods: <Food>[
            Food(name: 'Eggs'),
            Food(name: 'Flour'),
            Food(name: 'Chocolate chips')
          ],
        ),
        // child: FridgeMenu(),
      ),
    );
  }
}
