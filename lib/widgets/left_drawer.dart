import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jumuiya_app/Helpers/api_URL.dart';
import 'package:jumuiya_app/screens/login_page.dart';

import '../Helpers/api_services.dart';
import '../util/app_colors.dart';

class LeftDrawer extends StatefulWidget {
  const LeftDrawer({Key? key}) : super(key: key);

  @override
  State<LeftDrawer> createState() => _LeftDrawerState();
}

class _LeftDrawerState extends State<LeftDrawer> {
  @override
  Widget build(BuildContext context) {
    return  ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeader(
          decoration: BoxDecoration(
            color: AppColors.navyBlue,
          ),
          child: Text('Drawer Header'),
        ),
        ListTile(
          title: const Text('jumuaa'),
          onTap: () {
            // Update the state of the app
            // ...
            // Then close the drawer
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: const Text('yule'),
          onTap: () {
            // Update the state of the app
            // ...
            // Then close the drawer
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: const Text('logout'),
          onTap: () {
            ApiService.logout();
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => const LoginPage()));
            // Update the state of the app
            // ...
            // Then close the drawer

          },
        ),
      ],
    );
  }
}
