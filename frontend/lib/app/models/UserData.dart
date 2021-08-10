import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:project/services/rest_api_service.dart';

class UserData with ChangeNotifier {
  int fridgeTotal;
  int foodTotal;
  int eatenTotal;

  UserData(
      {required this.fridgeTotal,
      required this.foodTotal,
      required this.eatenTotal});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      fridgeTotal: json['fridgeTotal'],
      foodTotal: json['foodTotal'],
      eatenTotal: json['eatenTotal'],
    );
  }

  UserData update(String? uid) {
    if (uid != null) {
      fetchUserData(uid).then((value) {
        this.eatenTotal = value.eatenTotal;
        this.foodTotal = value.foodTotal;
        this.fridgeTotal = value.fridgeTotal;
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
    print(response.statusCode);
    if (response.statusCode == 200) {
      print("In the response");
      print(response.body);
      return UserData.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load UserData');
    }
  }
}
