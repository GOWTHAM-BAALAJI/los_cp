
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:los_cp/main.dart';
import './loandetail_card.dart';
import '../components/tab_type_1.dart';
import './searchBar.dart';

import '../components/goback_button.dart';
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
  @override
  void initState() {
    super.initState();
    tabs1 = [
      TabItem1(
          title: "All(3)",
          content: Column(
            children: [
              SearchBarComp(),
              SizedBox(height: 12),
              LoanDetailCard(
                LoanName:"Unnati this is the testing loan",
                LoanNo:"2496817092",
                LoanStatus:"Ongoing",
                LoanOverdueAmount:1024,
                LoanEMIAmount:1024,
                LoanTenure:36,
                LoanCollectionDay:"Thursday",
                LoanRejectReason:"Lorem Ipsum",
              ),
              SizedBox(height: 24),
              LoanDetailCard(
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
              LoanDetailCard(
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
                LoanDetailCard(
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

                LoanDetailCard(
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
                LoanDetailCard(
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
      body: SingleChildScrollView(
        child:       Container(
          child: Column(
            children: [
              GoBack(title: "Portfolio", onNavigate: widget.onNavigate),
              Row(
                children: [
                  TabComponent1(tabs1: tabs1),
                ],
              )
            ],
          ),
        ),
      )

    );
  }
}
