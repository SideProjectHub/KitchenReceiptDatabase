import 'package:flutter/material.dart';
import 'package:project/screens/HomePage/components/fridge_card.dart';
import 'package:project/screens/HomePage/components/fridge_dashboard.dart';
import 'package:project/widgets/custom_app_bar.dart';
import 'package:project/widgets/profile_pic.dart';

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
      body: Column(
        children: <Widget>[
          Container(
            child: Builder(builder: (BuildContext context) {
              return CustomAppBar(
                leading: const Text(""),
                trailing: const Text(""),
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
                  margin: EdgeInsets.only(left: 10, right: 10, bottom: 20),
                  child: FloatingActionButton(
                      onPressed: _AddFridge,
                      backgroundColor: Colors.grey,
                      child: const Icon(Icons.add),
                      mini: true)),
            ],
          ),
          FridgeDashBoard(cards: cards),
        ],
      ),
    );
  }

  void _AddFridge() {
    return;
  }
}
