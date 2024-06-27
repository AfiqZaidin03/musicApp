import 'package:client/feature/auth/view/widgets/custom_field.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Text(
              'Sign Up.',
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            CustomField(
              hintText: 'Name',
            ),
            const SizedBox(height: 15),
            CustomField(
              hintText: 'Email',
            ),
            const SizedBox(height: 15),
            CustomField(
              hintText: 'Password',
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
