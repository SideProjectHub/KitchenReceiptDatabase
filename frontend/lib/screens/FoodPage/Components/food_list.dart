import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

/*Food List */
/************************************************* */
class FoodList extends StatefulWidget {
  FoodList({
    Key? key,
    required this.foods,
    required this.category,
    required this.color,
  }) : super(key: key);

  //Takes in list of foods
  List<Food> foods;
  String category;
  Color color;

  @override
  FoodListState createState() => FoodListState();
}

class FoodListState extends State<FoodList> {
  @override
  void _handleFoodList(Food food) {
    setState(() {
      widget.foods.remove(food);
    });
  }

  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: Column(
        //title here
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(4), topRight: Radius.circular(4)),
              shape: BoxShape.rectangle,
              color: widget.color,
            ),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 20),
                  child: Text(
                    '${widget.category}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                  ),
                ),
              ],
            ),
          ),
          ListView(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(vertical: 8.0),
            children: widget.foods.map((Food food) {
              return FoodListItem(
                food: food,
                onFoodListChange: _handleFoodList,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

typedef void FoodChanged(Food food);

/*UI for each individual Food*/
/************************************************* */
class FoodListItem extends StatelessWidget {
  FoodListItem({
    required this.food,
    required this.onFoodListChange,
  }) : super(key: ObjectKey(food));

  final Food food;
  final FoodChanged onFoodListChange;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.hardEdge,
      children: <Widget>[
        Dismissible(
            key: ObjectKey(food),
            onDismissed: (direction) {
              onFoodListChange(food);
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${food.name} deleted')));
            },
            child: Container(
                child: ListTile(
                    title: Text(
                  food.name,
                  style: TextStyle(color: Colors.black),
                )),
                decoration: new BoxDecoration(
                    border: new Border(bottom: new BorderSide()))),
            background: Container(color: Colors.red.withOpacity(0.5))),
      ],
    );
  }
}

/*Specific Food Class*/
/************************************************* */
class Food {
  const Food({required this.name});
  final String name;
  //@todo: Additional attributes maybe added here (e.g. quantity)
}
