import 'package:flutter/material.dart';

import '../util/app_colors.dart';
import '../widgets/left_drawer.dart';
import 'attandance/attendance_page.dart';
import 'chats/chat_group_message.dart';
class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {

  List<NavigationDestination> destinations = [
  NavigationDestination(
  icon: Icon(Icons.home),
  label: 'Home',
  ),
  NavigationDestination(
  icon: Icon(Icons.search),
  label: 'Search',
  ),
  NavigationDestination(
  icon: Icon(Icons.person),
  label: 'Profile',
  )];

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int index = 0;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.navyBlue,
        title: const Text('Explore Community'),
      ),
      drawer:  const Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: LeftDrawer(),
      ),
      bottomNavigationBar:
      NavigationBar(
        destinations : [
          Column(
            children: [
              IconButton(
                icon: const Icon(Icons.explore),
                onPressed: () {
                  print('ksks');
                },
              ),
              const Text('Explore' , style: TextStyle(fontSize: 12),),
            ],
          ),
          Column(
            children: [
              IconButton(
                icon: const Icon(Icons.message),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ChatGroupMessage()),
                  );
                },
              ),
              const Text('Chats' , style: TextStyle(fontSize: 12),),
            ],
          ),

          Column(
            children: [
              IconButton(
                icon: const Icon(Icons.perm_contact_calendar),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AttendancePage()),
                  );
                },
              ),
              const Text('Attendace' , style: TextStyle(fontSize: 12),),
            ],
          ),
        ],
          onDestinationSelected: (destination) {
            // Do something when any destination is selected.
          }
      ),
      body: Container(),
    );
  }
}
