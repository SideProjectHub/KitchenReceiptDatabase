import 'package:flutter/material.dart';
import 'package:project/app/models/Fridge.dart';
import 'package:project/screens/FoodPage/user_food_page.dart';
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
        onTap: () {
          var fridge; //potential error here
          /** here we wait to push the contents of the http request to the second widget **/
          Future.delayed(Duration.zero, () async {
            String? uid = Provider.of<kartUser?>(context, listen: false)?.uid;
            fridge = await Fridge.fetchFridge(context, uid);
          });

          Navigator.of(context)
              .push(MaterialPageRoute<void>(builder: (BuildContext context) {
            return UserFoodPage(fridge: fridge);
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
