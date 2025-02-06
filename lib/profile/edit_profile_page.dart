import 'dart:convert';
import '../components/row_align_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'edit_profile_component.dart';
import '../components/expand_widget.dart';
import '../components/profileAppBar.dart';
import '../components/goback_button.dart';

// void main() {
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: EditProfilePage(),
//   ));
// }

class EditProfilePage extends StatefulWidget {
  EditProfilePage({Key? key}) : super(key: key);
  @override
  EditProfilePageState createState() => EditProfilePageState();
}

class EditProfilePageState extends State<EditProfilePage> {
  bool isLoading = true;
  Map<String, dynamic>? responseData;

  final _storage = FlutterSecureStorage();

  Future<void> _loadData() async {
    String? jsonData = await _storage.read(key: 'api_response');

    if (jsonData != null) {
      Map<String, dynamic> data = jsonDecode(jsonData);

      if (data.containsKey("customerDetails") && data["customerDetails"].isNotEmpty) {
        setState(() {
          responseData = data;
          isLoading = false;
        });
      }
    }
  }

  String formatDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) {
      return 'No Date';
    }

    try {
      DateTime parsedDate = DateTime.parse(dateStr);
      return DateFormat('dd-MM-yyyy').format(parsedDate);
    } catch (e) {
      print('Error formatting date: $e');
      return 'Invalid Date';
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        isLoading = false;
      });
    });
    _loadData();
  }

  String _toString(dynamic value) {
    if (value == "null") {
      return "null";
    } else if(value == null || value == ""){
      return "N/A";
    }
    return value.toString();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading || responseData == null) {
      return Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: Center(child: Text('Loading...')),
      );
    }

    var customer = responseData!["customerDetails"][0];
    var loan = responseData!["loanDetails"][0];

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: ProfileAppBar(
        name: _toString(customer["CustomerName"]),
        id: _toString(customer["CustomerId"]),
        location: _toString(customer["CenterName"]),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 12, top: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context); // Pop the current screen when tapped
                    },
                    child: Icon(Icons.arrow_back),
                  ),
                  SizedBox(width: 8),
                  Text(
                    "View Profile",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF101010),
                      fontFamily: "Lato",
                    ),
                  ),
                ],
              ),
            ),
            ProfileDetailsCardWidget(
              name: _toString(customer["CustomerName"]),
              id: _toString(customer["CustomerId"]),
              address: _toString(customer["address"]),
              maritalStatus: customer["MaritalStatus"] == "M" ? "Married" : "Unmarried",
              husbandFatherName: _toString(customer["FatherSpouseName"]),
              coInsured: _toString(customer["FatherSpouseName"]),
              age: _toString(customer["ClientAge"]),
              dob: formatDate(_toString(customer["DateOfBirth"])),
              religion: _toString(customer["Religion"]),
              education: _toString(customer["Education"]),
              motherName: _toString(customer["MotherName"]),
              fatherName: _toString(customer["FatherName"]),
              profileImageUrl: 'assets/images/female_profilepic.png',
            ),
            Column(
              children: [
                ExpandableSectionWidget(
                  title: 'Co-insured/Nominee Details',
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InfoRow(label: "Nominee Name", value: "${_toString(customer["NomineeName"])}"),
                      InfoRow(label: "Nominee Age", value: "${_toString(customer["NomineeAge"])}"),
                      InfoRow(label: "Nominee KYC Id", value: "${_toString(customer["NomineeKycId"])}"),
                    ],
                  ),
                ),
                ExpandableSectionWidget(
                  title: 'Product Details',
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InfoRow(label: "Product Name", value: "${_toString(loan["productName"])}"),
                      InfoRow(label: "Product Id", value: "${_toString(loan["loanId"])}"),
                      InfoRow(label: "Disbursed Amount", value: "${_toString(loan["disbursedAmount"])}"),
                    ],
                  ),
                ),
                ExpandableSectionWidget(
                  title: 'Bank Details',
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InfoRow(label: "Bank Name", value: "${_toString(customer["BankName"])}"),
                      InfoRow(label: "Bank Account Number", value: "${_toString(customer["BankAccountNumber"])}"),
                    ],
                  ),
                ),
                ExpandableSectionWidget(
                  title: 'Household Profile',
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InfoRow(label: "House Address", value: "${_toString(customer["address"])}"),
                      InfoRow(label: "Household Income", value: "${_toString(customer["HouseholdIncome"])}"),
                      InfoRow(label: "Household Expenses", value: "${_toString(customer["HouseholdExp"])}"),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}