import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'Components/fridge_menu.dart';
import 'Components/food_list.dart';
import 'Components/food_toolbar.dart';

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
  final _picker = ImagePicker(); //Intialize ImagePicker API

  Future<void> getReceiptPic() async {
    final PickedFile?  pickedFile=
        await _picker.getIpickedFilemage(source: ImageSource.camera);

    if (pickedFile.isEmpty) {
      return;
    }
    if (pickedFile.file != null) {
      setState(() => _handleImage(pickedFile));
    } else {
      _handleError(pickedFile.exception)
    }
  }

  //@TODO
  void _handleImage(PickedFile? file) {
    return;
  }

  void _handleError(String? error){ 
    print(error); 
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
              child: ListView(
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
