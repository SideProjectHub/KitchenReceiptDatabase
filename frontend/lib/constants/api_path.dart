//Constants to REST APIs
class APIPath {
  static String host() => 'http://localhost:4000/';
  static Map<String, String> standardHeader() =>
      {'Content-type': 'application/json', 'Accept': 'application/json'};

  static String getProfile(String uid) => 'routes/getProfile/$uid';
  static String getFood(String fridgeID) => 'routes/getFood/$fridgeID';
  static String getFridge(String uid) => 'routes/getFridge/$uid';

  static String addUser() => 'routes/addUser';
  static String addFood(String fridgeID) => 'routes/addFood/$fridgeID';
  static String addFridge(String uid) => 'routes/addFridge/$uid';
  static String addReceipt(String fridgeID) => 'routes/addReceipt/$fridgeID';

  static String deleteFood(String fridgeID, String foodID) =>
      'routes/deleteFood/$fridgeID/$foodID';
}
