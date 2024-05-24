import 'package:astrohub_user/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../auth/auth_service.dart';

class LoginSection extends StatefulWidget {
  final VoidCallback onSuccess;
  final Function(String) onFailure;
  const LoginSection({super.key, required this.onSuccess, required this.onFailure});

  @override
  State<LoginSection> createState() => _LoginSectionState();
}

class _LoginSectionState extends State<LoginSection> {

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  void initState() {
    _emailController.text = 'user1@gmail.com';
    _passwordController.text = '123456';
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: TextFormField(
              controller: _emailController,
              keyboardType:TextInputType.emailAddress ,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.email),
                labelText: 'Email Address',
              ),
              validator: (value){
                if(value == null || value.isEmpty){
                  return 'Provide a valid email address';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: TextFormField(
              controller: _passwordController,
             obscureText: true,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock),
                labelText: 'Password',
              ),
              validator: (value){
                if(value == null || value.isEmpty){
                  return 'Provide a Password ';
                }
                return null;
              },
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: _login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: kShrineBrown900,
                  foregroundColor: kShrineSurfaceWhite,
                ),
                child: Text('SIGN IN'),
            ),
          )
        ],
      ),

    );
  }

  void _login() async {
    if (_formKey.currentState!.validate()) {
      EasyLoading.show(status: 'Please wait');
      final email = _emailController.text;
      final password = _passwordController.text;

      try {
        await AuthService.login(email, password);
        EasyLoading.dismiss();
        widget.onSuccess();
      } on FirebaseAuthException catch (error) {
        EasyLoading.dismiss();
        widget.onFailure(error.message!);
      }
    }
  }
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
