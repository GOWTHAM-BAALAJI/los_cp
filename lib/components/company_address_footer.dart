import 'package:flutter/material.dart';

class CompanyInfoWidget extends StatelessWidget {
  final String companyName;
  final String cinNumber;
  final String address;
  final String contact;
  final String emailId;

  const CompanyInfoWidget({
    Key? key,
    required this.companyName,
    required this.cinNumber,
    required this.address,
    required this.contact,
    required this.emailId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            companyName,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12, fontFamily: "Lato", color: Color(0xFF636363))
          ),
          const SizedBox(height: 8),
          Text(
            'CIN: $cinNumber',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12, fontFamily: "Lato", color: Color(0xFF636363))
          ),
          const SizedBox(height: 8),
          Text(
            address,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12, fontFamily: "Lato", color: Color(0xFF636363))
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Row(
                  children: [
                    Icon(Icons.phone, size: 16, color: Color(0xFFD97700),),
                    SizedBox(width: 2),
                    Text(
                        contact,
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12, fontFamily: "Lato", color: Color(0xFF636363))
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Icon(Icons.email, size: 16, color: Color(0xFFD97700),),
                    SizedBox(width: 2),
                    Text(
                        emailId,
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12, fontFamily: "Lato", color: Color(0xFF636363))
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}