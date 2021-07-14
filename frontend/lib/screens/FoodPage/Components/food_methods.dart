import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/Screens/FoodPage/Components/food_list.dart';

class FoodMethods extends InheritedWidget {
  FoodMethods({
    Key? key,
    required Widget child,
  }) : super(key: key, child: child);

  final ImagePicker _picker = ImagePicker(); //Intialize ImagePicker API

  static FoodMethods of(BuildContext context) {
    final FoodMethods? result =
        context.dependOnInheritedWidgetOfExactType<FoodMethods>();
    assert(result != null, 'No FoodMethods found  in context');
    return result!;
  }

  @override
  bool updateShouldNotify(FoodMethods old) => old != this;

  Future<void> getReceiptPic() async {
    try {
      final PickedFile? pickedFile =
          await _picker.getImage(source: ImageSource.camera);
      _handleImage(pickedFile);
    } catch (e) {
      _handleError("Error");
    }
  }

  //@TODO
  void _handleImage(PickedFile? file) {
    return;
  }

  void _handleError(String? error) {
    print(error);
  }
}
