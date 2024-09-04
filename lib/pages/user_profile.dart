import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import 'package:astrohub_user/providers/user_provider.dart';
import 'package:astrohub_user/utils/widget_functions.dart';

class UserProfilePage extends StatelessWidget {
  static const String routeName = 'profile';

  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('My Profile'),
      ),
      body: ListView(
        children: [
          _headerSection(context, userProvider),
          ListTile(
            leading: const Icon(Icons.call),
            title: Text(userProvider.appUser?.phone ?? 'Not set yet'),
            trailing: IconButton(
              onPressed: () {
                showSingleTextInputDialog(
                  context: context,
                  title: 'Update Mobile No',
                  onSubmit: (input) async {
                    await userProvider.updateUserProfile(field: 'phone', value: input);
                  },
                );
              },
              icon: const Icon(Icons.edit),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.streetview),
            title: Text(userProvider.appUser?.userAddress?.streetAddress ??
                'Not set yet'),
            subtitle: const Text('Street Address'),
            trailing: IconButton(
              onPressed: () {
                showSingleTextInputDialog(
                  context: context,
                  title: 'Update Street Address',
                  onSubmit: (input) async {
                    await userProvider.updateUserProfile(field: 'userAddress.streetAddress', value: input);
                  },
                );
              },
              icon: const Icon(Icons.edit),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.location_city),
            title:
            Text(userProvider.appUser?.userAddress?.city ?? 'Not set yet'),
            subtitle: const Text('City'),
            trailing: IconButton(
              onPressed: () {
                showSingleTextInputDialog(
                  context: context,
                  title: 'Update City',
                  onSubmit: (input) async {
                    await userProvider.updateUserProfile(field: 'userAddress.city', value: input);
                  },
                );
              },
              icon: const Icon(Icons.edit),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.local_post_office),
            title: Text(
                userProvider.appUser?.userAddress?.postCode ?? 'Not set yet'),
            subtitle: const Text('Postal Code'),
            trailing: IconButton(
              onPressed: () {
                showSingleTextInputDialog(
                  context: context,
                  title: 'Update City',
                  onSubmit: (input) async {
                    await userProvider.updateUserProfile(field: 'userAddress.postCode', value: input);
                  },
                );
              },
              icon: const Icon(Icons.edit),
            ),
          ),
        ],
      ),
    );
  }

  Container _headerSection(BuildContext context, UserProvider userProvider) {
    return Container(
      height: 150,
      color: Theme.of(context).primaryColor,
      child: Row(
        children: [
          Card(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
            elevation: 5,
            child: Icon(
              Icons.person,
              size: 90,
              color: Colors.grey,
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userProvider.appUser?.userName ?? 'No Display Name',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Colors.white),
              ),
              Text(
                userProvider.appUser!.email,
                style: TextStyle(color: Colors.white60),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
