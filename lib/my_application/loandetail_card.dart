import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: loanDetailCard(),
    );
  }
}

class loanDetailCard extends StatefulWidget {
  const loanDetailCard({super.key});

  @override
  State<loanDetailCard> createState() => _loanDetailCardState();
}

class _loanDetailCardState extends State<loanDetailCard> {
  @override
  Widget build(BuildContext context) {

    String LoanName = "Unnati";
    String LoanNo = "3496817092";
    String LoanStatus = "Completed";
    num overdueAmount = 1234.5;
    num LoanEMIAmount = 1024;
    num LoanTenure = 36;
    String LoanCollectionDay = "Thursday";
    String LoanRejectReason = "Lorem Ipsum";

    Color statusColor;

    if (LoanStatus == "Ongoing") {
      statusColor = Color(0xFFD97700);
    } else if (LoanStatus == "Completed") {
      statusColor = Color(0xFF3F7D20);
    } else if (LoanStatus == "Rejected") {
      statusColor = Color(0xFFB90000);
    } else {
      statusColor = Colors.grey; // Default color if status is unknown
    }



    return Scaffold(
      body: Center(
        child: Container(
          width: 328,
          height: LoanStatus=="Rejected"?167:149,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: statusColor,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,

            children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 8,
                        children: [
                          Container(

                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0xFFF9FAFB),
                            ),
                            child: Center(  // Center the image within the container
                              child: Image.asset(
                                'assets/images/loanimg.png',
                                height: 24,
                                width: 24,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Container(
                            child:Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(LoanName,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      height: 16.8/14
                                  ),
                                ),
                                Text(LoanNo,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF636363)
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            spacing: 8,
                            children: [
                              Container(
                                height: 10,
                                width: 10,
                                child:
                                Image.asset("assets/images/${LoanStatus}img.png",
                                  height: 10,
                                  width: 10,
                                ),

                              ),
                              Text(LoanStatus,
                                style: TextStyle(
                                  color: statusColor,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 10,
                                  height: 12/10,
                                ),
                              )
                            ],
                          ),
                          Container(

                            padding: EdgeInsets.all(4),
                            margin: EdgeInsets.only(top:4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: statusColor,
                              ),
                            ),
                            child: overdueAmount > 0 ? Text("OD of ${overdueAmount}", style: TextStyle(fontSize: 10,height: 12/10, fontWeight: FontWeight.w700,color: statusColor)) : SizedBox.shrink(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 12),
                    child:Divider(height: 1, color: statusColor,),
                  )

                ],
              ),

              SizedBox(height: 16,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 10,
                    children: [
                      Text("EMI Amount",style: TextStyle(color: Color(0xFF636363),fontSize: 12,height: 14.4/12,fontWeight: FontWeight.w500),),
                      Text("₹${LoanEMIAmount}",style: TextStyle(color: Color(0xFF101828),fontSize: 12,fontWeight: FontWeight.w600,height: 14.4/12))
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 10,
                    children: [
                      Text("Tenure",style: TextStyle(color: Color(0xFF636363),fontSize: 12,height: 14.4/12,fontWeight: FontWeight.w500),),
                      Text("${LoanTenure}weeks",style: TextStyle(color: Color(0xFF101828),fontSize: 12,fontWeight: FontWeight.w600,height: 14.4/12))
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 10,
                    children: [
                      Text("Collection day",style: TextStyle(color: Color(0xFF636363),fontSize: 12,height: 14.4/12,fontWeight: FontWeight.w500),),
                      Text("${LoanCollectionDay}",style: TextStyle(color: Color(0xFF101828),fontSize: 12,fontWeight: FontWeight.w600,height: 14.4/12))
                    ],
                  ),
                ],
              ),

              LoanStatus=="Rejected"?Column(children: [SizedBox(height: 12,),Row(
                children: [
                  Text("Reason: ",style: TextStyle(height: 14.4/12,fontWeight: FontWeight.w500,fontSize: 12,color: Color(0xFF636363))),
                  Text(LoanRejectReason,style: TextStyle(height: 14.4/12,fontWeight: FontWeight.w400,fontSize: 12,color: Color(0xFF101828)))
                ],
              )],):SizedBox.shrink(),

            ],
          ),
        ),
      ),
    );
  }
}
