import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/screens/FoodPage/Components/food_list.dart';
import 'package:project/screens/FoodPage/user_food_page.dart';
import 'package:project/services/firebase_auth_service.dart';
import 'package:project/services/rest_api_service.dart';
import 'package:provider/provider.dart';
import 'package:project/app/models/kartUser.dart';
import 'package:http/http.dart' as http;

class FridgeCard extends StatelessWidget {
  final String title;
  final int foodAmount;
  final Color color;
  const FridgeCard({
    Key? key,
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
          var resp;  
          RestAPIService restapi = new RestAPIService();
          // ignore: todo
          // TODO : replace user uid with fridge uid.
          String? uid = Provider.of<kartUser?>(context)?.uid;
          /** here we wait to push the contents of the http request to the second widget **/ 
          Future.delayed(Duration.zero, () async {
             resp = await restapi.getFridge(uid ?? 'null_uid');
          });

          Navigator.of(context)
              .push(MaterialPageRoute<void>(builder: (BuildContext context) {
            return UserFoodPage(
              response: resp,
            );
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
