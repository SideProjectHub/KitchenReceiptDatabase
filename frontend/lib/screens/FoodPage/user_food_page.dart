import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'Components/fridge_menu.dart';
import 'Components/food_list.dart';
import 'Components/food_toolbar.dart';
import 'Components/food_methods.dart';

class UserFoodPage extends StatefulWidget {
  const UserFoodPage({Key? key}) : super(key: key);

  final List<List<Food>> foods = const [
    <Food>[
      const Food(name: 'Apples'),
      const Food(name: 'Oranges'),
    ],
    <Food>[
      const Food(name: 'Lettece'),
      const Food(name: 'Zucchini'),
    ],
    <Food>[
      const Food(name: 'Apples'),
      const Food(name: 'Oranges'),
      const Food(name: 'Apples'),
      const Food(name: 'Oranges'),
    ],
    <Food>[
      const Food(name: 'Lettece'),
      const Food(name: 'Zucchini'),
    ],
    <Food>[
      const Food(name: 'Apples'),
      const Food(name: 'Oranges'),
    ],
    <Food>[
      const Food(name: 'Lettece'),
      const Food(name: 'Zucchini'),
    ],
  ];

  @override
  _UserFoodPageState createState() => _UserFoodPageState();
}

class _UserFoodPageState extends State<UserFoodPage> {
  //Keys to get the height of each tab in the food page
  final List<GlobalKey<FoodListState>> tabKeys =
      List<GlobalKey<FoodListState>>.generate(
          6, (index) => GlobalKey<FoodListState>());

  //List of heights for each tab page
  final List<double> height = List<double>.generate(6, (index) => 0);

  //Manages animations for food_menu
  final ScrollController foodScroll = ScrollController();

  final ScrollController dragScroll = ScrollController();

  final List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.yellow,
    Colors.blue,
    Colors.brown,
    Colors.grey
  ];
  final List<String> foodGroup = [
    "Fruits",
    "Veggies",
    "Grains",
    "Diary",
    "Meat",
    "Misc"
  ];

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) => setHeight());
    super.initState();
  }

  setHeight() {
    for (var i = 0; i < 6; i++) {
      height[i] = tabKeys[i].currentContext?.size?.height ?? 0;
      if (i > 0) {
        height[i] = height[i] + height[i - 1];
      }
      print(height[i]);
    }
    setState(() {});
  }

  void scrollEffect(int index) {
    print(foodScroll.position);
    print(foodScroll.hasClients);
    if (foodScroll.hasClients) {
      foodScroll.animateTo(height[index],
          duration: Duration(seconds: 1), curve: Curves.easeIn);
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("My Fridge"),
      ),
      body: FoodMethods(
        child: Stack(
          children: [
            FridgeMenu(
              scrollEffect: scrollEffect,
            ),
            SlidingUpPanel(
              maxHeight: MediaQuery.of(context).size.height - 100,
              minHeight: 300,
              isDraggable: true,
              panel: Container(
                color: Colors.white70,
                child: Column(
                  children: [
                    FoodToolbar(),
                    Expanded(
                      child: ListView.builder(
                        controller: foodScroll,
                        itemCount: 6,
                        itemBuilder: (BuildContext innerContext, int index) {
                          return FoodList(
                            key: tabKeys[index],
                            foods: widget.foods[index],
                            category: foodGroup[index],
                            color: colors[index],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
