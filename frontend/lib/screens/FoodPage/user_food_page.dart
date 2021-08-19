import 'package:flutter/material.dart';
import 'package:project/app/models/Fridge.dart';
import 'package:project/app/models/UserData.dart';
import 'package:project/app/models/kartUser.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'Components/fridge_menu.dart';
import 'Components/food_list.dart';
import 'Components/food_toolbar.dart';
import 'Components/food_methods.dart';

enum food_groups { Fruits, Veggies, Grains, Dairy, Meat, Misc }

class UserFoodPage extends StatefulWidget {
  UserFoodPage({Key? key, required this.fridge, required this.fridgeID})
      : super(key: key);

  final FoodObjList fridge;
  final String fridgeID;

  @override
  _UserFoodPageState createState() => _UserFoodPageState();
}

/**
 * sorts the incoming foods and assigns them to their instance variables. 
 * @param: response: variable returned from fridge_card that 
 */

class _UserFoodPageState extends State<UserFoodPage> {
  //Contains the state fridgeList
  List<List<Food>> foods = [[], [], [], [], [], []];

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
  static const List<String> foodGroup = [
    "Fruits",
    "Veggies",
    "Grains",
    "Diary",
    "Meat",
    "Misc"
  ];

  @override
  void initState() {
    sortFoods(widget.fridge);
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

  updateList(FoodObjList fridge) {
    sortFoods(fridge);
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
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.orange),
          onPressed: () {
            String? uid = Provider.of<kartUser?>(context, listen: false)?.uid;
            Provider.of<UserData>(context, listen: false).update(uid);
            Navigator.of(context).pop();
          },
        ),
        title: Text("My Fridge"),
      ),
      body: FoodMethods(
        fridgeID: widget.fridgeID,
        updateList: updateList,
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
                            foods: foods[index],
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

  /**
   * Sorts Foods in the fridge 
   * @param: fridge assumed to be non-null, populates instance variables necessary 
   */
  void sortFoods(FoodObjList fridge) {
    List<FoodObj> fridgeList = fridge.foodList;
    for (int i = 0; i < fridgeList.length; i++) {
      var foodName = fridgeList[i].category;
      switch (foodName) {
        case "Fruit":
          foods[food_groups.Fruits.index].insert(0,
              Food(name: fridgeList[i].foodName, foodID: fridgeList[i].foodID));
          break;
        case "Veggie":
          foods[food_groups.Veggies.index].insert(0,
              Food(name: fridgeList[i].foodName, foodID: fridgeList[i].foodID));
          break;
        case "Grain":
          foods[food_groups.Grains.index].insert(0,
              Food(name: fridgeList[i].foodName, foodID: fridgeList[i].foodID));
          break;
        case "Dairy":
          foods[food_groups.Dairy.index].insert(0,
              Food(name: fridgeList[i].foodName, foodID: fridgeList[i].foodID));
          break;
        case "Meat":
          foods[food_groups.Meat.index].insert(0,
              Food(name: fridgeList[i].foodName, foodID: fridgeList[i].foodID));
          break;
        case "Misc":
          foods[food_groups.Misc.index].insert(0,
              Food(name: fridgeList[i].foodName, foodID: fridgeList[i].foodID));
          break;
      }
    }
  }
}
