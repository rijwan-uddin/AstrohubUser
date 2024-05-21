import 'package:astrohub_user/utils/colors.dart';
import 'package:flutter/material.dart';

enum AuthChoice { login, register }

class LoginPage extends StatefulWidget {
  static const String routeName = '/login';

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _errMsg = '';
  AuthChoice _authChoice = AuthChoice.login;

  @override
  void initState() {
    _emailController.text = 'user1gmail.com';
    _passwordController.text = '123456';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(24.0),
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                  'Welcome User',
                  style: Theme.of(context).textTheme.headlineLarge,
                  textAlign: TextAlign.center,
                ),
              ),
              SegmentedButton<AuthChoice>(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith((states) {
                    if (states.contains(MaterialState.selected)) {
                      return kShrineBrown900;
                    }
                    return null;
                  }),
                  foregroundColor: MaterialStateColor.resolveWith((states) {
                    if (states.contains(MaterialState.selected)) {
                      return kShrineSurfaceWhite;
                    }
                    return kShrineBrown900;
                  }),
                  shape: MaterialStateProperty.resolveWith((states) {
                    return RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0));
                  }),
                ),
                showSelectedIcon: false,
                segments: const [
                  ButtonSegment<AuthChoice>(
                    value: AuthChoice.login,
                    label: Text('Login'),
                  ),
                  ButtonSegment<AuthChoice>(
                    value: AuthChoice.register,
                    label: Text('Register'),
                  ),
                ],
                selected: {_authChoice},
                onSelectionChanged: (choice){
                  setState(() {
                    _authChoice = choice.first;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
