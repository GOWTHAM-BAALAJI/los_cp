import 'package:flutter/material.dart';

class EligibleLoanCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String duration;
  final String price;

  const EligibleLoanCard({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.duration,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: Container(
        color: Colors.white,
        child: Container(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Colors.orange, Colors.blue],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: Row(
                children: [
                  SizedBox(
                    height: 200,
                    width: 180,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        imagePath,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Row(
                              children: const [
                                Text(
                                  "Apply for Eligible Loan",
                                  style: TextStyle(color: Colors.blue, fontSize: 10),
                                ),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Colors.blue,
                                  size: 10,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            title,
                            style: const TextStyle(fontSize: 14),
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: Row(
                              children: [
                                const Icon(Icons.calendar_today, size: 11),
                                const SizedBox(width: 4),
                                Text(duration, style: const TextStyle(fontSize: 11)),
                                const SizedBox(width: 16),
                                const Icon(Icons.currency_rupee, size: 11),
                                Text(price, style: const TextStyle(fontSize: 11)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
