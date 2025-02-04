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


class CollectionCardWidget extends StatefulWidget {
  final String title;
  final String id;
  final num amount;
  final String status;
  final num overdueAmount;
  final num emiAmount;
  final num tenure;
  final String collectionDay;
  final String rejectReason;

  // Constructor to accept parameters
  const CollectionCardWidget({
    super.key,
    required this.title,
    required this.id,
    required this.amount,
    required this.status,
    required this.overdueAmount,
    required this.emiAmount,
    required this.tenure,
    required this.collectionDay,
    required this.rejectReason,
  });

  @override
  State<CollectionCardWidget> createState() => _CollectionCardWidgetState();
}

class _CollectionCardWidgetState extends State<CollectionCardWidget> {
  @override
  Widget build(BuildContext context) {
    String LoanName = widget.title;
    String LoanNo = widget.id;
    String LoanStatus = widget.status;
    num overdueAmount = widget.overdueAmount;
    num LoanEMIAmount = widget.emiAmount;
    num LoanTenure = widget.tenure;
    String LoanCollectionDay = widget.collectionDay;
    String LoanRejectReason = widget.rejectReason;

    Color statusColor;

    if (LoanStatus == "Ongoing") {
      statusColor = Color(0xFFD97700);
    } else if (LoanStatus == "Completed") {
      statusColor = Color(0xFF3F7D20);
    } else if (LoanStatus == "Rejected") {
      statusColor = Color(0xFFB90000);
    } else {
      statusColor = Colors.grey; // Default color if status is unknown
    }

    return Container(
      width: double.infinity,
      height: LoanStatus == "Rejected" ? 167 : 149,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: statusColor,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xFFF9FAFB),
                        ),
                        child: Center(
                          child: Image.asset(
                            'assets/images/loanimg.png',
                            height: 24,
                            width: 24,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              LoanName,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                height: 16.8 / 14,
                              ),
                            ),
                            Text(
                              LoanNo,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF636363),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(4),
                    margin: EdgeInsets.only(top: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: statusColor,
                      ),
                    ),
                    child: overdueAmount > 0
                        ? Text(
                      "OD of ${overdueAmount}",
                      style: TextStyle(
                        fontSize: 10,
                        height: 12 / 10,
                        fontWeight: FontWeight.w700,
                        color: statusColor,
                      ),
                    )
                        : SizedBox.shrink(),
                  ),
                ]
              ),
            ],
          ),
          SizedBox(height: 16),
          Divider(
            height: 1,
            color: statusColor,
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.calendar_month),
                      Text(
                        "${LoanEMIAmount}",
                        style: TextStyle(
                          color: Color(0xFF101828),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElevatedButton(
                    onPressed: () {

                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffff9021),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      minimumSize: Size(0,15),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.currency_rupee,
                          color: Color(0xFF636363),
                          size: 16,
                        ),
                        Text(
                          "${LoanEMIAmount}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),

                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}



