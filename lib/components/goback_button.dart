// custom_header.dart
import 'package:flutter/material.dart';

class GoBack extends StatelessWidget {
  final String title;

  const GoBack({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 12, top: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context); // Pop the current screen when tapped
            },
            child: Icon(Icons.arrow_back),
          ),
          SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFF101010),
              fontFamily: "Lato",
            ),
          ),
        ],
      ),
    );
  }
}
