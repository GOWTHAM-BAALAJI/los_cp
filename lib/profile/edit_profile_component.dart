import 'package:flutter/material.dart';
import '../components/edit_button.dart';

class ProfileDetailsCardWidget extends StatelessWidget {
  final String name;
  final String id;
  final String address;
  final String maritalStatus;
  final String husbandFatherName;
  final String coInsured;
  final String age;
  final String dob;
  final String religion;
  final String education;
  final String motherName;
  final String fatherName;
  final String? profileImageUrl;
  final VoidCallback? onEditPressed;

  const ProfileDetailsCardWidget({
    Key? key,
    required this.name,
    required this.id,
    required this.address,
    required this.maritalStatus,
    required this.husbandFatherName,
    required this.coInsured,
    required this.age,
    required this.dob,
    required this.religion,
    required this.education,
    required this.motherName,
    required this.fatherName,
    this.profileImageUrl,
    this.onEditPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                width: 1,
                color: Colors.transparent,
              ),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFD97700), Color(0xFF2051E5)],
                stops: [0.0, 1.0],
              ),
            ),
            child: Card(
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              color: Color(0xFFEFF3FF),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: profileImageUrl != null
                              ? AssetImage(profileImageUrl!) as ImageProvider
                              : const AssetImage('assets/images/female_profilepic.png'),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                name,
                                style: const TextStyle(
                                  fontFamily: "Lato",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF2051E5)
                                ),
                              ),
                              SizedBox(height: 4,),
                              Text(
                                'ID: $id',
                                style: const TextStyle(
                                    fontFamily: "Lato",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF101010)
                                ),
                              ),
                            ],
                          ),
                        ),
                        EditButton(
                          onPressed: () {
                            // Your edit functionality here
                            print("Edit button pressed!");
                            // Navigate to edit screen, update data, etc.
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        _infoRow('Marital Status', maritalStatus, 'Husband\'s name', husbandFatherName, 'Co-Insured', coInsured),
                        SizedBox(height: 8),
                        _infoRow('Age', age, 'DOB', dob, 'Religion', religion),
                        SizedBox(height: 8),
                        _infoRow('Education', education, 'Mother\'s name', motherName, 'Father\'s name', fatherName),
                        SizedBox(height: 8),
                        _buildAddressSection(address),
                        SizedBox(height: 16),
                      ],
                    ),
                  ),
                ],
              ),
            )
          )
        ],
      ),
    );
  }

  Widget _infoRow(String label1, String value1, String label2, String value2, String label3, String value3) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label takes 40% width using Expanded with a flex of 2
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label1, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12, fontFamily: "Lato", color: Color(0xFF636363))),
                SizedBox(height: 8),
                Text(value1, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, fontFamily: "Lato", color: Color(0xFF101828))),
              ],
            )
          ),
          SizedBox(width: 8),
          Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label2, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12, fontFamily: "Lato", color: Color(0xFF636363))),
                  SizedBox(height: 8),
                  Text(value2, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, fontFamily: "Lato", color: Color(0xFF101828))),
                ],
              )
          ),
          SizedBox(width: 8),
          Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label3, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12, fontFamily: "Lato", color: Color(0xFF636363))),
                  SizedBox(height: 8),
                  Text(value3, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, fontFamily: "Lato", color: Color(0xFF101828))),
                ],
              )
          ),
        ],
      ),
    );
  }

  Widget _buildAddressSection(String address) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: 'Address - ',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12, fontFamily: "Lato", color: Color(0xFF636363))
          ),
          TextSpan(
            text: address,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, fontFamily: "Lato", color: Color(0xFF101828))
          ),
        ],
      ),
    );
  }
}