import 'package:flutter/material.dart';
import '../components/tab_type_2.dart';
import '../components/transactions/transactions_history.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: TransactionsPage(),
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

class TransactionsPage extends StatefulWidget {
  TransactionsPage({Key? key}) : super(key: key);
  @override
  TransactionsPageState createState() => TransactionsPageState();
}

class TransactionsPageState extends State<TransactionsPage> {
  bool isLoading = true;
  Map<String, dynamic>? responseData;
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

  // void updateTabs() {
  //   setState(() {
  //     tabs1 = [
  //       TabItem1(
  //         title: 'Loans',
  //         content: TabComponent2(tabs2: tabs2_loans),
  //       ),
  //       TabItem1(
  //         title: 'Transactions',
  //         content: TabComponent2(tabs2: tabs2_transactions),
  //       ),
  //       TabItem1(
  //         title: 'Comments',
  //         content: Center(child: Text('Comments Content')),
  //       ),
  //       TabItem1(
  //         title: 'Digital Loan Card',
  //         content: isLoading
  //             ? const Center(child: CircularProgressIndicator())
  //             : responseData == null
  //             ? const Center(child: Text('No data available'))
  //             : InfoCard(
  //           key: ValueKey(responseData.hashCode),
  //           name: responseData!["customerDetails"][0]["CustomerName"]?.toString() ?? '',
  //           id: responseData!["customerDetails"][0]["CustomerId"]?.toString() ?? '',
  //           phone: responseData!["customerDetails"][0]["MobileNo"]?.toString() ?? '',
  //           guardian: responseData!["customerDetails"][0]["FatherSpouseName"]?.toString() ?? '',
  //           insuranceCoveredFor: "${responseData!["customerDetails"][0]["CustomerName"] ?? ''} & ${responseData!["customerDetails"][0]["FatherSpouseName"] ?? ''}",
  //           accidentalApplicant: responseData!["customerDetails"][0]["NomineeName"]?.toString() ?? '',
  //           accidentalPremium: responseData!["loanDetails"][0]["insurancePremium"]?.toString() ?? '',
  //           disbursementDate: responseData!["loanDetails"].last["disbursementDate"]?.toString() ?? '',
  //           interestRate: responseData!["loanDetails"][0]["roi"]?.toString() ?? '',
  //           lpf: responseData!["loanDetails"][0]["processingFee"]?.toString() ?? '',
  //           loanRepayment: responseData!["loanDetails"][0]["paymentFrequency"]?.toString() ?? '',
  //           center: responseData!["customerDetails"][0]["CenterName"]?.toString() ?? '',
  //           group: responseData!["customerDetails"][0]["GroupName"]?.toString() ?? '',
  //           insurancePremium: responseData!["loanDetails"][0]["insurancePremium"]?.toString() ?? '',
  //           loanAmount: totalDisbursedAmount.toStringAsFixed(2),
  //         ),
  //       ),
  //     ];
  //   });
  // }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        isLoading = false;
      });
    });
    // fetchProfileData();

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
  }

  // double totalDisbursedAmount = 0.0;

  // Future<void> fetchProfileData() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //
  //   final url = 'https://apiuat.spandanasphoorty.com/crm/api/getdetails';
  //   final bodyData = json.encode({
  //     'customerId': 3002,
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
  //       print("Response Data -------------- $data");
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          TabComponent2(tabs2: tabs2_transactions),
        ],
      ),
    );
  }
}