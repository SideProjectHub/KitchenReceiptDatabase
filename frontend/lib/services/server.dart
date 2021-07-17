import 'package:mongo_dart/mongo_dart.dart';
import './strings.dart'; 

main(List<String> arguments) async {

 // Db db = Db(' ')
} 


void sendUserInfo() async {
    var db = Db(uri_string); //temp user
    await db.open();
    var userCol = db.collection('test');
    print(await userCol.find().toList()); 
    // await userCol.insert({
    //   'Name': user.displayName,
    //   '_id': null,
    //   'Fridge': null,
    //   'id_token': id
    // });
  }