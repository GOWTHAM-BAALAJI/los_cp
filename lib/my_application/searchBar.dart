import 'package:flutter/material.dart';

class SearchBarComp extends StatefulWidget {
  const SearchBarComp({super.key});

  @override
  _SearchBarCompState createState() => _SearchBarCompState();
}

class _SearchBarCompState extends State<SearchBarComp> {
  final TextEditingController _controller = TextEditingController();
  String _searchQuery = '';

  void _onSearch() {
    setState(() {
      _searchQuery = _controller.text; // Update the search query with input text
    });

    print("Searching for: $_searchQuery");
  }

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
          Expanded(
            child: TextField(
              controller: _controller, // Assign the controller to the TextField
              decoration: InputDecoration(
                hintText: "Search",
                hintStyle: TextStyle(color: Color(0xFFADB7C5)),
                border: InputBorder.none,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                  color: Color(0xFFEAEDF4),
                  width: 1.0, // Adjust width if needed
                ),
              ),
            ),
            child: IconButton(
              icon: const Icon(Icons.search, color: Color(0xFF778599)),
              onPressed: _onSearch, // Call _onSearch when the button is pressed
            ),
          ),
        ],
      ),
    );
  }
}
