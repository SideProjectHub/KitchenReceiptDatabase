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
