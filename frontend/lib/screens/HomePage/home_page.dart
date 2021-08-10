import 'package:flutter/material.dart';
import 'package:project/screens/HomePage/components/fridge_card.dart';
import 'package:project/screens/HomePage/components/fridge_dashboard.dart';
import 'package:project/widgets/custom_app_bar.dart';
import 'package:project/widgets/kitchen_drawer.dart';
import 'package:project/widgets/profile_pic.dart';
import 'package:provider/provider.dart';
import '../../app/models/kartUser.dart';

import 'package:project/services/rest_api_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  final List<FridgeCard> cards = const [
    const FridgeCard(title: "Fridge 1", foodAmount: 10, color: Colors.red),
    const FridgeCard(title: "Fridge 2", foodAmount: 20, color: Colors.green),
    const FridgeCard(title: "Fridge 3", foodAmount: 30, color: Colors.blue),
  ];

  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => HomePage(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              child: Builder(builder: (context) {
                return CustomAppBar(
                  leading: const Text(""),
                  trailing: IconButton(
                    onPressed: () => Scaffold.of(context).openEndDrawer(),
                    icon: const Icon(Icons.menu),
                  ),
                  title: "Home",
                  childHeight: 0,
                  height: 115,
                  isBig: false,
                  child: ProfilePic(diameter: 100),
                );
              }),
            ),
            Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 20, right: 10),
                  child: Text(
                    "Fridges",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Divider(
                    color: Colors.grey,
                    thickness: 5,
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    child: FloatingActionButton(
                        onPressed: () => _AddFridge(context),
                        backgroundColor: Colors.grey,
                        child: const Icon(Icons.add),
                        mini: true)),
              ],
            ),
            FridgeDashBoard(cards: cards),
          ],
        ),
      ),
      endDrawer: KitchenDrawer(),
    );
  }

  void postFridge(context, fridgeName, descriptionVal, color) async {
    String? uid = Provider.of<kartUser?>(context, listen: false)?.uid;
    Map<String, dynamic> body = {
      "fridgeName": fridgeName.toString(),
      "descriptionVal": descriptionVal.toString(),
      "color": color.toString()
    };
    if (uid == null) {
      throw ("uid is false");
    }
    final response = await RestAPIService().addFridge(uid, body);
    print(response.body);
    Navigator.pop(context);
  }

  final List<String> dropDownList = const [
    "Red",
    "Orange",
    "Yellow",
    "Green",
    "Blue",
    "Purple"
  ];

  void _AddFridge(parentContext) {
    showModalBottomSheet(
        context: parentContext,
        builder: (BuildContext bc) {
          String? dropDownValue = null;
          TextEditingController fridgeName = new TextEditingController();
          TextEditingController descriptionVal = new TextEditingController();
          return Container(
            child: StatefulBuilder(
                builder: (BuildContext context, StateSetter stateSetter) {
              return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextField(
                      controller: fridgeName,
                      decoration: InputDecoration(
                          fillColor: Colors.blue,
                          filled: true,
                          border: OutlineInputBorder(),
                          hintText: 'Fridge Name'),
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
                        hint: Text("Select Color"),
                      ),
                    ),
                    TextButton(
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                      ),
                      onPressed: () => postFridge(parentContext,
                          fridgeName.text, descriptionVal.text, dropDownValue),
                      child: Text('Submit'),
                    ),
                  ]);
            }),
          );
        });
  }
}
