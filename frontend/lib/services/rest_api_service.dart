import 'dart:convert';
import 'dart:ui';

import 'package:path/path.dart' as path;
import 'package:image_picker/image_picker.dart';
import 'package:project/constants/api_path.dart';
import 'package:http/http.dart' as http;

class RestAPIService {
  /************ Getters APIs ***************** */
  /*  
    GetProfile: Returns entire Schema schema 
    @param: uid -> User id from firebase
    @return Response type and 
    UserSchema: { 
      uid: String 
      email: String
      displayName: String
      fridgeList: [ObjectIDs]
      fridgeTotal: Int 
      foodTotal: Int 
      eatenTotal: Int
    }
  */
  Future<http.Response> getProfile(String uid) async {
    return await http.get(
      Uri.parse(APIPath.host() + APIPath.getProfile(uid)),
      headers: APIPath.standardHeader(),
    );
  }

  /*  
    GetFood: Returns entire Food schema 
    @param: fridgeID -> Fridge id from firebase
    @return Response type and { 
      quantity: Int, 
      foodName: String, 
      description: String, 
      category: String, 
    }
  */
  Future<http.Response> getFood(String fridgeID) async {
    return await http.get(
      Uri.parse(APIPath.host() + APIPath.getFood(fridgeID)),
      headers: APIPath.standardHeader(),
    );
  }

  /**
   * GetProfile: Returns entire Fridge schema 
    @param: uid -> User id from firebase
    @return Response type and  { 
      fridgeName: String 
      fridgeCount: Int 
      cardColor: String
      foodList: [foodschema]
    }
  */
  Future<http.Response> getFridge(String uid) async {
    return await http.get(
      Uri.parse(APIPath.host() + APIPath.getFridge(uid)),
      headers: APIPath.standardHeader(),
    );
  }

  /************ Insert APIs ***************** */

  /** 
   * Adds user to database
   * @param uid: user ID from firebase 
   * @param body: body json with 
   *      @required uid, email, displayname, 
   * @return Response type
   */
  Future<http.Response> addUser(String uid, Map<String, dynamic> body) async {
    return await http.post(
      Uri.parse(APIPath.host() + APIPath.addUser()),
      headers: APIPath.standardHeader(),
      body: (jsonEncode(body)),
    );
  }

  /** 
   * Adds food to database
   * @param fridgeID: fridge ID from database 
   * @param body: body json with 
   *      @required: quantity, foodName, category, 
   *      @optional: description
   * @return Response type
   */
  Future<http.Response> addFood(
      String fridgeID, Map<String, dynamic> body) async {
    return await http.post(
      Uri.parse(APIPath.host() + APIPath.addFood(fridgeID)),
      headers: APIPath.standardHeader(),
      body: (jsonEncode(body)),
    );
  }

  /** 
   * Intialize Fridge to database
   * @param uid: user ID from firebase 
   * @param body: body json with 
   *      @required: fridgeName, cardColor, 
   * @return Response type
   */
  Future<http.Response> addFridge(String uid, Map<String, dynamic> body) async {
    return await http.post(
      Uri.parse(APIPath.host() + APIPath.addFridge(uid)),
      headers: APIPath.standardHeader(),
      body: (jsonEncode(body)),
    );
  }

  /** 
   * Adds food to database
   * @param fridgeID: fridge ID from database 
   * @param body: body json with 
   *      @required: <File>receipt
   * @return Response type
   */
  Future<http.StreamedResponse> addReceipt(
      String fridgeID, PickedFile file) async {
    //Intialize constants for API call
    String url = APIPath.host() + APIPath.addReceipt(fridgeID);
    String filename = path.basename(file.path.split('/').last);

    //Request call
    var request = http.MultipartRequest('POST', Uri.parse(url));
    var imagebytes = await file.readAsBytes();
    List<int> listData = imagebytes.cast();
    request.files.add(
        http.MultipartFile.fromBytes('image', listData, filename: filename));

    return request.send();
  }

  /************ Delete APIs ***************** */

  /** 
   * Delete food to database
   * @param fridgeID: fridge ID from database 
   * @return Response type
   */
  Future<http.Response> deleteFood(String fridgeID, String foodID) async {
    return await http.delete(
      Uri.parse(APIPath.host() + APIPath.deleteFood(fridgeID, foodID)),
      headers: APIPath.standardHeader(),
    );
  }
}
