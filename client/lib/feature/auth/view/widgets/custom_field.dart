import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isObsecureText;
  const CustomField({
    super.key,
    required this.hintText,
    required this.controller,
    this.isObsecureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
      ),
      obscureText: isObsecureText,
    );
  }
}
