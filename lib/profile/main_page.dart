import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'user_details.dart';
import 'digital_loan_card.dart';
import '../components/tab_type_1.dart';
import '../components/tab_type_2.dart';
import '../transactions/main_page.dart';
import '../components/profile/comments_card.dart';
import '../my_application/loandetail_card.dart';
import '../components/goback_button.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ProfilePage(),
  ));
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

  String _getCollectionDay(String frequency) {
    switch (frequency.toLowerCase()) {
      case 'biweekly':
        return 'Every 2 weeks';
      case 'weekly':
        return 'Every week';
      case 'monthly':
        return 'Monthly';
      default:
        return frequency;
    }
  }

  void updateTabs() {
    final tabs2_loans = [
      TabItem2(
        title: 'Current & Eligible',
        content: responseData != null && responseData!['loanDetails'].isNotEmpty
            ? Container(
          margin: EdgeInsets.zero,
          height: 600,
          child: ListView.builder(
            itemCount: responseData!['loanDetails']
                .where((loan) => loan['loanStatus'] == 'Active')
                .length,
            itemBuilder: (context, index) {
              final activeLoans = responseData!['loanDetails']
                  .where((loan) => loan['loanStatus'] == 'Active')
                  .toList();

              if (activeLoans.isEmpty) {
                return Center(child: Text('No active loans'));
              } else {
                final loan = activeLoans[index];
                return LoanDetailCard(
                  LoanName: loan['productName'] ?? '',
                  LoanNo: loan['loanDisplayId'].toString(),
                  LoanStatus: loan['loanStatus'] ?? '',
                  LoanOverdueAmount: loan['overdueAmount']?.toDouble() ?? 0.0,
                  LoanEMIAmount: loan['emiAmount']?.toDouble() ?? 0.0,
                  LoanTenure: loan['noOfInstallments'] ?? 0,
                  LoanCollectionDay: _getCollectionDay(loan['paymentFrequency'] ?? ''),
                  LoanRejectReason: '',
                );
              }
            },
          ),
        )
            : Center(child: Text('No active loans')),
      ),
      TabItem2(
        title: 'Previous Loans',
        content: responseData != null && responseData!['loanDetails'].isNotEmpty
            ? Container(
          margin: EdgeInsets.zero,
          height: 600,
          child: ListView.builder(
            itemCount: responseData!['loanDetails']
                .where((loan) => loan['loanStatus'] != 'Active')
                .length,
            itemBuilder: (context, index) {
              final previousLoans = responseData!['loanDetails']
                  .where((loan) => loan['loanStatus'] != 'Active')
                  .toList();

              if (previousLoans.isEmpty) {
                return Center(child: Text('No previous loans'));
              } else {
                final loan = previousLoans[index];
                return LoanDetailCard(
                  LoanName: loan['productName'] ?? '',
                  LoanNo: loan['loanDisplayId'].toString(),
                  LoanStatus: loan['loanStatus'] ?? '',
                  LoanOverdueAmount: loan['overdueAmount']?.toDouble() ?? 0.0,
                  LoanEMIAmount: loan['emiAmount']?.toDouble() ?? 0.0,
                  LoanTenure: loan['noOfInstallments'] ?? 0,
                  LoanCollectionDay: _getCollectionDay(loan['paymentFrequency'] ?? ''),
                  LoanRejectReason: '',
                );
              }
            },
          ),
        )
            : Center(child: Text('No previous loans')),
      ),
    ];

    setState(() {
      tabs1 = [
        TabItem1(
          title: 'Loans',
          content: TabComponent2(tabs2: tabs2_loans),
        ),
        TabItem1(
          title: 'Transactions',
          content: TransactionsPage(),
        ),
        TabItem1(
          title: 'Comments',
          content: SingleChildScrollView(
            child: Column(
              children: [
                CommentCard(
                  profilePic: "assets/images/female_profilepic.png",
                  name: "Rohit Thiru",
                  date: "Apr 11, 2024",
                  time: "12:34 PM",
                  comment: "Lorem ipsum dolor sit amet, consectetur elit, sed do eiusmod tempor",
                ),
                CommentCard(
                  profilePic: "assets/images/female_profilepic.png",
                  name: "Rohit Thiru",
                  date: "Apr 11, 2024",
                  time: "12:34 PM",
                  comment: "Lorem ipsum dolor sit amet, consectetur elit, sed do eiusmod tempor",
                ),
              ],
            ),
          ),
        ),
        TabItem1(
          title: 'Digital Loan Card',
          content: isLoading
              ? const Center(child: CircularProgressIndicator())
              : responseData == null
              ? const Center(child: Text('No data available'))
              : InfoCard(
            key: ValueKey(responseData.hashCode),
            name: responseData!["customerDetails"][0]["CustomerName"]?.toString() ?? '',
            id: responseData!["customerDetails"][0]["CustomerId"]?.toString() ?? '',
            phone: responseData!["customerDetails"][0]["MobileNo"]?.toString() ?? '',
            guardian: responseData!["customerDetails"][0]["FatherSpouseName"]?.toString() ?? '',
            insuranceCoveredFor: "${responseData!["customerDetails"][0]["CustomerName"] ?? ''} & ${responseData!["customerDetails"][0]["FatherSpouseName"] ?? ''}",
            accidentalApplicant: responseData!["customerDetails"][0]["NomineeName"]?.toString() ?? '',
            accidentalPremium: responseData!["loanDetails"][0]["insurancePremium"]?.toString() ?? '',
            disbursementDate: _formatDate(responseData!["loanDetails"].last["disbursementDate"]!.toString()) ?? '',
            interestRate: responseData!["loanDetails"][0]["roi"]?.toString() ?? '',
            lpf: responseData!["loanDetails"][0]["processingFee"]?.toString() ?? '',
            loanRepayment: responseData!["loanDetails"][0]["paymentFrequency"]?.toString() ?? '',
            center: responseData!["customerDetails"][0]["CenterName"]?.toString() ?? '',
            group: responseData!["customerDetails"][0]["GroupName"]?.toString() ?? '',
            insurancePremium: responseData!["loanDetails"][0]["insurancePremium"]?.toString() ?? '',
            loanAmount: totalDisbursedAmount.toStringAsFixed(2),
          ),
        ),
      ];
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = false;
    });
    fetchProfileData();

    tabs1 = [
      TabItem1(
        title: 'Loans',
        content: Center(child: Text('Loading...')),
      ),
      TabItem1(
        title: 'Transactions',
        content: Center(child: Text('Loading...')),
      ),
      TabItem1(
        title: 'Comments',
        content: Center(child: Text('Loading...')),
      ),
      TabItem1(
        title: 'Digital Loan Card',
        content: Center(child: Text('Loading...')),
      ),
    ];
  }

  double totalDisbursedAmount = 0.0;

  Future<void> fetchProfileData() async {
    setState(() {
      isLoading = true;
    });

    final url = 'https://apiuat.spandanasphoorty.com/crm/api/getdetails';
    final bodyData = json.encode({
      'customerId': 3009,
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

        if (data['loanDetails'] != null) {
          totalDisbursedAmount = 0.0;
          for (var loan in data['loanDetails']) {
            totalDisbursedAmount += loan['disbursedAmount'] ?? 0.0;
          }
        }

        setState(() {
          responseData = data;
          isLoading = false;
        });
        updateTabs();
      } else {
        throw Exception('Failed to load profile');
      }
    } catch (e) {
      print('Error fetching profile data: $e');
      setState(() {
        isLoading = false;
      });
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
              GoBack(title: "Profile"),
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
              else if (responseData != null)
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