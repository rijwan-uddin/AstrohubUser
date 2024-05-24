import 'package:astrohub_user/auth/auth_service.dart';
import 'package:astrohub_user/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ViewTelescopePage extends StatefulWidget {
  static const String routeName = '/';

  const ViewTelescopePage({super.key});

  @override
  State<ViewTelescopePage> createState() => _ViewTelescopePageState();
}

class _ViewTelescopePageState extends State<ViewTelescopePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Telescopes '),
        actions: [
          IconButton(
            onPressed: () {
              AuthService.logout()
                  .then((value) => context.goNamed(LoginPage.routeName));
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
    );
  }
}
