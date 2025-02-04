import 'package:flutter/material.dart';

class TabItem2 {
  final String title;
  final Widget content;

  TabItem2({required this.title, required this.content});
}

class TabComponent2 extends StatefulWidget {
  final List<TabItem2> tabs2;

  const TabComponent2({Key? key, required this.tabs2}) : super(key: key);

  @override
  _TabComponent2State createState() => _TabComponent2State();
}

class _TabComponent2State extends State<TabComponent2> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
          ),
          height: 50,
          width: MediaQuery.of(context).size.width, // Make it full width
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              child: Row(
                children: widget.tabs2.map((tab) {
                  int index = widget.tabs2.indexOf(tab);
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _selectedIndex = index;
                        });
                      },
                      child: Container(
                        width: 200, // Fixed width for each tab
                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100, // Inactive tab color
                          borderRadius: BorderRadius.zero,
                          border: Border(
                            bottom: BorderSide(
                              color: _selectedIndex == index
                                  ? Color(0xFF2051E5) // Black underline for selected tab
                                  : Color(0xFFBFBFBF), // No underline for unselected tabs
                              width: 2, // Underline thickness
                            ),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            tab.title,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontFamily: "Lato",
                              fontSize: 14,
                              color: _selectedIndex == index
                                  ? Color(0xFF2051E5) // Active text color
                                  : Color(0xFF8D8D8D), // Inactive text color
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        // Display the content of the selected tab
        widget.tabs2[_selectedIndex].content,
      ],
    );
  }
}
