import 'package:flutter/material.dart';
import 'package:project/widgets/profile_pic.dart';
import '../../widgets/custom_app_bar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => ProfilePage(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            child: Builder(builder: (BuildContext context) {
              return CustomAppBar(
                leading: const Text(""),
                trailing: const Text(""),
                title: "Profile",
                childHeight: 100,
                height: 175,
                isBig: true,
                child: ProfilePic(diameter: 100),
              );
            }),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: Center(
              child: Text(
                "Name",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _mainBar("Fridges", 0),
                _mainBar("Foods", 0),
                _mainBar("Eaten", 0)
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _mainBar(String title, int data) {
    return Column(
      children: [
        Text(
          data.toString(),
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        Text(
          title,
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
      ],
    );
  }
}
