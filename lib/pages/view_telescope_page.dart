import 'package:astrohub_user/auth/auth_service.dart';
import 'package:astrohub_user/customwidgets/main_drawer.dart';
import 'package:astrohub_user/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../providers/telescope_provider.dart';

class ViewTelescopePage extends StatefulWidget {
  static const String routeName = '/';

  const ViewTelescopePage({super.key});

  @override
  State<ViewTelescopePage> createState() => _ViewTelescopePageState();
}

class _ViewTelescopePageState extends State<ViewTelescopePage> {
  @override
  void didChangeDependencies() {
   Provider.of<TelescopeProvider>(context ,listen: false).getAllBrands();
   Provider.of<TelescopeProvider>(context ,listen: false).getAllTelescopes();

    super.didChangeDependencies();
  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
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
