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

  PanelController panelController = new PanelController();

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
    for (var i = 1; i < 6; i++) {
      height[i] =
          (tabKeys[i - 1].currentContext?.size?.height ?? height[i - 1]) +
              height[i - 1];
    }
    setState(() {});
  }

  void scrollEffect(int index) {
    if (foodScroll.hasClients) {
      panelController.open();
      foodScroll.animateTo(height[index],
          duration: Duration(seconds: 1), curve: Curves.easeIn);
    }
  }

  BorderRadiusGeometry radius = BorderRadius.only(
    topLeft: Radius.circular(24.0),
    topRight: Radius.circular(24.0),
  );

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
              controller: panelController,
              renderPanelSheet: false,
              maxHeight: MediaQuery.of(context).size.height - 100,
              minHeight: MediaQuery.of(context).size.height * 0.4,
              isDraggable: true,
              backdropEnabled: true,
              borderRadius: radius,
              panel: Container(
                margin: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: radius,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 20.0,
                        color: Colors.grey,
                      ),
                    ]),
                child: Column(
                  children: [
                    FoodToolbar(),
                    Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        controller: foodScroll,
                        children: List<int>.generate(6, (i) => i)
                            .map<Widget>((index) {
                          return FoodList(
                            key: tabKeys[index],
                            foods: widget.foods[index],
                            category: foodGroup[index],
                            color: colors[index],
                          );
                        }).toList(),
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
