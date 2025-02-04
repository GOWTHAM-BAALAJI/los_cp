import 'package:flutter/material.dart';

class TabItem1 {
  final String title;
  final Widget content;

  TabItem1({required this.title, required this.content});
}

class TabComponent1 extends StatefulWidget {
  final List<TabItem1> tabs1;

  const TabComponent1({Key? key, required this.tabs1}) : super(key: key);

  @override
  _TabComponent1State createState() => _TabComponent1State();
}

class _TabComponent1State extends State<TabComponent1> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
          ),
          height: 50,
          width: MediaQuery.of(context).size.width, // Make it full width
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal:8.0),
              child: Row(
                children: widget.tabs1.map((tab) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0), // Add spacing
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _selectedIndex = widget.tabs1.indexOf(tab);
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      decoration: BoxDecoration(
                        color: _selectedIndex == widget.tabs1.indexOf(tab)
                            ? Color(0xFFE97A0A) // Active tab color
                            : Color(0xFFFFFFFF), // Inactive tab color
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        tab.title,
                        style: TextStyle(
                          color: _selectedIndex == widget.tabs1.indexOf(tab)
                              ? Color(0xFFFFFFFF) // Active text color
                              : Color(0xFF969696), // Inactive text color
                        ),
                      ),
                    ),
                  ),
                )).toList(),
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        // Display the content of the selected tab
        widget.tabs1[_selectedIndex].content,
      ],
    );
  }
}