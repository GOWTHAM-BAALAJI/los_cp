import 'package:flutter/material.dart';
import './dashboard.dart';
import '../profile/main_page.dart';
import '../my_application/applicationScreen.dart';
import '../transactions/main_page.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  final String userName = 'Anika!';
  const CustomBottomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      DashboardScreen(userName: userName,onNavigate: onItemTapped,),
      applicationScreen(onNavigate: onItemTapped,),
      TransactionsPage(),
      ProfilePage(onNavigate: onItemTapped,),
    ];

    return Column(
      children: [
        Expanded(
          child: _pages[selectedIndex],
        ),
        Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Theme(
                data: ThemeData(
                  bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    selectedLabelStyle: const TextStyle(fontSize: 12),
                    unselectedLabelStyle: const TextStyle(fontSize: 12),
                    selectedItemColor: Colors.blue[400],
                    unselectedItemColor: Colors.grey[400],
                  ),
                ),
                child: BottomNavigationBar(
                  currentIndex: selectedIndex,
                  onTap: onItemTapped,
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Colors.white,
                  showSelectedLabels: true,
                  showUnselectedLabels: true,
                  elevation: 0,
                  selectedIconTheme: IconThemeData(
                    color: Colors.grey[400],
                  ),
                  unselectedIconTheme: IconThemeData(
                    color: Colors.grey[400],
                  ),
                  items: [
                    BottomNavigationBarItem(
                      icon: Image.asset(
                        'assets/images/logo.png',
                        width: 24,  // Set appropriate size
                        height: 24, // To match other icons' color
                      ),
                      label: 'Spandana',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.more_vert),
                      label: 'My Portfolio',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.account_balance_wallet),
                      label: 'Transactions',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.account_circle_outlined),
                      label: 'Profile',
                    ),
                  ],
                ),
              ),
            ),
            // Bottom indicator line
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Row(
                children: List.generate(4, (index) {
                  return Expanded(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      height: 4, // Made thicker (was 2)
                      decoration: BoxDecoration(
                        color: selectedIndex == index ? Colors.blue[400] : Colors.transparent,
                        borderRadius: BorderRadius.circular(2), // Added rounded corners
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ],
    );
  }
}