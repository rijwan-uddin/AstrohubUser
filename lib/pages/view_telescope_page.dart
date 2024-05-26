import 'package:astrohub_user/auth/auth_service.dart';
import 'package:astrohub_user/customwidgets/main_drawer.dart';
import 'package:astrohub_user/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../customwidgets/telescope_grid_item_view.dart';
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

        ],
      ),
      body: Consumer<TelescopeProvider>(
        builder: (context, provider ,child) => GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.8,
          ),
          itemCount: provider.telescopeList.length,
          itemBuilder: (context ,index){
            final telescope = provider.telescopeList[index];
            return TelescopeGridItemView(telescope: telescope);
          },
        ),
      ),
    );
  }
}
