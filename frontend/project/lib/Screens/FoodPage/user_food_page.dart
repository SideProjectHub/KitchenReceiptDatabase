import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserFoodPage extends StatefulWidget {
  const UserFoodPage({Key? key}) : super(key: key);

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
        title: Text("Hello World"),
      ),
      body: Center(
        child: Image.asset('images/closed_fridge.PNG'),
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