import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../home_page.dart';
import 'forgot_password_page.dart';
import 'sign_up.dart';
import 'widgets/custom_textfield.dart';
import 'widgets/login_header.dart';
import 'widgets/auth_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  bool _obscurePassword = true;
  bool _isLoading = false;

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });

    final String apiUrl = "http://sandbox.spandanasphoorty.com:8080/api/cp/V1/loginDetails";
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

    final data = {
      "customerId": _customerIdController.text.trim(),
      "password": encodedPassword,
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
        await _secureStorage.write(key: "token", value: responseData["token"]);
        await _secureStorage.write(key: "customerId", value: _customerIdController.text);
        await _secureStorage.write(key: "isLogoutClicked", value: "false");

        if (_rememberMe) {
          await _secureStorage.write(key: "rememberMe", value: "true");
          String encodedPassword = base64Encode(utf8.encode(_passwordController.text.trim()));
          await _secureStorage.write(key: "password", value: encodedPassword);
        } else {
          await _secureStorage.delete(key: "rememberMe");
          await _secureStorage.delete(key: "password");
        }

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

  Map<String, String> _storedData = {};

  void initState() {
    super.initState();
    readAllValues();
    _loadCredentials();
  }

  Future<void> readAllValues() async {
    Map<String, String> allValues = await _secureStorage.readAll();

    setState(() {
      _storedData = allValues;
    });
  }

  Future<void> _loadCredentials() async {
    // String? token = await _secureStorage.read(key: 'token');
    // String? isLogoutClicked = await _secureStorage.read(key: 'isLogoutClicked');
    //
    // if (isLogoutClicked != 'true') {
    //   Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(builder: (context) => HomePage()),
    //   );
    //   return;
    // }

    String? savedcustomerId = await _secureStorage.read(key: 'customerId');
    String? savedPassword = await _secureStorage.read(key: 'password');
    String? rememberMeFlag = await _secureStorage.read(key: 'rememberMe');

    if (rememberMeFlag == 'true' && savedcustomerId != null && savedPassword != null) {
      setState(() {
        _customerIdController.text = savedcustomerId;
        _passwordController.text = utf8.decode(base64Decode(savedPassword));
        _rememberMe = true;
      });
    }
  }

  final _customerIdController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
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
                        Image.asset('assets/images/logo.png', height: 40),
                        const Text(
                          'Spandana',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.all(24),
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: const [
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
                              const LoginHeader(),
                              const SizedBox(height: 20),
                              CustomTextField(
                                label: "Customer ID",
                                hint: "Enter your User ID",
                                controller: _customerIdController,
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
                              _buildRememberMeRow(),
                              const SizedBox(height: 10),
                              AuthButton(
                                text: "Login",
                                onPressed: _login,
                                isLoading: _isLoading,
                              ),
                              _buildSignUpLink(),
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
      ),
    );
  }

  Widget _buildRememberMeRow() {
    return Row(
      children: [
        Checkbox(
          value: _rememberMe,
          onChanged: (bool? value) => setState(() => _rememberMe = value ?? false),
        ),
        const Text(
          "Remember Me?",
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1E1E1E),
          ),
        ),
        const Spacer(),
        TextButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ForgotPasswordPage()),
          ),
          child: const Text(
            "Forgot Password?",
            style: TextStyle(
              color: Color(0xFF2051E5),
              fontSize: 10,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSignUpLink() {
    return TextButton(
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const SignUpPage()),
      ),
      child: const Text(
        "Don't have an account? Sign up.",
        style: TextStyle(
          color: Color(0xFF2051E5),
          fontSize: 10,
        ),
      ),
    );
  }
}