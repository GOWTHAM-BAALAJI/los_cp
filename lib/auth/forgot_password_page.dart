import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'login_page.dart';
import 'widgets/custom_textfield.dart';
import 'widgets/login_header.dart';
import 'widgets/auth_button.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _customerIdController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

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

  Future<void> _resetPassword() async {
    setState(() {
      _isLoading = true;
    });

    final String apiUrl = "http://sandbox.spandanasphoorty.com:8080/api/cp/V1/forgetPasswordDetails";
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
        SnackBar(content: Text("New Password cannot be empty.")),
      );
      setState(() {
        _isLoading = false;
      });
      return;
    }

    final data = {
      "customerId": _customerIdController.text.trim(),
      "newPassword": encodedPassword,
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Successfully Changed the Password"),
            backgroundColor: Colors.green,
          ),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
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

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final keyboardHeight = mediaQuery.viewInsets.bottom;

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
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
                            LoginHeader(
                              title: "Forgot Password",
                              subtitle: "Reset your account password",
                            ),
                            const SizedBox(height: 20),
                            CustomTextField(
                              label: "Customer ID",
                              hint: "Enter your User ID",
                              controller: _customerIdController,
                              isRequired: true,
                            ),
                            const SizedBox(height: 20),
                            CustomTextField(
                              label: "New Password",
                              hint: "Enter your new password",
                              controller: _passwordController,
                              isRequired: true,
                              isPassword: true,
                              obscureText: _obscurePassword,
                              onPasswordToggle: () => setState(() => _obscurePassword = !_obscurePassword),
                            ),
                            const SizedBox(height: 30),
                            AuthButton(
                              text: "Save",
                              onPressed: _resetPassword,
                              isLoading: _isLoading,
                            ),
                            TextButton(
                                onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (_) => const LoginPage())
                                ),
                                child: const Text(
                                    "Back to Login",
                                    style: TextStyle(
                                        color: Color(0xFF2051E5),
                                        fontSize: 10
                                    )
                                )
                            )
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