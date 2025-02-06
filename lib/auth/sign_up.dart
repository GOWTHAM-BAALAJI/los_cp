import 'package:flutter/material.dart';
import '../components/otp.dart';
import '../home_page.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'widgets/custom_textfield.dart';
import 'widgets/login_header.dart';
import 'widgets/auth_button.dart';
import 'login_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _customerIdController = TextEditingController();
  final _dobController = TextEditingController();
  final _mobileController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _isOtpVerified = false;

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Error"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _signUp() async {
    setState(() {
      _isLoading = true;
    });

    final String apiUrl = "http://sandbox.spandanasphoorty.com:8080/api/cp/V1/singup";
    final String authorization = "c3BhbmRhbmE6U3BhbmRhbmFAMjAyMyM=";
    String encodedPassword = base64Encode(utf8.encode(_passwordController.text.trim()));

    print("user Id Password");
    print(_customerIdController.text.trim());
    print(encodedPassword);
    if (_customerIdController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Customer Id cannot be empty")),
      );
      setState(() {
        _isLoading = false;
      });
      return;
    }
    if (_passwordController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Password cannot be empty.")),
      );
      setState(() {
        _isLoading = false;
      });
      return;
    }
    if (_confirmPasswordController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Confirm Password cannot be empty.")),
      );
      setState(() {
        _isLoading = false;
      });
      return;
    }
    if (_confirmPasswordController != _passwordController) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Password and Confirm Password does not match")),
      );
      setState(() {
        _isLoading = false;
      });
      return;
    }


    final data = {
      "customerId": _customerIdController.text.trim(),
      "password": encodedPassword,
      "dob": _dobController.text.trim(),
      "mobileNumber": _mobileController.text.trim()
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

      if (responseData['status']['code'] == '000') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        _showErrorDialog("Login failed: ${responseData['status']['message']}");
      }
    } catch (e) {
      print("Error: $e");
      _showErrorDialog("An error occurred. Please try again.");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void showOtpModal() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return OtpScreen(
          mobileNumber: _mobileController.text.trim(),
          onOtpVerified: () {
            setState(() {
              _isOtpVerified = true;
            });
            Navigator.pop(context);
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
              : constraints.maxHeight * 0.5;

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
                            const LoginHeader(
                              title: "Create an account",
                              subtitle: "Sign up to get started",
                            ),
                            const SizedBox(height: 20),
                            if (!_isOtpVerified) ...[
                              CustomTextField(
                                label: "Mobile Number",
                                hint: "Enter your mobile number",
                                controller: _mobileController,
                                isRequired: true,
                              ),
                              const SizedBox(height: 20),
                              AuthButton(
                                text: "Verify Number",
                                onPressed: showOtpModal,
                                backgroundColor: Color(0xffff9021),
                              ),
                            ] else ...[
                              CustomTextField(
                                label: "User ID",
                                hint: "Enter your User ID",
                                controller: _customerIdController,
                                isRequired: true,
                              ),
                              const SizedBox(height: 20),
                              CustomTextField(
                                label: "Date of Birth",
                                hint: "DD/MM/YY",
                                controller: _dobController,
                                isRequired: true,
                              ),
                              const SizedBox(height: 20),
                              CustomTextField(
                                label: "Password",
                                hint: "Enter your password",
                                controller: _passwordController,
                                isRequired: true,
                                isPassword: true,
                                obscureText: _obscurePassword,
                                onPasswordToggle: () => setState(() => _obscurePassword = !_obscurePassword),
                              ),
                              const SizedBox(height: 20),
                              CustomTextField(
                                label: "Confirm Password",
                                hint: "Confirm your password",
                                controller: _confirmPasswordController,
                                isRequired: true,
                                isPassword: true,
                                obscureText: _obscurePassword,
                                onPasswordToggle: () => setState(() => _obscurePassword = !_obscurePassword),
                              ),
                              const SizedBox(height: 20),
                              AuthButton(
                                text: "Register",
                                onPressed: _signUp,
                                isLoading: _isLoading,
                                backgroundColor: Color(0xffff9021),
                              ),
                            ],
                            TextButton(
                              onPressed: () => Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (_) => const LoginPage())
                              ),
                              child: const Text(
                                "Already have an account? Log in!",
                                style: TextStyle(
                                  color: Color(0xFF2051E5),
                                  fontSize: 10,
                                ),
                              ),
                            ),
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