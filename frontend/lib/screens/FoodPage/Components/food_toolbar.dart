import 'package:flutter/material.dart';
import 'food_methods.dart';

class FoodToolbar extends StatelessWidget {
  const FoodToolbar({Key? key}) : super(key: key);

  final Color color = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildButtonColumn(color, Icons.camera_alt, 'ADD RECEIPT',
              FoodMethods.of(context).getReceiptPic),
          _buildButtonColumn(color, Icons.food_bank, 'ADD FOOD',
              () => FoodMethods.of(context).inputModal(context)),
        ],
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  Column _buildButtonColumn(
      Color color, IconData icon, String label, VoidCallback f) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Ink(
          decoration: const ShapeDecoration(
            shape: ContinuousRectangleBorder(),
          ),
          child: IconButton(
            icon: Icon(icon, color: color),
            onPressed: f,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}
