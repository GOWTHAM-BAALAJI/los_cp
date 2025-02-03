import 'package:flutter/material.dart';
import 'components/bottomnavigation.dart';
import 'components/profileAppBar.dart'; // Import your BottomNavigation component

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // Function to handle the index change
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProfileAppBar(
        name: 'Rohit Thiru',
        id: '94556387',
        location: 'Jhalod',
        profileImageUrl: 'https://example.com/profile-image.jpg', // Replace with your actual image URL
      ),
      body: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
