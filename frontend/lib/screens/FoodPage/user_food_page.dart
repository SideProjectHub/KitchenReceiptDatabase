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
  var dropDownList = ["Fruit", "Dairy", "Vegie", "Grain", "Meat", "Misc"];

  void postData(quantity, foodName, description, category) async{
    Map<String, dynamic> body = {
      "quantity": quantity.toString(),
      "foodName": foodName.toString(),
      "description": description.toString(),
      "category": category.toString(),
    };
    final response = await http.post(
      Uri.parse("http://localhost:4000/routes/addfood"),
      headers: {'Content-Type': 'application/json','Accept': 'application/json'},
      body: json.encode(body),
      );
    print(response.body);
  }

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _inputModal(context);
        },
      ),
    );
  }

  void _inputModal(context){
    showModalBottomSheet(context: context, builder: (BuildContext bc){ 
      String? dropDownValue = null;
      TextEditingController quantityVal = new TextEditingController();
      TextEditingController foodNameVal = new TextEditingController();
      TextEditingController descriptionVal = new TextEditingController();
      return Container(
        child: StatefulBuilder(
          builder: (BuildContext context, StateSetter stateSetter){
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:[
                TextField(
                  controller: foodNameVal,
                  decoration: InputDecoration(
                    fillColor: Colors.blueGrey,
                    filled: true,
                    border: OutlineInputBorder(),
                    hintText: 'Food Name'
                  ),
                ),
                TextField(
                  controller: quantityVal,
                  decoration: InputDecoration(
                    fillColor: Colors.blueGrey,
                    filled: true,
                    border: OutlineInputBorder(),
                    hintText: 'Quantity'
                  ),
                ),
                TextField(
                  controller: descriptionVal,
                  decoration: InputDecoration(
                    fillColor: Colors.blueGrey,
                    filled: true,
                    border: OutlineInputBorder(),
                    hintText: 'Description'
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 5),
                  child: DropdownButton(
                    dropdownColor: Colors.blueGrey,
                    items: dropDownList.map((itemName){
                      return DropdownMenuItem(
                        value: itemName,
                        child: Text(itemName));
                    }).toList(),
                    onChanged: (String? newVal){
                      stateSetter(() => dropDownValue = newVal); 
                    },
                    value: dropDownValue,
                    hint: Text("Select Category"),
                  ),
                ),
                TextButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                  ),
                  onPressed: () => postData(quantityVal.text, foodNameVal.text, descriptionVal.text, dropDownValue),
                  child: Text('Submit'),
                ),
              ]
            );
          }),
      );
    });
  }
}