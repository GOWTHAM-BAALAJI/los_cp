import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'components/bottomnavigation.dart';
import 'components/profileAppBar.dart';
import 'dart:async';
import 'auth/login_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _storage = FlutterSecureStorage();
  int _selectedIndex = 0;

  String? customerName;
  int? customerId;
  String? district;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final url = Uri.parse('https://apiuat.spandanasphoorty.com/crm/api/getdetails');

    final headers = {
      'Content-Type': 'application/json',
      'client_id': '0534da59ff1647d491a46d2f31378895',
      'client_secret': 'abA1dFdD41E245EDADC77CA8d1A75a7F',
    };

    final body = jsonEncode({'customerId': 4001});

    try {
      final response = await http
          .post(url, headers: headers, body: body)
          .timeout(Duration(seconds: 60));

      if (response.statusCode == 200) {
        await _storage.write(key: 'api_response', value: response.body);
        print("Data stored securely.");
        _loadData();
      } else {
        print("Failed to fetch data: ${response.statusCode}");
      }
    } on TimeoutException catch (_) {
      print("Connection timeout. Please try again later.");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Connection timeout. Please try again later.")),
      );

      Future.delayed(Duration(seconds: 2), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      });
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  Future<void> _loadData() async {
    String? jsonData = await _storage.read(key: 'api_response');

    if (jsonData != null) {
      Map<String, dynamic> data = jsonDecode(jsonData);

      if (data.containsKey("customerDetails") && data["customerDetails"].isNotEmpty) {
        setState(() {
          customerName = data["customerDetails"][0]["CustomerName"];
          customerId = data["customerDetails"][0]["CustomerId"];
          district = data["customerDetails"][0]["District"];
        });
      }
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProfileAppBar(
        name: customerName ?? "Loading...",
        id: customerId?.toString() ?? "Loading...",
        location: district ?? "Loading...",
      ),
      body: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
