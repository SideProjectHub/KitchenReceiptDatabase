import 'package:flutter/material.dart';
import 'package:project/screens/FoodPage/Components/food_list.dart';

class ReceiptPopup extends StatelessWidget {
  const ReceiptPopup({
    Key? key,
    required this.foodList,
  }) : super(key: key);

  final List<List<Food>> foodList;
  final List<String> _foodGroup = const [
    "Fruits",
    "Veggies",
    "Grains",
    "Diary",
    "Meat",
    "Misc"
  ];

  Widget _buildFoodList(BuildContext context, int index) {
    return Container(
      alignment: Alignment.bottomLeft,
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Text(
            _foodGroup[index],
            style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
          Column(
              children: List<Container>.generate(
            foodList[index].length,
            (i) {
              return Container(
                margin: EdgeInsets.only(left: 50),
                child: Text(
                  foodList[index][i].name,
                  textAlign: TextAlign.left,
                ),
              );
            },
          )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: Text("Foods Added"),
      content: SingleChildScrollView(
        child: SizedBox(
          height: 300,
          width: 300,
          child: ListView.builder(
            shrinkWrap: true,
            itemBuilder: _buildFoodList,
            itemCount: 6,
            padding: EdgeInsets.all(5),
          ),
        ),
      ),
      actions: <Widget>[
        MaterialButton(
          elevation: 5.0,
          child: Text('OK'),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        )
      ],
    );
  }
}
