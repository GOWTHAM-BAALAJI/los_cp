import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OTPLoginScreen extends StatefulWidget {
  @override
  _OTPLoginScreenState createState() => _OTPLoginScreenState();
}

class _OTPLoginScreenState extends State<OTPLoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  String? verificationId;

  Future<void> sendOTP() async {
    await _auth.verifyPhoneNumber(
      phoneNumber: "+91${_phoneController.text}",  // Change country code as needed
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Auto verification successful!")),
        );
      },
      verificationFailed: (FirebaseAuthException e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Verification failed: ${e.message}")),
        );
      },
      codeSent: (String verId, int? resendToken) {
        setState(() {
          verificationId = verId;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("OTP Sent!")),
        );
      },
      codeAutoRetrievalTimeout: (String verId) {
        verificationId = verId;
      },
      timeout: Duration(seconds: 60),
    );
  }

  Future<void> verifyOTP() async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId!,
        smsCode: _otpController.text.trim(),
      );

      UserCredential userCredential = await _auth.signInWithCredential(credential);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("OTP Verified! User: ${userCredential.user!.phoneNumber}")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Invalid OTP!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Phone OTP Login")),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: "Phone Number"),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: sendOTP,
              child: Text("Send OTP"),
            ),
            TextField(
              controller: _otpController,
              decoration: InputDecoration(labelText: "Enter OTP"),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: verifyOTP,
              child: Text("Verify OTP"),
            ),
          ],
        ),
      ),
    );
  }
}
