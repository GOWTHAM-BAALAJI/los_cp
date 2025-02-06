import 'package:flutter/material.dart';
import 'edit_profile_page.dart';

class ProfileDetailItem extends StatelessWidget {
  final String label;
  final String value;

  const ProfileDetailItem({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: "Lato",
            fontWeight: FontWeight.w400,
            fontSize: 12,
            color: Color(0xFF2051E5),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontFamily: "Lato",
            fontWeight: FontWeight.w600,
            fontSize: 12,
            color: Color(0xFFD97700),
          ),
        ),
      ],
    );
  }
}

class ProfileDetailsCard extends StatelessWidget {
  final String name;
  final String id;
  final String lo;
  final String village;
  final String centre;
  final String group;
  final String memberSince;
  final String activeLoans;
  final String status;
  final String profileImageUrl;

  const ProfileDetailsCard({
    Key? key,
    required this.name,
    required this.id,
    required this.lo,
    required this.village,
    required this.centre,
    required this.group,
    required this.memberSince,
    required this.activeLoans,
    required this.status,
    required this.profileImageUrl,
  }) : super(key: key);

  factory ProfileDetailsCard.fromJson(Map<String, dynamic> json) {
    return ProfileDetailsCard(
      name: json['name'],
      id: json['id'],
      lo: json['lo'],
      village: json['village'],
      centre: json['centre'],
      group: json['group'],
      memberSince: json['memberSince'],
      activeLoans: json['activeLoans'],
      status: json['status'],
      profileImageUrl: json['profileImageUrl'],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
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
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: AssetImage(profileImageUrl),
                        ),
                        const SizedBox(width: 12),
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
                                  color: Color(0xFF2051E5),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(0),
                                child: Row(
                                  children: [
                                    Text(
                                      'ID: $id',
                                      style: TextStyle(
                                        fontFamily: "Lato",
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                        color: Color(0xFF101010),
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Container(
                                      height: 10,
                                      width: 2,
                                      color: Color(0xFF101010),
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'LO: $lo',
                                      style: TextStyle(
                                        fontFamily: "Lato",
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                        color: Color(0xFF101010),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => EditProfilePage()),
                            );
                          },
                          child: const Icon(
                            Icons.chevron_right,
                            color: Color(0xFFD97700),
                            size: 30,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
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
                borderRadius: BorderRadius.circular(12),
              ),
              color: Color(0xFFFFFFFF),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          Expanded(
                            child: ProfileDetailItem(
                              label: 'Village',
                              value: village,
                            ),
                          ),
                          Container(
                            width: 1,
                            color: Color(0xFFD5D5D5),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: ProfileDetailItem(
                              label: 'Centre',
                              value: centre,
                            ),
                          ),
                          SizedBox(width: 10),
                          Container(
                            width: 1,
                            color: Color(0xFFD5D5D5),
                          ),
                          Expanded(
                            child: ProfileDetailItem(
                              label: 'Group',
                              value: group,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    Container(
                      height: 1,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xAEAEAEAE),
                          width: 1,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          Expanded(
                            child: ProfileDetailItem(
                              label: 'Member Since',
                              value: memberSince,
                            ),
                          ),
                          Container(
                            width: 1,
                            color: Color(0xFFD5D5D5),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: ProfileDetailItem(
                              label: 'Active Loans',
                              value: activeLoans,
                            ),
                          ),
                          SizedBox(width: 10),
                          Container(
                            width: 1,
                            color: Color(0xFFD5D5D5),
                          ),
                          Expanded(
                            child: ProfileDetailItem(
                              label: 'Status',
                              value: status,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      )
    );
  }
}