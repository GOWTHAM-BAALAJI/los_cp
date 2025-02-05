import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';
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
  List<dynamic> transactionList = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        isLoading = false;
      });
    });
    fetchProfileData();

    tabs2_transactions = [
      TabItem2(
        title: 'April',
        content: Center(child: Text('Loading...')),
      ),
      TabItem2(
        title: 'May',
        content: Center(child: Text('Loading...')),
      ),
    ];
  }

  int getTransactionStatus(String particulars) {
    if (particulars == "Disbursement") {
      return 1;
    } else if (particulars == "PTP date created") {
      return 3;
    } else {
      return 2;
    }
  }

  double getTransactionAmount(Map<String, dynamic> transaction) {
    final particulars = transaction['particulars']?.toString() ?? '';
    if (particulars == "Disbursement") {
      // Convert dr value to double safely
      return double.tryParse(transaction['dr']?.toString() ?? '0') ?? 0.0;
    } else {
      // Convert cr value to double safely
      return double.tryParse(transaction['cr']?.toString() ?? '0') ?? 0.0;
    }
  }

  String formatDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) {
      return 'No Date';
    }

    try {
      // Parse the original date string (assuming it's in a standard format)
      DateTime parsedDate = DateTime.parse(dateStr);

      // Format the date as 'dd-MM-yyyy'
      return DateFormat('dd-MM-yyyy').format(parsedDate);
    } catch (e) {
      print('Error formatting date: $e');
      return 'Invalid Date';
    }
  }


  void updateTabs() {
    try {
      transactionList.clear();

      if (responseData != null && responseData!['loanDetails'] is List) {
        List<dynamic> loanDetails = responseData!['loanDetails'];

        for (int i = 0; i < loanDetails.length; i++) {
          var loan = loanDetails[i];
          if (loan['transactionDetails'] is List) {
            List<dynamic> transactions = loan['transactionDetails'];
            transactionList.addAll(transactions);
          }
        }
      }

      // Safely access customerName from customerDetails
      String customerName = '';
      if (responseData != null) {
        customerName = responseData!["customerDetails"][0]["CustomerName"]?.toString() ?? '';
      }

      setState(() {
        tabs2_transactions = [
          TabItem2(
            title: 'April',
            content: Center(child: Text('Current & Eligible Content')),
          ),
          TabItem2(
            title: 'May',
            content: isLoading
                ? const Center(child: CircularProgressIndicator())
                : responseData == null
                ? const Center(child: Text('No data available'))
                : Container(
              margin: EdgeInsets.zero,
              height: 600,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: transactionList.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> transaction =
                  transactionList[index] is Map<String, dynamic>
                      ? transactionList[index]
                      : {};

                  String particulars = transaction['particulars']?.toString() ?? 'No Title';

                  return TransactionItemWidget(
                    title: particulars,
                    username: customerName,
                    amount: getTransactionAmount(transaction),
                    date: formatDate(transaction['date']?.toString()),
                    status: getTransactionStatus(particulars),
                  );
                },
              ),
            ),
          ),
        ];
      });
    } catch (e) {
      print('Error updating tabs: $e');
      setState(() {
        tabs2_transactions = [
          TabItem2(
            title: 'April',
            content: Center(child: Text('Error loading content')),
          ),
          TabItem2(
            title: 'May',
            content: Center(child: Text('Error loading content')),
          ),
        ];
      });
    }
  }

  Future<void> fetchProfileData() async {
    setState(() {
      isLoading = true;
    });

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

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade100,
      child: SingleChildScrollView(
        child: Column(
          children: [
            TabComponent2(tabs2: tabs2_transactions),
          ],
        ),
      ),
    );
  }
}