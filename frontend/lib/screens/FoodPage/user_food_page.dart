import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'Components/fridge_menu.dart';
import 'Components/food_list.dart';
import 'Components/food_toolbar.dart';
import 'Components/food_methods.dart';

class UserFoodPage extends StatefulWidget {
  const UserFoodPage({Key? key}) : super(key: key);

  final List<Food> fruits = const <Food>[
    const Food(name: 'Apples'),
    const Food(name: 'Oranges'),
    const Food(name: 'Bananas')
  ];

  final List<Food> veggies = const <Food>[
    const Food(name: 'Lettece'),
    const Food(name: 'Zucchini'),
    const Food(name: 'Salad'),
    const Food(name: 'something else')
  ];

  @override
  _UserFoodPageState createState() => _UserFoodPageState();
}

class _UserFoodPageState extends State<UserFoodPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("My Fridge"),
      ),
      body: Stack(
        children: [
          FridgeMenu(),
          DraggableScrollableSheet(
            maxChildSize: 1.0,
            initialChildSize: 0.4,
            minChildSize: 0.4,
            expand: true,
            builder: (context, scrollController) => Container(
              color: Colors.white70,
              child: FoodMethods(
                child: Builder(
                  builder: (BuildContext innerContext) {
                    return ListView(
                      controller: scrollController,
                      children: [
                        FoodToolbar(),
                        FoodList(
                            foods: widget.fruits,
                            category: "Fruits",
                            color: Colors.red),
                        FoodList(
                            foods: widget.veggies,
                            category: "Veggies",
                            color: Colors.green),
                        FoodList(
                            foods: widget.fruits,
                            category: "Grains",
                            color: Colors.yellow),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
