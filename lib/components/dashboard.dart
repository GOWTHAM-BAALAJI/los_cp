import 'dart:convert';
import 'package:flutter/material.dart';
import 'eligibleCard.dart';
import 'upcomingTaskWidget.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../my_application/applicationScreen.dart';

class DashboardScreen extends StatefulWidget {
  final String userName;
  final Function(int)? onNavigate;

  const DashboardScreen({
    Key? key,
    required this.userName,
    this.onNavigate,
  }) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Map<String, dynamic>? responseData;
  bool isLoading = true;
  final _storage = FlutterSecureStorage();
  final PageController _pageController = PageController();
  int _currentPage = 0;
  double progressValue = 0.3;

  String _formatDate(String? dateString) {
    if (dateString == null) return '';
    try {
      final date = DateTime.parse(dateString);
      return '${date.day.toString().padLeft(2, '0')}-'
          '${date.month.toString().padLeft(2, '0')}-'
          '${date.year}';
    } catch (e) {
      return '';
    }
  }

  Future<void> _loadData() async {
    String? jsonData = await _storage.read(key: 'api_response');

    if (jsonData != null) {
      Map<String, dynamic> data = jsonDecode(jsonData);

      if (data.containsKey("customerDetails") && data["customerDetails"].isNotEmpty) {
        setState(() {
          responseData = data;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        isLoading = false;
      });
    });
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome ${responseData?["customerDetails"]?[0]?["CustomerName"] ?? ""}!',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    height: 24/20,
                  ),
                ),
                const SizedBox(height: 20),

                SizedBox(
                  height: 156,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: 3,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.only(right: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            image: DecorationImage(
                              image: AssetImage('assets/images/banner${index + 1}.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (index) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: _currentPage == index ? 8 : 6,
                      height: _currentPage == index ? 8 : 6,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: _currentPage != index ? Border.all(color: Colors.grey) : Border.all(color: Colors.blue),
                        color: _currentPage == index ? Colors.blue : Colors.transparent,
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'My Portfolio',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        height: 24/16,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        if (widget.onNavigate != null) {
                          widget.onNavigate!(1);
                        }
                      },
                      child: const Text(
                        'View All',
                        style: TextStyle(
                            fontSize: 12,
                            color: Color(0xff2051E5),
                            height: 14.4/12
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // Application status card
                SizedBox(
                  height: 140,
                  child: Container(
                    color: Colors.white,
                    child: Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xffD97700), Color(0xff2051E5)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  _buildStatusItem('${responseData?['loanDetails']?.where((loan) => loan['loanStatus'] == 'Active' || loan['loanStatus'] == 'Ongoing').length ?? 0}', 'In-progress', Color(0xff2051e5)),
                                  Container(
                                    height: 70,
                                    width: 1,
                                    color: Colors.grey,
                                    margin: const EdgeInsets.symmetric(horizontal: 8),
                                  ),
                                  _buildStatusItem('${responseData?['loanDetails']?.length ?? 0}', 'Disbursed', Color(0xff00916e)),
                                  Container(
                                    height: 70,
                                    width: 1,
                                    color: Colors.grey,
                                    margin: const EdgeInsets.symmetric(horizontal: 10),
                                  ),
                                  _buildStatusItem('${responseData?['loanDetails']?.where((loan) => loan['loanStatus'] == 'Rejected').length ?? 0}', 'Rejected', Color(0xFFD97700)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Upcoming Task',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    height: 24/16,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${(progressValue * 100).toStringAsFixed(0)}% Completed',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        UpcomingTaskWidget(
                          progressValue: progressValue,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Dynamic Collection Cards
                if (responseData != null && responseData!['loanDetails'] != null)
                  ...responseData!['loanDetails']
                      .where((loan) => loan['loanStatus'] == 'Active' || loan['loanStatus'] == 'Ongoing')
                      .map((loan) => Column(
                    children: [
                      CollectionCardWidget(
                        heading: loan == responseData!['loanDetails'].first ? 'Collections' : '',
                        title: loan['productName'] ?? '',
                        id: loan['loanDisplayId'].toString(),
                        status: loan['loanStatus'] == 'Active' ? 'Ongoing' : loan['loanStatus'],
                        overdueAmount: (loan['overdueAmount'] ?? 0).toDouble(),
                        emiAmount: (loan['emiAmount'] ?? 0).toDouble(),
                        emidate: loan['repaymentSchedule']?.isNotEmpty ?? false
                            ? _formatDate(loan['repaymentSchedule'][0]['installmentDate'])
                            : '',
                        statusLoan: loan['loanStatus'] ?? '',
                      ),
                      const SizedBox(height: 10),
                    ],
                  ))
                      .toList(),

                const SizedBox(height: 20),
                const Text(
                  'Eligible Loan',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    height: 24/16,
                  ),
                ),
                const SizedBox(height: 20),
                EligibleLoanCard(
                  imagePath: 'assets/images/cd.png',
                  title: 'Consumer Durables',
                  duration: '12 months',
                  price: '10,000',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusItem(String number, String status, Color color) {
    return Expanded(
      child: Column(
        children: [
          Text(
            number,
            style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w600,
                color: color,
                height: 38.4/32
            ),
          ),
          const SizedBox(height: 4),
          Text(
            status,
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                height: 14.4/12
            ),
          ),
        ],
      ),
    );
  }
}