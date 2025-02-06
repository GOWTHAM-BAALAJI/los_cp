import 'package:flutter/material.dart';
import 'edit_profile_component.dart';
import '../components/expand_widget.dart';
import '../components/profileAppBar.dart';
import '../components/goback_button.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: EditProfilePage(),
  ));
}

class EditProfilePage extends StatefulWidget {
  EditProfilePage({Key? key}) : super(key: key);
  @override
  EditProfilePageState createState() => EditProfilePageState();
}

class EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: ProfileAppBar(
          name: 'Anika',
          id: '94556387',
          location: 'Jhalod',
        ),
        body: SingleChildScrollView(
            child: Column(
                children: [
                  GoBack(title: "Edit Profile"),
                  ProfileDetailsCardWidget(
                    name: 'Anika Rehman',
                    id: '849557572',
                    address: '3, Shri Hari Apt, B/h Hotel Expr, 3, Shri Hari Dr, B/h Hotel Expr, Alkapuri',
                    maritalStatus: 'Married',
                    husbandFatherName: 'Abdullah Mohammed Rahman',
                    coInsured: 'Abdullah Mohammed Rahman',
                    age: '36',
                    dob: '24-04-1988',
                    religion: 'Muslim',
                    education: '10th pass',
                    motherName: 'Fatima Begum',
                    fatherName: 'Salim Rahman',
                    profileImageUrl: 'assets/images/female_profilepic.png',
                  ),
                  Column(
                    children: [
                      ExpandableSectionWidget(
                        title: 'Co-insured/Nominee Details',
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Nominee Name: John Doe'),
                            Text('Relationship: Spouse'),
                          ],
                        ),
                      ),
                      ExpandableSectionWidget(
                        title: 'Product Details',
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Product Type: Term Insurance'),
                            Text('Coverage Amount: 500,000'),
                          ],
                        ),
                      ),
                      ExpandableSectionWidget(
                        title: 'Bank Details',
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Bank Name: ABC Bank'),
                            Text('Account Number: XXXXX1234'),
                          ],
                        ),
                      ),
                      ExpandableSectionWidget(
                        title: 'Household Profile',
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('House Address: ABC Street'),
                            Text('House Type: Owned'),
                          ],
                        ),
                      ),
                    ],
                  )
                ]
            )
        )
    );
  }
}