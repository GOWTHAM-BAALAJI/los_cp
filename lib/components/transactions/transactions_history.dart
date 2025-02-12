import 'package:flutter/material.dart';

class TransactionItemWidget extends StatelessWidget {
  final String title;
  final String username;
  final double amount;
  final String date;
  final int status;

  const TransactionItemWidget({
    Key? key,
    required this.title,
    required this.username,
    required this.amount,
    required this.date,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 8, right: 8, bottom: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Color(0xFFEEF2FF),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              status == 1 || status == 2 ? Icons.arrow_forward : status == 3 || status == 4 ? Icons.error_outline : Icons.cancel_outlined,
              color: status == 1 || status == 2 ? Color(0xFF3F7D20) : status == 3 || status == 4 ? Color(0xFFFF9021) : Colors.red,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: "Lato",
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Color(0xFF1E1E1E)
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  username,
                  style: TextStyle(
                      fontFamily: "Lato",
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: Color(0xFF969696)
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '₹${amount.toStringAsFixed(2)}',
                style: TextStyle(
                  fontFamily: "Lato",
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: status == 1 || status == 2 ? Color(0xFF3F7D20) : status == 3 || status == 4 ? Color(0xFFFF9021) : Colors.red,
                ),
              ),
              SizedBox(height: 4),
              Text(
                date,
                style: TextStyle(
                    fontFamily: "Lato",
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: Color(0xFF969696)
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}