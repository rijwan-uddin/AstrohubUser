import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            color: Theme.of(context).colorScheme.primary,
            height: 145,
          ),
          ListTile(
            onTap: (){


            },
            leading: Icon(Icons.person),
            title: Text('My Profile'),
          )
        ],
      ),
    );
  }
}
