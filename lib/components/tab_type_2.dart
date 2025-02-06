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
          width: MediaQuery.of(context).size.width,
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
                        width: 200,
                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.zero,
                          border: Border(
                            bottom: BorderSide(
                              color: _selectedIndex == index
                                  ? Color(0xFF2051E5)
                                  : Color(0xFFBFBFBF),
                              width: 2,
                            ),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            tab.title,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontFamily: "Lato",
                              fontSize: 14,
                              color: _selectedIndex == index
                                  ? Color(0xFF2051E5)
                                  : Color(0xFF8D8D8D),
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
        widget.tabs2[_selectedIndex].content,
      ],
    );
  }
}
