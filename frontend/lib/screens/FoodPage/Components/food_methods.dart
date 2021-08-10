import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/Screens/FoodPage/Components/food_list.dart';

import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FoodMethods extends InheritedWidget {
  FoodMethods({
    Key? key,
    required Widget child,
  }) : super(key: key, child: child);

  final ImagePicker _picker = ImagePicker(); //Intialize ImagePicker API

  static FoodMethods of(BuildContext context) {
    final FoodMethods? result =
        context.dependOnInheritedWidgetOfExactType<FoodMethods>();
    assert(result != null, 'No FoodMethods found  in context');
    return result!;
  }

  @override
  bool updateShouldNotify(FoodMethods old) => old != this;

  Future<void> getReceiptPic() async {
    try {
      final PickedFile? pickedFile =
          await _picker.getImage(source: ImageSource.camera);
      _handleImage(pickedFile);
    } catch (e) {
      _handleError("Error");
    }
  }

  //@TODO
  void _handleImage(PickedFile? file) {
    return;
  }

  void _handleError(String? error) {
    print(error);
  }

  var dropDownList = ["Fruit", "Dairy", "Vegie", "Grain", "Meat", "Misc"];

  void postData(context, quantity, foodName, description, category) async {
    Map<String, dynamic> body = {
      "quantity": quantity.toString(),
      "foodName": foodName.toString(),
      "description": description.toString(),
      "category": category.toString(),
    };
    final response = await http.post(
      Uri.parse("http://localhost:4000/routes/addfood"),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      },
      body: json.encode(body),
    );
    print(response.body);
  }

  void inputModal(parentContext) {
    showModalBottomSheet(
        context: parentContext,
        builder: (BuildContext bc) {
          String? dropDownValue = null;
          TextEditingController quantityVal = new TextEditingController();
          TextEditingController foodNameVal = new TextEditingController();
          TextEditingController descriptionVal = new TextEditingController();
          return Container(
            child: StatefulBuilder(
                builder: (BuildContext context, StateSetter stateSetter) {
              return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextField(
                      controller: foodNameVal,
                      decoration: InputDecoration(
                          fillColor: Colors.blue,
                          filled: true,
                          border: OutlineInputBorder(),
                          hintText: 'Food Name'),
                    ),
                    TextField(
                      controller: quantityVal,
                      decoration: InputDecoration(
                          fillColor: Colors.blue,
                          filled: true,
                          border: OutlineInputBorder(),
                          hintText: 'Quantity'),
                    ),
                    TextField(
                      controller: descriptionVal,
                      decoration: InputDecoration(
                          fillColor: Colors.blue,
                          filled: true,
                          border: OutlineInputBorder(),
                          hintText: 'Description'),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 5),
                      child: DropdownButton(
                        dropdownColor: Colors.blue,
                        items: dropDownList.map((itemName) {
                          return DropdownMenuItem(
                              value: itemName, child: Text(itemName));
                        }).toList(),
                        onChanged: (String? newVal) {
                          stateSetter(() => dropDownValue = newVal);
                        },
                        value: dropDownValue,
                        hint: Text("Select Category"),
                      ),
                    ),
                    TextButton(
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                      ),
                      onPressed: () => postData(parentContext, quantityVal.text,
                          foodNameVal.text, descriptionVal.text, dropDownValue),
                      child: Text('Submit'),
                    ),
                  ]);
            }),
          );
        });
  }
}
