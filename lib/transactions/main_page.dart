import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../components/tab_type_2.dart';
import '../components/transactions/transactions_history.dart';
import '../components/goback_button.dart';

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
  Map<String, List<dynamic>> transactionsByMonth = {};
  List<dynamic> transactionList = [];
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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        isLoading = false;
      });
    });
    _loadData();

    tabs2_transactions = [
      TabItem2(
        title: 'Loading...',
        content: Center(child: Text('Loading...')),
      ),
      TabItem2(
        title: 'Loading...',
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
      return double.tryParse(transaction['dr']?.toString() ?? '0') ?? 0.0;
    } else {
      return double.tryParse(transaction['cr']?.toString() ?? '0') ?? 0.0;
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

  void organizeTransactionsByMonth() {
    transactionsByMonth.clear();

    if (responseData != null && responseData!['loanDetails'] is List) {
      List<dynamic> loanDetails = responseData!['loanDetails'];

      for (var loan in loanDetails) {
        if (loan['transactionDetails'] is List) {
          List<dynamic> transactions = loan['transactionDetails'];
          for (var transaction in transactions) {
            String? dateStr = transaction['date']?.toString();
            if (dateStr != null) {
              try {
                DateTime parsedDate = DateTime.parse(dateStr);
                String monthYear = DateFormat('MMMM yyyy').format(parsedDate); // Format as "Month Year"

                if (!transactionsByMonth.containsKey(monthYear)) {
                  transactionsByMonth[monthYear] = [];
                }
                transactionsByMonth[monthYear]!.add(transaction);
              } catch (e) {
                print('Error parsing date: $e');
              }
            }
          }
        }
      }
    }
  }

  void updateTabs() {
    organizeTransactionsByMonth(); // Organize transactions

    List<String> sortedMonths = transactionsByMonth.keys.toList();
    sortedMonths.sort((a, b) {
      DateFormat format = DateFormat("MMMM yyyy");
      DateTime dateA = format.parse(a);
      DateTime dateB = format.parse(b);
      return dateA.compareTo(dateB);
    });

    setState(() {
      tabs2_transactions = sortedMonths.map((monthYear) {
        return TabItem2(
          title: monthYear,
          content: isLoading
              ? const Center(child: CircularProgressIndicator())
              : transactionsByMonth[monthYear] == null || transactionsByMonth[monthYear]!.isEmpty
              ? const Center(child: Text('No data available'))
              : ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: transactionsByMonth[monthYear]!.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> transaction = transactionsByMonth[monthYear]![index] is Map<String, dynamic>
                  ? transactionsByMonth[monthYear]![index]
                  : {};

              String customerName = responseData!["customerDetails"][0]["CustomerName"]?.toString() ?? '';
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
        );
      }).toList();
    });
  }

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
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: TabComponent2(tabs2: tabs2_transactions),
            ),
          ],
        ),
      )
    );
  }
}