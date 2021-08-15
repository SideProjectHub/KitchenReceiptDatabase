import 'package:flutter/material.dart';
import 'package:project/app/models/Fridge.dart';
import 'package:project/screens/FoodPage/user_food_page.dart';
import 'package:project/services/rest_api_service.dart';
import 'package:provider/provider.dart';
import 'package:project/app/models/kartUser.dart';

class FridgeCard extends StatelessWidget {
  final String fridgeID;
  final String title;
  final int foodAmount;
  final Color color;
  const FridgeCard({
    Key? key,
    required this.fridgeID,
    required this.title,
    required this.foodAmount,
    required this.color,
  }) : super(key: key);

  /** 
  * set an HTTP request for the foodList 
  * sort through the categories of foods before the page loads 
  * display the foods  
  */

  @override
  Widget build(BuildContext context) {
    return Card(
      borderOnForeground: true,
      color: color,
      elevation: 5,
      child: InkWell(
        splashColor: Colors.black.withAlpha(30),
        onTap: () async {
          var fridge;
          try {
            fridge = await RestAPIService().getFood(this.fridgeID);
          } catch (error) {
            print(error);
            fridge = FoodObjList(foodList: []);
          }
          Navigator.of(context)
              .push(MaterialPageRoute<void>(builder: (BuildContext context) {
            return UserFoodPage(fridge: fridge, fridgeID: fridgeID);
          }));
        },
        child: SizedBox(
          height: 100,
          child: Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(10),
                child: Align(
                  child: Text(
                    title,
                    style: TextStyle(fontSize: 15),
                  ),
                  alignment: Alignment.bottomLeft,
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: Align(
                  child: Text(
                    "Food Amount: " + foodAmount.toString(),
                    style: TextStyle(fontSize: 15),
                  ),
                  alignment: Alignment.bottomRight,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
