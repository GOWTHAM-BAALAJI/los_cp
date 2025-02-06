import 'package:flutter/material.dart';

class LoanDetailCard extends StatefulWidget {
  final String? LoanName;
  final String? LoanNo;
  final String? LoanStatus;
  final num? LoanOverdueAmount;
  final num? LoanEMIAmount;
  final num? LoanTenure;
  final String? LoanCollectionDay;
  final String? LoanRejectReason;

  LoanDetailCard({
    Key? key,
    this.LoanName,
    this.LoanNo,
    this.LoanStatus,
    this.LoanOverdueAmount,
    this.LoanEMIAmount,
    this.LoanTenure,
    this.LoanCollectionDay,
    this.LoanRejectReason,
  }) : super(key: key);

  @override
  State<LoanDetailCard> createState() => _LoanDetailCardState();
}

class _LoanDetailCardState extends State<LoanDetailCard> {
  @override
  Widget build(BuildContext context) {
    String loanName = widget.LoanName ?? "Unknown";
    String loanNo = widget.LoanNo ?? "N/A";
    String loanStatus = widget.LoanStatus ?? "Unknown";
    num loanOverdueAmount = widget.LoanOverdueAmount ?? 0;
    num loanEMIAmount = widget.LoanEMIAmount ?? 0;
    num loanTenure = widget.LoanTenure ?? 0;
    String loanCollectionDay = widget.LoanCollectionDay ?? "Not Set";
    String loanRejectReason = widget.LoanRejectReason ?? "No Reason";

    Color statusColor;

    if (loanStatus == "Ongoing" || loanStatus == "Active") {
      statusColor = Color(0xFFD97700);
    } else if (loanStatus == "Completed") {
      statusColor = Color(0xFF3F7D20);
    } else if (loanStatus == "Rejected") {
      statusColor = Color(0xFFB90000);
    } else {
      statusColor = Colors.grey;
    }

    return Center(
      child: Column(
        children: [
          Container(
            width: 328,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: statusColor),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                    SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            loanName,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              height: 16.8 / 14,
                            ),
                            softWrap: true,
                          ),
                          Text(
                            loanNo,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF636363),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              "assets/images/${loanStatus}img.png",
                              height: 10,
                              width: 10,
                            ),
                            SizedBox(width: 4),
                            Text(
                              loanStatus,
                              style: TextStyle(
                                color: statusColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 10,
                                height: 12 / 10,
                              ),
                            ),
                          ],
                        ),
                        if (loanOverdueAmount > 0)
                          Container(
                            padding: EdgeInsets.all(4),
                            margin: EdgeInsets.only(top: 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: statusColor),
                            ),
                            child: Text(
                              "OD of ₹${loanOverdueAmount}",
                              style: TextStyle(
                                fontSize: 10,
                                height: 12 / 10,
                                fontWeight: FontWeight.w700,
                                color: statusColor,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Divider(height: 1, color: statusColor),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "EMI Amount",
                          style: TextStyle(
                            color: Color(0xFF636363),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "₹${loanEMIAmount}",
                          style: TextStyle(
                            color: Color(0xFF101828),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Tenure",
                          style: TextStyle(
                            color: Color(0xFF636363),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "${loanTenure} weeks",
                          style: TextStyle(
                            color: Color(0xFF101828),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Collection day",
                          style: TextStyle(
                            color: Color(0xFF636363),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          loanCollectionDay,
                          style: TextStyle(
                            color: Color(0xFF101828),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                if (loanStatus == "Rejected")
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Row(
                      children: [
                        Text(
                          "Reason: ",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: Color(0xFF636363),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            loanRejectReason,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: Color(0xFF101828),
                            ),
                            softWrap: true,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
