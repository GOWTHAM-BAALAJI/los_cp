import 'package:flutter/material.dart';

class CommentCard extends StatelessWidget {
  final String profilePic;
  final String name;
  final String date;
  final String time;
  final String comment;

  const CommentCard({
    Key? key,
    required this.profilePic,
    required this.name,
    required this.date,
    required this.time,
    required this.comment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      color: Color(0xFFFFFFFF),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: Color(0xFFBFBFBF))
      ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage(profilePic),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontFamily: "Lato",
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF2051E5),
                        ),
                      ),
                      Text(
                        "$date $time",
                        style: const TextStyle(
                          fontFamily: "Lato",
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF878787),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Text(
              comment,
              style: const TextStyle(
                fontFamily: "Lato",
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF1E1E1E),
              ),
            ),
          ],
        )
      ),
    );
  }
}
