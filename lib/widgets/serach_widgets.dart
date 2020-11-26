import 'package:flutter/material.dart';

Widget headerChoice({double width, String title, Color colour}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: TextStyle(
          color: colour,
          fontWeight: FontWeight.bold,
          fontSize: 16.0,
        ),
      ),
      SizedBox(height: 5.0),
      Container(
        width: width,
        height: 3.0,
        color: colour,
      )
    ],
  );
}
