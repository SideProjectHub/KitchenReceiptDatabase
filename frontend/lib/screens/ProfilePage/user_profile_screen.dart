import 'package:flutter/material.dart';
import '../../app/models/kartUser.dart';
import 'package:project/widgets/kitchen_drawer.dart';
import 'package:project/widgets/profile_pic.dart';
import 'package:provider/provider.dart';
import '../../widgets/custom_app_bar.dart';
import 'package:project/app/models/UserData.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => ProfilePage(),
      );

  String _profileName(BuildContext context) {
    String name = Provider.of<kartUser?>(context)?.displayName ?? "Hello";
    return name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              child: Builder(builder: (BuildContext context) {
                return CustomAppBar(
                  leading: const Text(""),
                  trailing: IconButton(
                    onPressed: () => Scaffold.of(context).openEndDrawer(),
                    icon: const Icon(Icons.menu),
                  ),
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
                  _profileName(context),
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
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _mainBar(
                        "Fridges", Provider.of<UserData>(context).fridgeTotal),
                    _dividers(),
                    _mainBar("Foods", Provider.of<UserData>(context).foodTotal),
                    _dividers(),
                    _mainBar(
                        "Eaten", Provider.of<UserData>(context).eatenTotal),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      endDrawer: KitchenDrawer(),
    );
  }

  Widget _dividers() {
    return const VerticalDivider(
      thickness: 2,
      color: Colors.grey,
      width: 20,
      indent: 5,
      endIndent: 5,
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
