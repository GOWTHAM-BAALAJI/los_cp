
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import './loandetail_card.dart';
import '../components/tab_type_1.dart';
import 'dart:convert';

import '../components/goback_button.dart';
// void main() {
//   runApp(MaterialApp(
//     home: applicationScreen(),
//   ));
// }

final FlutterSecureStorage secureStorage = FlutterSecureStorage();

String getDayOfWeek(String installmentDate) {
  DateTime date = DateTime.parse(installmentDate);
  List<String> daysOfWeek = [
    'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'
  ];
  return daysOfWeek[date.weekday - 1];
}

// void main() {
//   runApp(MaterialApp(
//     home: applicationScreen(),
//   ));
// }

class applicationScreen extends StatefulWidget {
  final Function(int) onNavigate;
  const applicationScreen({Key? key, required this.onNavigate}) : super(key: key);

  @override
  State<applicationScreen> createState() => _applicationScreenState();
}

class _applicationScreenState extends State<applicationScreen> {
  late List<TabItem1> tabs1;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        isLoading = false;
      });
    });
    _fetchApiResponse();
    tabs1 = [
      TabItem1(
        title: 'Ongoing()',
        content: Center(child: Text('Loading...')),
      ),
      TabItem1(
        title: 'Completed()',
        content: Center(child: Text('Loading...')),
      ),
      TabItem1(
        title: 'Rejected()',
        content: Center(child: Text('Loading...')),
      ),
      TabItem1(
        title: "All()",
        content: Center(child: Text('Loading...')),
      ),
    ];
  }

  Future<void> _fetchApiResponse() async {
    String? apiResponseString = await secureStorage.read(key: 'api_response');

    if (apiResponseString != null) {
      final apiResponse = Map<String, dynamic>.from(jsonDecode(apiResponseString));

      setState(() {
        var loanDetails = apiResponse['loanDetails'];

        tabs1 = [
          TabItem1(
            title: "Ongoing(${loanDetails.where((loan) => loan['loanStatus'] == 'Active' || loan['loanStatus'] == 'Ongoing').length})",
            content: isLoading ? Center(child: CircularProgressIndicator()) : Column(
              children: loanDetails
                  .where((loan) => loan['loanStatus'] == 'Active')
                  .map<Widget>((loan) {
                String installmentDate = loan['repaymentSchedule'][0]['installmentDate'];
                String collectionDay = getDayOfWeek(installmentDate);

                return LoanDetailCard(
                  LoanName: "Loan ${loan['productName']}",
                  LoanNo: loan['loanDisplayId'].toString(),
                  LoanStatus: loan['loanStatus'],
                  LoanOverdueAmount: loan['overdueAmount'],
                  LoanEMIAmount: loan['emiAmount'],
                  LoanTenure: loan['noOfInstallments'],
                  LoanCollectionDay: collectionDay,
                  LoanPaymentFrequency: loan['paymentFrequency'],
                  LoanRejectReason: loan['loanStatus'] == "Rejected" ? "Not Approved" : "",
                );
              }).toList(),
            ),
          ),
          TabItem1(
            title: "Completed(${loanDetails.where((loan) => loan['loanStatus'] == 'Completed').length})",
            content: isLoading ? Center(child: CircularProgressIndicator()) : Column(
              children: loanDetails
                  .where((loan) => loan['loanStatus'] == 'Completed')
                  .map<Widget>((loan) {
                String installmentDate = loan['repaymentSchedule'][0]['installmentDate'];
                String collectionDay = getDayOfWeek(installmentDate);

                return LoanDetailCard(
                  LoanName: "Loan ${loan['productName']}",
                  LoanNo: loan['loanDisplayId'],
                  LoanStatus: loan['loanStatus'],
                  LoanOverdueAmount: loan['overdueAmount'],
                  LoanEMIAmount: loan['emiAmount'],
                  LoanTenure: loan['noOfInstallments'],
                  LoanCollectionDay: collectionDay,
                  LoanPaymentFrequency: loan['paymentFrequency'],
                  LoanRejectReason: loan['loanStatus'] == "Rejected" ? "Not Approved" : "",
                );
              }).toList(),
            ),
          ),
          TabItem1(
            title: "Rejected(${loanDetails.where((loan) => loan['loanStatus'] == 'Rejected').length})",
            content: isLoading ? Center(child: CircularProgressIndicator()) : Column(
              children: loanDetails
                  .where((loan) => loan['loanStatus'] == 'Rejected')
                  .map<Widget>((loan) {
                String installmentDate = loan['repaymentSchedule'][0]['installmentDate'];
                String collectionDay = getDayOfWeek(installmentDate);

                return LoanDetailCard(
                  LoanName: "Loan ${loan['productName']}",
                  LoanNo: loan['loanDisplayId'].toString(),
                  LoanStatus: loan['loanStatus'],
                  LoanOverdueAmount: loan['overdueAmount'],
                  LoanEMIAmount: loan['emiAmount'],
                  LoanTenure: loan['noOfInstallments'],
                  LoanCollectionDay: collectionDay,
                  LoanPaymentFrequency: loan['paymentFrequency'],
                  LoanRejectReason: loan['loanStatus'] == "Rejected" ? "Not Approved" : "",
                );
              }).toList(),
            ),
          ),
          TabItem1(
            title: "All(${loanDetails.length})",
            content: isLoading ? Center(child: CircularProgressIndicator()) : Column(
              children: loanDetails.map<Widget>((loan) {
                String installmentDate = loan['repaymentSchedule'][0]['installmentDate'];
                String collectionDay = getDayOfWeek(installmentDate);

                return LoanDetailCard(
                  LoanName: "Loan ${loan['productName']}",
                  LoanNo: loan['loanDisplayId'].toString(),
                  LoanStatus: loan['loanStatus'],
                  LoanOverdueAmount: loan['overdueAmount'],
                  LoanEMIAmount: loan['emiAmount'],
                  LoanTenure: loan['noOfInstallments'],
                  LoanCollectionDay: collectionDay,
                  LoanPaymentFrequency: loan['paymentFrequency'],
                  LoanRejectReason: loan['loanStatus'] == "Rejected" ? "Not Approved" : "",
                );
              }).toList(),
            ),
          ),
        ];
      });
    } else {
      print("Portfolio Details Not Available");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: SafeArea(
          child: Column(
            children: [
              GoBack(title: "Portfolio", onNavigate: widget.onNavigate),
              SizedBox(height: 10,),
              Expanded(
                child: TabComponent1(tabs1: tabs1),
              ),
            ],
          ),
        )
    );
  }
}
