import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:project/services/rest_api_service.dart';

class Fridge {
  final String fridgeName;
  final int fridgeCount;
  final String cardColor;
  //here this should be renamed <FOOD>
  final String fridgeID;

  const Fridge({
    required this.fridgeName,
    required this.fridgeCount,
    required this.cardColor,
    required this.fridgeID,
  });

  //TODO: potential issue w/ foodList since list of type Food Schema, add a potential class?

  factory Fridge.fromJson(Map<String, dynamic> json) {
    return Fridge(
      fridgeName: json['fridgeName'],
      fridgeCount: json['fridgeCount'],
      cardColor: json['cardColor'],
      fridgeID: json['_id'],
    );
  }

  /**
   * fetches fridge from Database and parses JSON into a Dart Class 
   * @param: context, used for grabbing the kartUser's uid for the fridge via the MultiProvider<KartUser?> 
   */
  static Future<Fridge> fetchFridge(BuildContext context, String? uid) async {
    RestAPIService restapi = new RestAPIService();
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

class FoodObjList {
  final List<FoodObj> foodList;

  FoodObjList({required this.foodList});

  factory FoodObjList.fromJson(List<dynamic> json) {
    return FoodObjList(
      foodList: json.map((value) => FoodObj.fromJson(value)).toList(),
    );
  }

  static Future<FoodObjList> fetchFoodList(String? fridgeID) async {
    RestAPIService restapi = new RestAPIService();
    if (fridgeID == null) {
      throw Exception('failed to fetch fridgeID in fetchFridge');
    }
    final response = await restapi.getFridge(fridgeID);
    if (response.statusCode == 200) {
      return FoodObjList.fromJson(jsonDecode(response.body) as List);
    } else {
      throw Exception('failed to fetch Fridge with $fridgeID ');
    }
  }
}

/**
 * FoodObj: instance of Food, implemented from foodSchema 
 */
class FoodObj {
  final int quantity;
  final String foodID;
  final String foodName;
  final String description;
  final String category;

  FoodObj(
      {required this.quantity,
      required this.foodName,
      required this.description,
      required this.category,
      required this.foodID});

  factory FoodObj.fromJson(Map<String, dynamic> json) {
    return FoodObj(
        quantity: json['quantity'],
        foodID: json['_id'],
        foodName: json['foodName'],
        description: json['description'],
        category: json['category']);
  }
}
