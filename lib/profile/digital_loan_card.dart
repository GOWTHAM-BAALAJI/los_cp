import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'user_details.dart';
import '../components/row_align_component.dart';
import '../components/company_address_footer.dart';

class InfoCard extends StatefulWidget {
  final String name;
  final String id;
  final String phone;
  final String guardian;
  final String insuranceCoveredFor;
  final String accidentalApplicant;
  final String accidentalPremium;
  final String disbursementDate;
  final String interestRate;
  final String lpf;
  final String loanRepayment;
  final String center;
  final String group;
  final String insurancePremium;
  final String loanAmount;

  const InfoCard({
    super.key,
    required this.name,
    required this.id,
    required this.phone,
    required this.guardian,
    required this.insuranceCoveredFor,
    required this.accidentalApplicant,
    required this.accidentalPremium,
    required this.disbursementDate,
    required this.interestRate,
    required this.lpf,
    required this.loanRepayment,
    required this.center,
    required this.group,
    required this.insurancePremium,
    required this.loanAmount,
  });
  @override
  InfoCardState createState() => InfoCardState();
}

class InfoCardState extends State<InfoCard> {
  ScreenshotController screenshotController = ScreenshotController();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
  }

  Future<void> _initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );
  }

  Future<void> _onNotificationTapped(NotificationResponse notificationResponse) async {
    String? filePath = notificationResponse.payload;

    if (filePath != null) {
      File file = File(filePath);
      if (await file.exists()) {
        OpenFile.open(filePath);
      }
    }
  }

  Future<void> _showNotification(String title, String message, String filePath) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'los_cp_channel_id',
      'LOS Customer Portal',
      channelDescription: 'Notifications for downloading digital loan card',
      importance: Importance.high,
      priority: Priority.high,
      showWhen: false,
    );

    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      message,
      platformChannelSpecifics,
      payload: filePath,
    );
  }

  Future<void> _captureAndSaveAsPDF() async {
    try {
      final image = await screenshotController.capture();
      if (image == null) return;
      final pdf = pw.Document();
      final pdfImage = pw.MemoryImage(image);

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Image(pdfImage, fit: pw.BoxFit.contain),
            );
          },
        ),
      );

      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/loan_card_${widget.id}.pdf';
      final file = File(filePath);
      await file.writeAsBytes(await pdf.save());

      await _showNotification(
        'Digital Loan Card - ${widget.name}',
        'PDF downloaded successfully!',
        filePath,
      );
    } catch (e) {
      print("Error saving PDF: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: widget.key,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 20, right: 30, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Digital Loan Card", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF2051E5), fontFamily: "Lato")),
                GestureDetector(
                  onTap: _captureAndSaveAsPDF,
                  child: Row(
                    children: [
                      Icon(
                        Icons.file_download_outlined,
                        size: 24,
                        color: Color(0xFFD97700),
                      ),
                      SizedBox(width: 8),
                      Text(
                        "Download",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF1E1E1E),
                          fontFamily: "Lato",
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Container(
          //   margin: EdgeInsets.all(16),
          //   decoration: BoxDecoration(
          //     border: Border.all(
          //       width: 1,
          //       color: Colors.transparent,
          //     ),
          //     borderRadius: BorderRadius.circular(10),
          //     gradient: LinearGradient(
          //       begin: Alignment.topCenter,
          //       end: Alignment.bottomCenter,
          //       colors: [Color(0xFFD97700), Color(0xFF2051E5)],
          //       stops: [0.0, 1.0],
          //     ),
          //   ),
          //   child: Card(
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(10),
          //     ),
          //     elevation: 1,
          //     margin: EdgeInsets.all(0),
          //     color: Color(0xFFFFFFFF),
          //     child: Column(
          //       children: [
          //         Padding(
          //           padding: const EdgeInsets.all(16.0),
          //           child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               Row(
          //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                 crossAxisAlignment: CrossAxisAlignment.center,
          //                 children: [
          //                   Image.asset(
          //                     'assets/images/spandana_logo.png',
          //                     width: 60,
          //                     height: 40,
          //                   ),
          //                   SizedBox(width: 60),
          //                   Flexible(
          //                     child: Column(
          //                       children: [
          //                         ProfileDetailItem(
          //                           label: 'Centre',
          //                           value: widget.center,
          //                         ),
          //                       ],
          //                     ),
          //                   ),
          //                   Container(
          //                     width: 1,
          //                     height: 40,
          //                     color: Color(0xFFD97700),
          //                   ),
          //                   Flexible(
          //                     child: Column(
          //                       children: [
          //                         ProfileDetailItem(
          //                           label: 'Group',
          //                           value: widget.group,
          //                         ),
          //                       ],
          //                     ),
          //                   ),
          //                   SizedBox(width: 10),
          //                 ],
          //               ),
          //             ],
          //           ),
          //         ),
          //         Container(
          //           width: double.infinity,
          //           height: 1,
          //           color: Color(0xFFD97700),
          //         ),
          //         Padding(
          //           padding: const EdgeInsets.all(16.0),
          //           child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               Text(
          //                 widget.name,
          //                 style: TextStyle(
          //                   fontSize: 16,
          //                   fontWeight: FontWeight.w700,
          //                   color: Color(0xFF2051E5),
          //                   fontFamily: "Lato",
          //                 ),
          //               ),
          //               SizedBox(height: 8),
          //               Row(
          //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                 children: [
          //                   Text(
          //                     "ID: ${widget.id}",
          //                     style: TextStyle(
          //                       fontSize: 12,
          //                       color: Color(0xFF101010),
          //                       fontFamily: "Lato",
          //                       fontWeight: FontWeight.w500,
          //                     ),
          //                   ),
          //                   Row(
          //                     children: [
          //                       Icon(Icons.phone, size: 16, color: Colors.orange),
          //                       SizedBox(width: 4),
          //                       Text(
          //                         widget.phone,
          //                         style: TextStyle(
          //                           fontSize: 12,
          //                           color: Color(0xFF101010),
          //                           fontFamily: "Lato",
          //                           fontWeight: FontWeight.w500,
          //                         ),
          //                       ),
          //                     ],
          //                   ),
          //                 ],
          //               ),
          //               SizedBox(height: 10),
          //               InfoRow(label: "W/O or D/O:", value: widget.guardian),
          //               InfoRow(label: "Insurance Covered For:", value: widget.insuranceCoveredFor),
          //               InfoRow(label: "Accidental Insurance Applicant Name:", value: widget.accidentalApplicant),
          //               InfoRow(label: "Accidental Insurance Premium:", value: "₹${widget.accidentalPremium}"),
          //               InfoRow(label: "Date of Disbursement:", value: widget.disbursementDate),
          //               InfoRow(label: "Interest Rate (%):", value: widget.interestRate),
          //               InfoRow(label: "LPF:", value: "₹${widget.lpf}"),
          //               InfoRow(label: "Loan Repayment Frequency:", value: widget.loanRepayment),
          //               SizedBox(height: 10),
          //               Row(
          //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                 children: [
          //                   Text(
          //                     "Insurance Premium: ₹${widget.insurancePremium}",
          //                     style: TextStyle(
          //                       fontSize: 12,
          //                       color: Color(0xFFD97700),
          //                       fontFamily: "Lato",
          //                       fontWeight: FontWeight.w700,
          //                     ),
          //                   ),
          //                   Container(
          //                     width: 1.5,
          //                     height: 30,
          //                     color: Color(0xFFD97700),
          //                   ),
          //                   Text(
          //                     "Loan Amount: ₹${widget.loanAmount}",
          //                     style: TextStyle(
          //                       fontSize: 12,
          //                       color: Color(0xFFD97700),
          //                       fontFamily: "Lato",
          //                       fontWeight: FontWeight.w700,
          //                     ),
          //                   )
          //                 ],
          //               ),
          //             ],
          //           ),
          //         ),
          //         Container(
          //           width: double.infinity,
          //           height: 1,
          //           color: Color(0xFFD97700),
          //         ),
          //         CompanyInfoWidget(
          //           companyName: 'Spandana Sphoorty Financial Limited',
          //           cinNumber: 'L65929TG2003PLC040648',
          //           address: 'Regd. Office: Plot No: 31 & 32, Ramky Selenium Towers, Tower A, Ground Floor, Financial Dist, Nanakramguda,\nHyderabad 500032',
          //           contact: '+91404812666',
          //           emailId: 'contact@spandanasphoorty.com',
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          Screenshot(
            controller: screenshotController,
            child: Container(
              margin: EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Colors.transparent,
                ),
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFD97700), Color(0xFF2051E5)],
                  stops: [0.0, 1.0],
                ),
              ),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 1,
                margin: EdgeInsets.all(0),
                color: Color(0xFFFFFFFF),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/spandana_logo.png',
                                width: 60,
                                height: 40,
                              ),
                              SizedBox(width: 60),
                              Flexible(
                                child: Column(
                                  children: [
                                    ProfileDetailItem(
                                      label: 'Centre',
                                      value: widget.center,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 1,
                                height: 40,
                                color: Color(0xFFD97700),
                              ),
                              Flexible(
                                child: Column(
                                  children: [
                                    ProfileDetailItem(
                                      label: 'Group',
                                      value: widget.group,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 10),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 1,
                      color: Color(0xFFD97700),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.name,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF2051E5),
                              fontFamily: "Lato",
                            ),
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "ID: ${widget.id}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF101010),
                                  fontFamily: "Lato",
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(Icons.phone, size: 16, color: Colors.orange),
                                  SizedBox(width: 4),
                                  Text(
                                    widget.phone,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF101010),
                                      fontFamily: "Lato",
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          InfoRow(label: "W/O or D/O:", value: widget.guardian),
                          InfoRow(label: "Insurance Covered For:", value: widget.insuranceCoveredFor),
                          InfoRow(label: "Accidental Insurance Applicant Name:", value: widget.accidentalApplicant),
                          InfoRow(label: "Accidental Insurance Premium:", value: "₹${widget.accidentalPremium}"),
                          InfoRow(label: "Date of Disbursement:", value: widget.disbursementDate),
                          InfoRow(label: "Interest Rate (%):", value: widget.interestRate),
                          InfoRow(label: "LPF:", value: "₹${widget.lpf}"),
                          InfoRow(label: "Loan Repayment Frequency:", value: widget.loanRepayment),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Insurance Premium: ₹${widget.insurancePremium}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFFD97700),
                                  fontFamily: "Lato",
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Container(
                                width: 1.5,
                                height: 30,
                                color: Color(0xFFD97700),
                              ),
                              Text(
                                "Loan Amount: ₹${widget.loanAmount}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFFD97700),
                                  fontFamily: "Lato",
                                  fontWeight: FontWeight.w700,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 1,
                      color: Color(0xFFD97700),
                    ),
                    CompanyInfoWidget(
                      companyName: 'Spandana Sphoorty Financial Limited',
                      cinNumber: 'L65929TG2003PLC040648',
                      address: 'Regd. Office: Plot No: 31 & 32, Ramky Selenium Towers, Tower A, Ground Floor, Financial Dist, Nanakramguda,\nHyderabad 500032',
                      contact: '+91404812666',
                      emailId: 'contact@spandanasphoorty.com',
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
