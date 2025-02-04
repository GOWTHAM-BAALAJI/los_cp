import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 328,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Color(0xFFAEAEAE80)),
      ),
      child: Row(
        children: [
          const SizedBox(width: 12),
          const Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search",
                hintStyle: TextStyle(color: Color(0xFFADB7C5),),
                border: InputBorder.none,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                  color: Color(0xFFEAEDF4),
                  width: 1.0,  // You can adjust the width if needed
                ),
              ),
            ),
            child:
            IconButton(
              icon: const Icon(Icons.search, color: Color(0xFF778599)),
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }
}
