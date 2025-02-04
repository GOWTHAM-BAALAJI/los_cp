import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'user_details.dart';
import 'digital_loan_card.dart';
import '../components/tab_type_1.dart';
import '../components/tab_type_2.dart';
import '../components/transactions/transactions_history.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ProfilePage(),
  ));
}

class Transaction {
  final String title;
  final String username;
  final double amount;
  final String date;
  final int status;

  Transaction({
    required this.title,
    required this.username,
    required this.amount,
    required this.date,
    required this.status,
  });
}

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);
  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  bool isLoading = true;
  Map<String, dynamic>? responseData;
  late List<TabItem1> tabs1;
  late List<TabItem2> tabs2_transactions;
  final List<Transaction> transactions = [
    Transaction(
      title: 'Regular + OD collection',
      username: 'Rohit Thiru',
      amount: 3072,
      date: '30th Apr',
      status: 1,
    ),
    Transaction(
      title: 'Regular + OD collection',
      username: 'Rohit Thiru',
      amount: 3072,
      date: '30th Apr',
      status: 2,
    ),
    Transaction(
      title: 'Loan Payment',
      username: 'John Doe',
      amount: 5000,
      date: '1st May',
      status: 1,
    ),
    Transaction(
      title: 'Salary Deposit',
      username: 'Jane Smith',
      amount: 15000,
      date: '5th May',
      status: 0,
    ),
    Transaction(
      title: 'Regular + OD collection',
      username: 'Rohit Thiru',
      amount: 3072,
      date: '30th Apr',
      status: 1,
    ),
    Transaction(
      title: 'Loan Payment',
      username: 'John Doe',
      amount: 5000,
      date: '1st May',
      status: 1,
    ),
    Transaction(
      title: 'Salary Deposit',
      username: 'Jane Smith',
      amount: 15000,
      date: '5th May',
      status: 0,
    ),
    Transaction(
      title: 'Regular + OD collection',
      username: 'Rohit Thiru',
      amount: 3072,
      date: '30th Apr',
      status: 1,
    ),
    Transaction(
      title: 'Loan Payment',
      username: 'John Doe',
      amount: 5000,
      date: '1st May',
      status: 1,
    ),
    Transaction(
      title: 'Salary Deposit',
      username: 'Jane Smith',
      amount: 15000,
      date: '5th May',
      status: 0,
    ),
  ];

  final tabs2_loans = [
    TabItem2(
      title: 'Current & Eligible',
      content: Center(child: Text('Current & Eligible Content')),
    ),
    TabItem2(
      title: 'Previous & Loans',
      content: Center(child: Text('Previous & Loans Content')),
    ),
  ];

  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = false;
    });
    fetchProfileData();

    tabs2_transactions = [
      TabItem2(
        title: 'April',
        content: Center(child: Text('Current & Eligible Content')),
      ),
      TabItem2(
        title: 'May',
        content: Container(
          margin: EdgeInsets.zero,
          height: 600,
          child: ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              final transaction = transactions[index];
              return TransactionItemWidget(
                title: transaction.title,
                username: transaction.username,
                amount: transaction.amount,
                date: transaction.date,
                status: transaction.status,
              );
            },
          ),
        ),
      ),
    ];

    tabs1 = [
      TabItem1(
        title: 'Loans',
        content: TabComponent2(tabs2: tabs2_loans),
      ),
      TabItem1(
        title: 'Transactions',
        content: TabComponent2(tabs2: tabs2_transactions),
      ),
      TabItem1(
        title: 'Comments',
        content: Center(child: Text('Comments Content')),
      ),
      TabItem1(
        title: 'Digital Loan Card',
        content: responseData == null
            ? InfoCard(
                key: ValueKey("loading"),
                name: "Loading",
                id: "Loading",
                phone: "Loading",
                guardian: "Loading",
                insuranceCoveredFor: "Loading",
                accidentalApplicant: "Loading",
                accidentalPremium: "Loading",
                disbursementDate: "Loading",
                interestRate: "Loading",
                lpf: "Loading",
                loanRepayment: "Loading",
                center: "Loading",
                group: "Loading",
                insurancePremium: "Loading",
                loanAmount: "Loading",
              )
            : InfoCard(
                key: ValueKey(responseData),
                name: responseData!["customerDetails"][0]["CustomerName"],
                id: responseData!["customerDetails"][0]["CustomerId"].toString(),
                phone: responseData!["customerDetails"][0]["MobileNo"],
                guardian: responseData!["customerDetails"][0]["FatherSpouseName"],
                insuranceCoveredFor:
                "${responseData!["customerDetails"][0]["CustomerName"]} & ${responseData!["customerDetails"][0]["FatherSpouseName"]}",
                accidentalApplicant: responseData!["customerDetails"][0]["NomineeName"],
                accidentalPremium: responseData!["loanDetails"][0]["insurancePremium"],
                disbursementDate: responseData!["loanDetails"].last["disbursementDate"],
                interestRate: responseData!["loanDetails"][0]["roi"],
                lpf: responseData!["loanDetails"][0]["processingFee"],
                loanRepayment: responseData!["loanDetails"][0]["paymentFrequency"],
                center: responseData!["customerDetails"][0]["CenterName"],
                group: responseData!["customerDetails"][0]["GroupName"],
                insurancePremium: responseData!["loanDetails"][0]["insurancePremium"],
                loanAmount: totalDisbursedAmount.toString(),
            ),
      ),
    ];
  }

  double totalDisbursedAmount = 0.0;

  Future<void> fetchProfileData() async {
    final url = 'https://apiuat.spandanasphoorty.com/crm/api/getdetails';
    final bodyData = json.encode({
      'customerId': 3002,
    });
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'client_id': '0534da59ff1647d491a46d2f31378895',
          'client_secret': 'abA1dFdD41E245EDADC77CA8d1A75a7F'
        },
        body: bodyData,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        print("Response Data -------------- $data");
        if (data['loanDetails'] != null) {
          totalDisbursedAmount = 0.0; // Reset the amount
          for (var loan in data['loanDetails']) {
            // Assuming disbursedAmount is present in the response, change key if needed
            totalDisbursedAmount += loan['disbursedAmount'] ?? 0.0;
          }
        }
        setState(() {
          responseData = data;
        });
        setState(() {
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load profile');
      }
    } catch (e) {
      print('Error fetching profile data: $e');
    }
  }

  String _formatDate(String date) {
    DateTime parsedDate = DateTime.parse(date);
    return "${parsedDate.day}-${parsedDate.month}-${parsedDate.year}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: SingleChildScrollView(
          child: Column(
            children: [
              if (isLoading)
                ProfileDetailsCard(
                  name: 'Loading...',
                  id: 'Loading...',
                  lo: 'Loading...',
                  village: 'Loading...',
                  centre: 'Loading...',
                  group: 'Loading...',
                  memberSince: 'Loading...',
                  activeLoans: 'Loading...',
                  status: 'Loading...',
                  profileImageUrl: 'assets/images/female_profilepic.png',
                )
              else if (responseData != null) // Ensure responseData is not null
                ProfileDetailsCard(
                  name: responseData!["customerDetails"][0]["CustomerName"],
                  id: responseData!["customerDetails"][0]["CustomerId"].toString(),
                  lo: "Random Person",
                  village: responseData!["customerDetails"][0]["village"],
                  centre: responseData!["customerDetails"][0]["CenterName"],
                  group: responseData!["customerDetails"][0]["GroupName"],
                  memberSince: _formatDate(responseData!["loanDetails"][0]["disbursementDate"]),
                  activeLoans: responseData!["loanDetails"][0]["loanStatus"] == "Active" ? "1" : "0",
                  status: "Active",
                  profileImageUrl: 'assets/images/female_profilepic.png', // Placeholder image URL
                )
              else
                ProfileDetailsCard(
                  name: 'Loading...',
                  id: 'Loading...',
                  lo: 'Loading...',
                  village: 'Loading...',
                  centre: 'Loading...',
                  group: 'Loading...',
                  memberSince: 'Loading...',
                  activeLoans: 'Loading...',
                  status: 'Loading...',
                  profileImageUrl: 'assets/images/female_profilepic.png',
                ),
              // ProfileDetailsCard(
              //   name: 'Anika Rehman',
              //   id: '849557572',
              //   lo: 'Rohit Thru',
              //   village: 'Puslod',
              //   centre: 'Jhulod-7469760',
              //   group: '19-JA-SC-G4',
              //   memberSince: 'Apr 12, 2023',
              //   activeLoans: '1',
              //   status: 'Standard',
              //   profileImageUrl: 'assets/images/female_profilepic.png',
              // ),
              SizedBox(height: 16,),
              TabComponent1(tabs1: tabs1),
            ],
          )
        )
    );
  }
}