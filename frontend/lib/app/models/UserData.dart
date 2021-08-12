import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:project/app/models/Fridge.dart';
import 'package:project/services/rest_api_service.dart';

class UserData with ChangeNotifier {
  int fridgeTotal;
  int foodTotal;
  int eatenTotal;
  List<Fridge> fridgeList;

  UserData({
    required this.fridgeTotal,
    required this.foodTotal,
    required this.eatenTotal,
    required this.fridgeList,
  });

  factory UserData.fromJson(
      Map<String, dynamic> userData, List<dynamic> fridgeData) {
    List<Fridge> fridgeList =
        fridgeData.map((value) => Fridge.fromJson(value)).toList();
    return UserData(
      fridgeTotal: userData['fridgeTotal'],
      foodTotal: userData['foodTotal'],
      eatenTotal: userData['eatenTotal'],
      fridgeList: fridgeList,
    );
  }

  UserData update(String? uid) {
    if (uid != null) {
      fetchUserData(uid).then((value) {
        this.eatenTotal = value.eatenTotal;
        this.foodTotal = value.foodTotal;
        this.fridgeTotal = value.fridgeTotal;
        this.fridgeList = value.fridgeList;
        notifyListeners();
      }).catchError((e) => throw Exception(e));
    }
    return this;
  }

  static Future<UserData> fetchUserData(String? uid) async {
    print(uid);
    if (uid == null) {
      throw Exception("no known UID");
    }
    final response = await RestAPIService().getProfile(uid);
    final fridgeList = await RestAPIService().getFridge(uid);
    print(fridgeList.body);
    print(response.statusCode);
    if (response.statusCode == 200 && fridgeList.statusCode == 200) {
      print("In the response");
      print(response.body);
      return UserData.fromJson(
          jsonDecode(response.body), jsonDecode(fridgeList.body) as List);
    } else {
      throw Exception('Failed to load UserData');
    }
  }
}
