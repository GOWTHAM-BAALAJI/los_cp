import 'package:flutter/material.dart';
import '../components/otp.dart';
import '../home_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _userIdController = TextEditingController();
  final _dobController = TextEditingController();
  final _mobileController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isOtpVerified = false;

  void showOtpModal() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return OtpScreen(
          onOtpVerified: () {
            setState(() {
              _isOtpVerified = true; // Update UI when OTP is verified
            });
            Navigator.pop(context); // Close OTP dialog
          },
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
          double containerHeight = keyboardHeight > 0
              ? constraints.maxHeight * 0.3
              : constraints.maxHeight * 0.4;

          return Stack(
            children: [
              Container(
                height: containerHeight,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.blue.shade800,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
              ),
              Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      Image.asset(
                        'assets/images/logo.png',
                        height: 40,
                      ),
                      const Text(
                        'Spandana',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.all(24),
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Text(
                              "Create an account.",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF090A0A),
                                height: 36 / 24,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      const TextSpan(
                                        text: 'User ID',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            height: 14.4 / 12,
                                            color: Color(0xFF636363)
                                        ),
                                      ),
                                      TextSpan(
                                        text: ' *', // Asterisk symbol
                                        style: TextStyle(fontSize: 12,
                                            color: Colors.red), // Red asterisk
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 5),
                                SizedBox(
                                  width: 295,
                                  height: 40,
                                  child: Center(
                                    child: TextField(
                                      controller: _userIdController,
                                      decoration: const InputDecoration(
                                        hintText: 'Enter your User ID',
                                        hintStyle: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          height: 20 / 12,
                                        ),
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      const TextSpan(
                                        text: 'Date of Birth',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            height: 14.4 / 12,
                                            color: Color(0xFF636363)
                                        ),
                                      ),
                                      TextSpan(
                                        text: ' *',
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.red),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 5),
                                SizedBox(
                                  width: 295,
                                  height: 40,
                                  child: Center(
                                    child: TextField(
                                      controller: _dobController,
                                      decoration: InputDecoration(
                                        hintText: 'DD/MM/YY',
                                        hintStyle: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          height: 20 / 12,
                                        ),
                                        border: const OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      const TextSpan(
                                        text: 'Mobile Number',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            height: 14.4 / 12,
                                            color: Color(0xFF636363)
                                        ),
                                      ),
                                      TextSpan(
                                        text: ' *',
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.red),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 5),
                                SizedBox(
                                  width: 295,
                                  height: 40,
                                  child: Center(
                                    child: TextField(
                                      controller: _mobileController,
                                      decoration: InputDecoration(
                                        hintText: 'Enter your mobile number',
                                        hintStyle: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          height: 20 / 12,
                                        ),
                                        border: const OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),

                              ],
                            ),
                            if(_isOtpVerified) ...[
                              Text.rich(
                                TextSpan(
                                  children: [
                                    const TextSpan(
                                      text: 'Password',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          height: 14.4 / 12,
                                          color: Color(0xFF636363)
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' *',
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.red),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 5),
                              SizedBox(
                                width: 295,
                                height: 40,
                                child: Center(
                                  child: TextField(
                                    controller: _passwordController,
                                    obscureText: true,  // Hide the password
                                    decoration: InputDecoration(
                                      hintText: 'Enter your password',
                                      hintStyle: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        height: 20 / 12,
                                      ),
                                      border: const OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    const TextSpan(
                                      text: 'Confirm Password',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          height: 14.4 / 12,
                                          color: Color(0xFF636363)
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' *',
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.red),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 5),
                              SizedBox(
                                width: 295,
                                height: 40,
                                child: Center(
                                  child: TextField(
                                    controller: _confirmPasswordController,
                                    obscureText: true,  // Hide the password
                                    decoration: InputDecoration(
                                      hintText: 'Confirm your password',
                                      hintStyle: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        height: 20 / 12,
                                      ),
                                      border: const OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                            ],
                            if(!_isOtpVerified) ...[
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
                                  onPressed: () {
                                    showOtpModal();
                                  },
                                  child: const Text("Verify Number", style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      height: 16.8 / 14)),
                                ),
                              ),
                            ] else ...[
                              const SizedBox(height: 20),
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
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (context) => HomePage()),
                                    );
                                  },
                                  child: const Text("Submit", style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      height: 16.8 / 14)),
                                ),
                              ),
                            ],
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  "Already have an account? Log in!",
                                  style: TextStyle(
                                    color: Color(0xFF2051E5),
                                    fontSize: 10,
                                    height: 12 / 10,
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
