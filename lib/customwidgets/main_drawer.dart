import 'package:astrohub_user/auth/auth_service.dart';
import 'package:astrohub_user/pages/my_order.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../pages/cart_page.dart';
import '../pages/login_page.dart';
import '../pages/user_profile.dart';

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
              context.pop();
              context.goNamed(UserProfilePage.routeName);
            },
            leading: Icon(Icons.person),
            title: Text('My Profile'),
          ),
         ListTile(
            onTap: (){
              context.pop();
            context.goNamed(CartPage.routeName);

            },
            leading: Icon(Icons.add_shopping_cart),
            title: Text('My Cart'),
          ),
          ListTile(
            onTap: (){
              context.pop();
              context.goNamed(OrderPage.routeName);
            },
            leading: Icon(Icons.monetization_on),
            title: Text('My Orders'),
          ),
          ListTile(
            onTap: (){
              AuthService.logout()
                  .then((value) => context.goNamed(LoginPage.routeName));
            },
            leading: Icon(Icons.logout),
            title: Text('Sign Out'),
          ),
        ],
      ),
    );
  }
}
