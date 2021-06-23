import 'package:flutter/material.dart';
import 'Screens/FoodPage/user_food_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'FoodPage', home: UserFoodPage());
  }
}
