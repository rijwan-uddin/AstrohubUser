import 'package:flutter/material.dart';

class LoginSection extends StatefulWidget {
  final VoidCallback onSuccess;
  final Function(String) onFailure;
  const LoginSection({super.key, required this.onSuccess, required this.onFailure});

  @override
  State<LoginSection> createState() => _LoginSectionState();
}

class _LoginSectionState extends State<LoginSection> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
