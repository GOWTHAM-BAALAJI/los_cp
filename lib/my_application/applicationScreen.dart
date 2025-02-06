
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:los_cp/main.dart';
import './loandetail_card.dart';
import '../components/tab_type_1.dart';
import '../components/goback_button.dart';
void main() {
  runApp(MaterialApp(
    home: applicationScreen(),
  ));
}

class applicationScreen extends StatefulWidget {
  const applicationScreen({super.key});

  @override
  State<applicationScreen> createState() => _applicationScreenState();
}

class _applicationScreenState extends State<applicationScreen> {
  late List<TabItem1> tabs1;
  @override
  void initState() {
    super.initState();
    tabs1 = [
      TabItem1(
          title: "All(3)",
          content: Column(
            children: [

              loanDetailCard(
                LoanName:"Unnati",
                LoanNo:"2496817092",
                LoanStatus:"Ongoing",
                LoanOverdueAmount:1024,
                LoanEMIAmount:1024,
                LoanTenure:36,
                LoanCollectionDay:"Thursday",
                LoanRejectReason:"Lorem Ipsum",
              ),
              SizedBox(height: 24),
              loanDetailCard(
                LoanName:"Chetana",
                LoanNo:"2496817092",
                LoanStatus:"Completed",
                LoanOverdueAmount:0,
                LoanEMIAmount:1024,
                LoanTenure:36,
                LoanCollectionDay:"Thursday",
                LoanRejectReason:"Lorem Ipsum",
              ),
              SizedBox(height: 24),
              loanDetailCard(
                LoanName:"CDL",
                LoanNo:"2496817092",
                LoanStatus:"Rejected",
                LoanOverdueAmount:0,
                LoanEMIAmount:1024,
                LoanTenure:36,
                LoanCollectionDay:"Thursday",
                LoanRejectReason:"Lorem Ipsum",
              )
            ]
          )
      ),
      TabItem1(
          title: "Ongoing(1)",
          content: Column(
              children: [
                loanDetailCard(
                  LoanName:"Unnati",
                  LoanNo:"2496817092",
                  LoanStatus:"Ongoing",
                  LoanOverdueAmount:1024,
                  LoanEMIAmount:1024,
                  LoanTenure:36,
                  LoanCollectionDay:"Thursday",
                  LoanRejectReason:"Lorem Ipsum",
                ),
                // SizedBox(height: 24),
              ]
          )
      ),
      TabItem1(
          title: "Completed(1)",
          content: Column(
              children: [

                loanDetailCard(
                  LoanName:"Chetana",
                  LoanNo:"2496817092",
                  LoanStatus:"Completed",
                  LoanOverdueAmount:0,
                  LoanEMIAmount:1024,
                  LoanTenure:36,
                  LoanCollectionDay:"Thursday",
                  LoanRejectReason:"Lorem Ipsum",
                ),
              ]
          )
      ),
      TabItem1(
          title: "Rejected(1)",
          content: Column(
              children: [
                loanDetailCard(
                  LoanName:"CDL",
                  LoanNo:"2496817092",
                  LoanStatus:"Rejected",
                  LoanOverdueAmount:0,
                  LoanEMIAmount:1024,
                  LoanTenure:36,
                  LoanCollectionDay:"Thursday",
                  LoanRejectReason:"Lorem Ipsum",
                )
              ]
          )
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            GoBack(title: "Portfolio"),
            Row(
              children: [
                TabComponent1(tabs1: tabs1),
              ],
            )
          ],
        ),
      ),
    );
  }
}
