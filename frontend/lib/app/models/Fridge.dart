import 'dart:convert';
import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:project/screens/FoodPage/Components/food_list.dart';
import 'package:project/services/rest_api_service.dart';
import 'package:provider/provider.dart';

import 'kartUser.dart';

class Fridge {
  final String fridgeName;
  final int fridgeCount;
  final String cardColor;
  //here this should be renamed <FOOD>
  final List<FoodObj> foodList;

  Fridge({
    required this.fridgeName,
    required this.fridgeCount,
    required this.cardColor,
    required this.foodList,
  });

  //TODO: potential issue w/ foodList since list of type Food Schema, add a potential class?

  factory Fridge.fromJson(Map<String, dynamic> json) {
    return Fridge(
      fridgeName: json['fridgeName'],
      fridgeCount: json['fridgeCount'],
      cardColor: json['cardColor'],
      foodList: json['foodList'],
    );
  }

  /**
   * fetches fridge from Database and parses JSON into a Dart Class 
   * @param: context, used for grabbing the kartUser's uid for the fridge via the MultiProvider<KartUser?> 
   */
  static Future<Fridge> fetchFridge(BuildContext context) async {
    RestAPIService restapi = new RestAPIService();
    String? uid = Provider.of<kartUser?>(context)?.uid;
    if (uid == null) {
      throw Exception('failed to fetch uid in fetchFridge');
    }
    final response = await restapi.getFridge(uid);
    if (response.statusCode == 200) {
      return Fridge.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('failed to fetch Fridge with $uid ');
    }
  }
}


/**
 * FoodObj: instance of FoodList, implemented from foodSchema 
 */
class FoodObj {
  final int quantity;
  final String foodName;
  final String description;
  final String category;

  FoodObj(
      {required this.quantity,
      required this.foodName,
      required this.description,
      required this.category});

  factory FoodObj.fromJson(Map<String, dynamic> json) {
    return FoodObj(
        quantity: json['quantity'],
        foodName: json['foodName'],
        description: json['description'],
        category: json['category']); 
  }
}
