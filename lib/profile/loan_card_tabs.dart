import 'package:flutter/material.dart';
import '../components/tab_type_2.dart';
import 'digital_loan_card.dart';

class LoanCardsPage extends StatefulWidget {
  final Map<String, dynamic>? responseData;
  final bool isLoading;

  const LoanCardsPage({
    Key? key,
    required this.responseData,
    required this.isLoading,
  }) : super(key: key);

  @override
  LoanCardsPageState createState() => LoanCardsPageState();
}

class LoanCardsPageState extends State<LoanCardsPage> {
  List<TabItem2> tabs2_loans = [];

  @override
  void initState() {
    super.initState();
    _initializeTabs();
  }

  void _initializeTabs() {
    if (widget.responseData != null && widget.responseData!['loanDetails'] != null) {
      var loanDetails = widget.responseData!['loanDetails'] as List;

      tabs2_loans = loanDetails.map((loan) {
        return TabItem2(
          title: 'Loan ID - ${loan['loanDisplayId']}',
          content: SingleChildScrollView(
            child: InfoCard(
              key: ValueKey(loan['loanId']),
              name: widget.responseData!["customerDetails"][0]["CustomerName"]?.toString() ?? '',
              id: widget.responseData!["customerDetails"][0]["CustomerId"]?.toString() ?? '',
              phone: widget.responseData!["customerDetails"][0]["MobileNo"]?.toString() ?? '',
              guardian: widget.responseData!["customerDetails"][0]["FatherSpouseName"]?.toString() ?? '',
              insuranceCoveredFor: "${widget.responseData!["customerDetails"][0]["CustomerName"] ?? ''} & ${widget.responseData!["customerDetails"][0]["FatherSpouseName"] ?? ''}",
              accidentalApplicant: widget.responseData!["customerDetails"][0]["NomineeName"]?.toString() ?? '',
              accidentalPremium: loan["insurancePremium"]?.toString() ?? '',
              disbursementDate: _formatDate(loan["disbursementDate"]?.toString() ?? ''),
              interestRate: loan["roi"]?.toString() ?? '',
              lpf: loan["processingFee"]?.toString() ?? '',
              loanRepayment: loan["paymentFrequency"]?.toString() ?? '',
              center: widget.responseData!["customerDetails"][0]["CenterName"]?.toString() ?? '',
              group: widget.responseData!["customerDetails"][0]["GroupName"]?.toString() ?? '',
              insurancePremium: loan["insurancePremium"]?.toString() ?? '',
              loanAmount: loan["disbursedAmount"]?.toString() ?? '',
            ),
          ),
        );
      }).toList();

      setState(() {});
    }
  }

  String _formatDate(String dateStr) {
    if (dateStr.isEmpty) return '';
    try {
      final date = DateTime.parse(dateStr);
      return '${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}';
    } catch (e) {
      return dateStr;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (widget.responseData == null || tabs2_loans.isEmpty) {
      return const Center(child: Text('No loan data available'));
    }

    return Column(
      children: [
        Expanded(
          child: TabComponent2(tabs2: tabs2_loans),
        ),
      ],
    );
  }
}
