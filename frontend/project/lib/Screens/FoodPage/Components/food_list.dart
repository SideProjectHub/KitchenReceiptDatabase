import 'package:flutter/material.dart';

/*Food List */
/************************************************* */
class FoodList extends StatefulWidget {
  FoodList({Key? key, required this.foods}) : super(key: key);

  //Takes in list of foods
  List<Food> foods;

  @override
  _FoodListState createState() => _FoodListState();
}

class _FoodListState extends State<FoodList> {
  @override
  void _handleFoodList(Food food) {
    setState(() {
      widget.foods.remove(food);
    });
  }

  Widget build(BuildContext context) {
    return Container(
      child: Column(
        //title here
        children: [
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
      overflow: Overflow.clip,
      children: <Widget>[
        Dismissible(
            key: ObjectKey(food),
            onDismissed: (direction) {
              onFoodListChange(food);
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${food.name} deleted')));
            },
            child: Container(
                child: ListTile(title: Text(food.name)),
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
