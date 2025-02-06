import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OtpScreen extends StatefulWidget {
  final String loanReferenceID;
  final VoidCallback onOtpVerified;

  const OtpScreen({
    Key? key,
    required this.loanReferenceID,
    required this.onOtpVerified,
  }) : super(key: key);
  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController otpController = TextEditingController();
  int _timerSeconds = 80;
  late Timer _timer;
  bool _isResendEnabled = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (_timerSeconds > 0) {
        setState(() {
          _timerSeconds--;
        });
      } else {
        setState(() {
          _isResendEnabled = true;
          _timer.cancel();
        });
      }
    });
  }

  void _resendOtp() {
    setState(() {
      _timerSeconds = 80;
      _isResendEnabled = false;
    });
    _startTimer();
  }



  void _verifyOtp() async {
    setState(() {
      _isLoading = true;
    });

    final String apiUrl = "http://sandbox.spandanasphoorty.com:8080/api/cp/V1/verifyOtp";  // Update with your actual API URL
    final String authorization = "c3BhbmRhbmE6U3BhbmRhbmFAMjAyMyM=";

    final data = {
      "loan_id": 347297497,
      "otpPin": otpController.text.trim(),
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Authorization": "Basic $authorization",
          "Content-Type": "application/json",
        },
        body: jsonEncode(data),
      );

      final responseData = jsonDecode(response.body);
      print("Response: $responseData");
      print("Status Code: ${response.statusCode}");


      if (responseData['resObject']['ResponseCode'] == '001' || responseData['resObject']['ResponseCode'] == '000') {
        widget.onOtpVerified();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Invalid OTP, please try again")),
        );
      }
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An error occurred. Please try again.")),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }


  String maskMobileNumber(String number) {
    return '${number.substring(0, 2)}****${number.substring(number.length - 4)}';
  }


  @override
  void dispose() {
    if (mounted) {
      otpController.dispose();
    }

    if (_timer.isActive) {
      _timer.cancel();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        title: Column(
          children: [
            Text(
              "Generate OTP",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
                fontFamily: "Lato",
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Please enter the OTP sent to mobile number",
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFF1E1E1E),
                fontWeight: FontWeight.w600,
                fontFamily: "Lato",
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${maskMobileNumber(widget.loanReferenceID)}",
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF1E1E1E),
                    fontWeight: FontWeight.w600,
                    fontFamily: "Lato",
                  ),
                ),
                SizedBox(width: 4),
              ],
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            PinCodeTextField(
              appContext: context,
              length: 4,
              controller: otpController,
              keyboardType: TextInputType.number,
              textStyle: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                fontFamily: "Lato",
                color: Color(0xFF373D3F),
              ),
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(4),
                fieldHeight: 38,
                fieldWidth: 39,
                activeFillColor: Colors.white,
                selectedFillColor: Colors.white,
                inactiveFillColor: Colors.white,
                activeColor: Color(0xFF4E4E4E),
                selectedColor: Color(0xFF4E4E4E),
                inactiveColor: Color(0xFFC3C3C3),
                borderWidth: 1.0,
              ),
              cursorColor: Colors.black,
              enableActiveFill: true,
              onChanged: (value) {},
            ),
            SizedBox(height: 20),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: _isResendEnabled
                    ? GestureDetector(
                  onTap: _resendOtp,
                    child: Center(
                        child: Text(
                          "Re-Send",
                          style: TextStyle(
                            color: Color(0xFF2051E5),
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Lato",
                          ),
                        )
                    ),

                )
                    : Padding(
                  padding: EdgeInsets.only(right: 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Re-Send",
                        style: TextStyle(
                          color: Color(0xFF969696),
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Lato",
                        ),
                      ),
                      Text(
                        " (${_timerSeconds ~/ 60}:${(_timerSeconds % 60).toString()})",
                        style: TextStyle(
                          color: Color(0xFF1E1E1E),
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Lato",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 60),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xffff9021),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: _verifyOtp,
                child: const Text("Verify OTP", style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    height: 16.8 / 14)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
