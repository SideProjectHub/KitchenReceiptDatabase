import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:async';
import 'package:project/app/models/Fridge.dart';
import 'package:project/screens/FoodPage/Components/food_list.dart';
import 'package:project/screens/FoodPage/Components/receipt_popup.dart';
import 'package:project/services/rest_api_service.dart';

class FoodMethods extends InheritedWidget {
  FoodMethods({
    Key? key,
    required Widget child,
    required this.fridgeID,
    required this.updateList,
  }) : super(key: key, child: child);

  final String fridgeID; //FridgeID
  final Function updateList;
  final ImagePicker _picker = ImagePicker(); //Intialize ImagePicker API

  static FoodMethods of(BuildContext context) {
    final FoodMethods? result =
        context.dependOnInheritedWidgetOfExactType<FoodMethods>();
    assert(result != null, 'No FoodMethods found  in context');
    return result!;
  }

  @override
  bool updateShouldNotify(FoodMethods old) => old != this;

  Future<void> getReceiptPic(BuildContext context) async {
    try {
      print("Trying");
      final PickedFile? pickedFile =
          await _picker.getImage(source: ImageSource.camera);
      FoodObjList list =
          FoodObjList.fromJson(await _handleImage(pickedFile) as List);
      var addedList = updateList(list);

      // List<List<Food>> addedList = [
      //   [Food(name: "Apples", foodID: "2123")],
      //   [Food(name: "Apples", foodID: "2123")],
      //   [Food(name: "Apples", foodID: "2123")],
      //   [Food(name: "Apples", foodID: "2123")],
      //   [Food(name: "Apples", foodID: "2123")],
      //   [Food(name: "Apples", foodID: "2123")]
      // ];
      await createReceiptDialog(context, addedList);
    } catch (e) {
      print(e);
      _handleError("Error");
    }
  }

  //@TODO
  Future<String> _handleImage(PickedFile? pickedFile) async {
    if (pickedFile == null) {
      throw Exception("File is of Null type");
    }

    var response = await RestAPIService().addReceipt(fridgeID, pickedFile);
    // Google ML not working with web services
    // InputImage inputImage = InputImage.fromFile(file);
    // TextDetector textDetector = GoogleMlKit.vision.textDetector();
    // RecognisedText visionText = await textDetector.processImage(inputImage);
    // print(visionText.text);

    return response.stream.bytesToString();
  }

  void _handleError(String? error) {
    print(error);
  }

  var dropDownList = ["Fruit", "Dairy", "Veggie", "Grain", "Meat", "Misc"];

  void postData(context, quantity, foodName, description, category) async {
    Map<String, dynamic> body = {
      "quantity": quantity.toString(),
      "foodName": foodName.toString(),
      "description": description.toString(),
      "category": category.toString(),
    };

    final response = await RestAPIService().addFood(fridgeID, body);

    if (response.statusCode == 200) {
      Map js = json.decode(response.body);
      FoodObjList fridgeList = FoodObjList(foodList: [
        FoodObj(
            foodID: js['foodId'], //how am i going to get the foodID?
            quantity: int.parse(quantity),
            foodName: foodName,
            description: description,
            category: category)
      ]);
      updateList(fridgeList);
      Navigator.pop(context);
    }
    // final response = await http.post(
    //   Uri.parse("http://localhost:4000/routes/addfood"),
    //   headers: {
    //     'Content-Type': 'application/json',
    //     'Accept': 'application/json'
    //   },
    //   body: json.encode(body),
    // );
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

//Creates popup after backend parses receipt
//@return <bool> -> User acknowledgement of new foodList
Future<dynamic> createReceiptDialog(
    BuildContext context, List<List<Food>> foodList) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return ReceiptPopup(
          foodList: foodList,
        );
      });
}
