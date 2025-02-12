import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'user_details.dart';
import 'loan_card_tabs.dart';
import '../components/tab_type_1.dart';
import '../components/tab_type_2.dart';
import '../transactions/main_page.dart';
import '../components/profile/comments_card.dart';
import '../my_application/loandetail_card.dart';
import '../components/goback_button.dart';

// void main() {
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: ProfilePage(),
//   ));
// }

class ProfilePage extends StatefulWidget {
  final Function(int) onNavigate;
  ProfilePage({Key? key, required this.onNavigate}) : super(key: key);
  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  bool isLoading = true;
  Map<String, dynamic>? responseData;
  late List<TabItem1> tabs1;
  final _storage = FlutterSecureStorage();

  Future<void> _loadData() async {
    String? jsonData = await _storage.read(key: 'api_response');

    if (jsonData != null) {
      Map<String, dynamic> data = jsonDecode(jsonData);

      if (data.containsKey("customerDetails") && data["customerDetails"].isNotEmpty) {
        setState(() {
          responseData = data;
        });
        updateTabs();
      }
    }
  }

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

  // String _calculateNextPaymentDate(String frequency, DateTime lastPaidDate) {
  //   DateTime nextPaymentDate = lastPaidDate;
  //
  //   switch (frequency.toLowerCase()) {
  //     case 'weekly':
  //       nextPaymentDate = nextPaymentDate.add(Duration(weeks: 1));
  //       break;
  //     case 'biweekly':
  //       nextPaymentDate = nextPaymentDate.add(Duration(weeks: 2));
  //       break;
  //     case 'monthly':
  //       nextPaymentDate = DateTime(nextPaymentDate.year, nextPaymentDate.month + 1, nextPaymentDate.day);
  //       break;
  //     default:
  //       break;
  //   }
  //   return "${nextPaymentDate.day}-${nextPaymentDate.month}-${nextPaymentDate.year}";
  // }

  void updateTabs() {
    final tabs2_loans = [
      TabItem2(
        title: 'Current & Eligible',
        content: responseData != null && responseData!['loanDetails'].isNotEmpty
            ? Container(
          margin: EdgeInsets.zero,
          // height: 300,
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
                // final lastPaidDate = DateTime.parse(loan['lastPaidDate'] ?? DateTime.now().toString());
                // final frequency = loan['paymentFrequency'] ?? 'monthly';
                // final nextPaymentDate = _calculateNextPaymentDate(frequency, lastPaidDate);
                return LoanDetailCard(
                  LoanName: loan.containsKey('productName') ? loan['productName'] : 'Unknown',
                  LoanNo: loan.containsKey('loanDisplayId') ? loan['loanDisplayId'].toString() : 'N/A',
                  LoanStatus: loan.containsKey('loanStatus') ? loan['loanStatus'] : 'Unknown',
                  LoanOverdueAmount: (loan.containsKey('overdueAmount') && loan['overdueAmount'] != null)
                      ? (loan['overdueAmount'] as num).toDouble()
                      : 0.0,
                  LoanEMIAmount: (loan.containsKey('emiAmount') && loan['emiAmount'] != null)
                      ? (loan['emiAmount'] as num).toDouble()
                      : 0.0,
                  LoanTenure: loan.containsKey('noOfInstallments') ? loan['noOfInstallments'] : 0,
                  LoanCollectionDay: _getCollectionDay(loan.containsKey('paymentFrequency') ? loan['paymentFrequency'] : ''),
                  LoanRejectReason: "Lorem Ipsum",
                  // NextPaymentDate: nextPaymentDate,
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
          // height: 600,
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
          content: LoanCardsPage(
            responseData: responseData,
            isLoading: isLoading,
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
    _loadData();

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

  // Future<void> fetchProfileData() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //
  //   final url = 'https://apiuat.spandanasphoorty.com/crm/api/getdetails';
  //   final bodyData = json.encode({
  //     'customerId': 3009,
  //   });
  //
  //   try {
  //     final response = await http.post(
  //       Uri.parse(url),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'client_id': '0534da59ff1647d491a46d2f31378895',
  //         'client_secret': 'abA1dFdD41E245EDADC77CA8d1A75a7F'
  //       },
  //       body: bodyData,
  //     );
  //
  //     if (response.statusCode == 200) {
  //       final Map<String, dynamic> data = json.decode(response.body);
  //
  //       if (data['loanDetails'] != null) {
  //         totalDisbursedAmount = 0.0;
  //         for (var loan in data['loanDetails']) {
  //           totalDisbursedAmount += loan['disbursedAmount'] ?? 0.0;
  //         }
  //       }
  //
  //       setState(() {
  //         responseData = data;
  //         isLoading = false;
  //       });
  //       updateTabs();
  //     } else {
  //       throw Exception('Failed to load profile');
  //     }
  //   } catch (e) {
  //     print('Error fetching profile data: $e');
  //     setState(() {
  //       isLoading = false;
  //     });
  //   }
  // }

  String _formatDate(String date) {
    DateTime parsedDate = DateTime.parse(date);
    return "${parsedDate.day}-${parsedDate.month}-${parsedDate.year}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Column(  // Changed from SingleChildScrollView to Column
          children: [
            GoBack(title: "Profile", onNavigate: widget.onNavigate),
            if (isLoading)
              ProfileDetailsCard(
                name: 'Loading...',
                id: 'Loading...',
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
                village: responseData!["customerDetails"][0]["village"],
                centre: responseData!["customerDetails"][0]["CenterName"],
                group: responseData!["customerDetails"][0]["GroupName"],
                memberSince: _formatDate(responseData!["loanDetails"][0]["disbursementDate"]),
                activeLoans: responseData!["loanDetails"][0]["loanStatus"] == "Active" ? "1" : "0",
                status: "Active",
                profileImageUrl: 'assets/images/female_profilepic.png',
              )
            else
              ProfileDetailsCard(
                name: 'Loading...',
                id: 'Loading...',
                village: 'Loading...',
                centre: 'Loading...',
                group: 'Loading...',
                memberSince: 'Loading...',
                activeLoans: 'Loading...',
                status: 'Loading...',
                profileImageUrl: 'assets/images/female_profilepic.png',
              ),
            SizedBox(height: 16),
            Expanded(  // Add this to give remaining space to TabComponent1
              child: TabComponent1(tabs1: tabs1),
            ),
          ],
        ),
      ),
    );
  }
}