import 'package:flutter/material.dart';
import 'login_page.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

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
              ? constraints.maxHeight * 0.3 // Reduce height when keyboard is open
              : constraints.maxHeight * 0.4;

          return Stack(
            children: [
              Container(
                height: containerHeight,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.blue.shade800, // Background color
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
                              "Forgot Password",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF090A0A),
                                height: 36 / 24,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20),
                            _buildTextField("Customer ID", "Enter your User ID", _customerIdController),
                            const SizedBox(height: 20),
                            _buildPasswordField(),
                            const SizedBox(height: 30),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 60),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange,
                                  disabledBackgroundColor: Colors.grey,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: _resetPassword,
                                child: const Text(
                                  "Save",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            TextButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginPage())), child: const Text("Back to Login", style: TextStyle(color: Color(0xFF2051E5), fontSize: 10)))
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
  Widget _buildTextField(String label, String hint, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(children: [TextSpan(text: '$label ', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Color(0xFF636363))), const TextSpan(text: '*', style: TextStyle(fontSize: 12, color: Colors.red))]),
        ),
        const SizedBox(height: 5),
        TextField(controller: controller, decoration: InputDecoration(hintText: hint, border: const OutlineInputBorder())),
      ],
    );
  }

  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(children: [const TextSpan(text: 'Password ', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Color(0xFF636363))), const TextSpan(text: '*', style: TextStyle(fontSize: 12, color: Colors.red))]),
        ),
        const SizedBox(height: 5),
        TextField(
          controller: _passwordController,
          obscureText: _obscurePassword,
          decoration: InputDecoration(
            hintText: 'Enter your new password',
            border: const OutlineInputBorder(),
            suffixIcon: IconButton(
              icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
              onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
            ),
          ),
        ),
      ],
    );
  }
}
