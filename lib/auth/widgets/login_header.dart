import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const LoginHeader({
    Key? key,
    this.title = 'Welcome back.',
    this.subtitle = 'Log in to your account',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Color(0xFF090A0A),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 5),
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xFF939598),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}