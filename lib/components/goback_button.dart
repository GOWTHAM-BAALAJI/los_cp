// custom_header.dart
import 'package:flutter/material.dart';

class GoBack extends StatelessWidget {
  final String title;
  final Function(int) onNavigate;

  const GoBack({Key? key, required this.title, required this.onNavigate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 12, top: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              onNavigate(0);
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
