import 'package:flutter/material.dart';

class UpcomingTaskWidget extends StatelessWidget {
  late double progressValue;

  UpcomingTaskWidget({
    required this.progressValue,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              height: 10,
              width: screenWidth - 32,
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
  final String heading;
  final String title;
  final String id;
  final String status;
  final num overdueAmount;
  final num emiAmount;
  final String emidate;
  final String statusLoan;

  const CollectionCardWidget({
    super.key,
    required this.heading,
    required this.title,
    required this.id,
    required this.status,
    required this.overdueAmount,
    required this.emiAmount,
    required this.emidate,
    required this.statusLoan,
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

    return Column(
      children: [
        widget.heading.isNotEmpty
            ? Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
            border: Border(
              top: BorderSide(color: statusColor),
              left: BorderSide(color: statusColor),
              right: BorderSide(color: statusColor),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              widget.heading,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        )
            : SizedBox.shrink(),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: widget.heading.isNotEmpty
                ? BorderRadius.only(
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
            )
                : BorderRadius.all(Radius.circular(8)),
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
                  // Wrap the first part inside Expanded
                  Expanded(
                    child: Row(
                      children: [
                        Container(
                          // height: 40,
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
                        SizedBox(width: 8), // Add some spacing
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // LoanName Text with wrapping based on available width
                              Text(
                                LoanName,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
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
                  ),
                  // Wrap the overdue amount part inside Expanded as well
                  Expanded(
                    child: overdueAmount > 0
                        ? Row(
                      mainAxisAlignment: MainAxisAlignment.end,
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
                          child: Text(
                            "OD of ${overdueAmount}",
                            style: TextStyle(
                              fontSize: 10,
                              height: 12 / 10,
                              fontWeight: FontWeight.w700,
                              color: statusColor,
                            ),
                          ),
                        ),
                      ],
                    )
                        : widget.statusLoan.isNotEmpty
                        ? Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.pending,
                          color: statusColor,
                          size: 12,
                        ),
                        SizedBox(width: 5),
                        Text(
                          "Pending",
                          style: TextStyle(
                            fontSize: 12,
                            height: 14 / 12,
                            fontWeight: FontWeight.w700,
                            color: statusColor,
                          ),
                        ),
                      ],
                    )
                        : SizedBox.shrink(),
                  ),
                ],
              ),
              widget.emidate.isEmpty ? SizedBox.shrink() : SizedBox(height: 13),
              widget.emidate.isEmpty
                  ? SizedBox.shrink()
                  : Divider(
                height: 1,
                color: Colors.grey,
              ),
              widget.emidate.isEmpty ? SizedBox.shrink() : SizedBox(height: 13),
              widget.emidate.isEmpty ? SizedBox.shrink() : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.calendar_month),
                          SizedBox(width: 4,),
                          Text(
                            widget.emidate,
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
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xffff9021),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          minimumSize: Size(50, 40),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.currency_rupee,
                              color: Colors.white,
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
        )
      ],
    );
  }
}
