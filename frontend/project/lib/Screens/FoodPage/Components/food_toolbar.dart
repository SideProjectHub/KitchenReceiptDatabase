import 'package:flutter/material.dart';

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
          _buildButtonColumn(color, Icons.camera_alt, 'ADD RECEIPT'),
          _buildButtonColumn(color, Icons.food_bank, 'ADD FOOD'),
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

  Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
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
