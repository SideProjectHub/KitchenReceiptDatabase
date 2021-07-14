import 'package:flutter/material.dart';
import 'package:project/screens/ProfilePage/user_profile_screen.dart';
import 'Screens/FoodPage/user_food_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Hello",
      theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Colors.black,

        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
        ),
      ),
      home: ProfilePage(),
    );
    // return MaterialApp(title: 'FoodPage', home: UserFoodPage());
  }
}
