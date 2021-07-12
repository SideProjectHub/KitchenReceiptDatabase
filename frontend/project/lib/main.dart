import 'package:flutter/material.dart';
import 'package:project/widgets/profile_pic.dart';
import 'Screens/FoodPage/user_food_page.dart';
import 'widgets/custom_app_bar.dart';

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
        iconTheme: IconThemeData(
          color: Colors.white,
        ),

        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
        ),
      ),
      home: Scaffold(
        body: Column(
          children: <Widget>[
            Builder(builder: (BuildContext context) {
              return CustomAppBar(
                leading: const Text(""),
                trailing: const Text(""),
                title: "Profile",
                childHeight: 100,
                height: 225,
                isBig: true,
                child: ProfilePic(diameter: 100),
              );
            }),
            const Text("Hello World"),
          ],
        ),
      ),
    );
    // return MaterialApp(title: 'FoodPage', home: UserFoodPage());
  }
}
