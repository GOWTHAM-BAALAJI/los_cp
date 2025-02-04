import 'package:flutter/material.dart';

class UpcomingTaskWidget extends StatelessWidget {
  late double progressValue;

  UpcomingTaskWidget({
    required this.progressValue,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                height: 10,
                width: screenWidth-32,
                decoration: BoxDecoration(
                  color: Color(0xffeef2ff),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: progressValue,
                    backgroundColor: Colors.transparent,
                    color: Colors.green,
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 8.0),
        ],
      );
  }
}


class CollectionsCardWidget extends StatelessWidget {
  final String title;
  final String id;
  final double amount;

  CollectionsCardWidget({
    required this.title,
    required this.id,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'ID: $id',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: () {},
              child: Text('Pay ₹$amount'),
            ),
          ],
        ),
      ),
    );
  }
}

