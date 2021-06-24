import 'package:flutter/material.dart';

/*Food List */
/************************************************* */
class FoodList extends StatefulWidget {
  const FoodList({Key? key, required this.foods}) : super(key: key);

  //Takes in list of foods
  List<Food> foods;

  @override
  _FoodListState createState() => _FoodListState();
}

class _FoodListState extends State<FoodList> {
  @override

  void _handleFoodList(Food food){ 
    setState(() { 
      widget.foods.remove(food); 
    });
  }

  Widget build(BuildContext context) {
    return Container(
      children: [ 
        //title here 
        ListView( 
          padding: EdgeInsets.symmetric(vertical: 8.0), 
          children: widget.foods.map((Food food)) { 
            return FoodListItem( 
              food: food, 
              onFoodListChange: _handleFoodList,
            );
          },
        ), 
      ],
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
    return Listview( 
      title: Text(product.name), 
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
