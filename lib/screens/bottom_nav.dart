import 'package:flutter/material.dart';
import 'package:jumuiya_app/screens/home_page.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:jumuiya_app/screens/login_page.dart';
import 'package:jumuiya_app/screens/schedule_page.dart';
import 'package:jumuiya_app/screens/user_profile_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../Helpers/api_services.dart';

import '../util/app_colors.dart';
import 'explore_page.dart';
import 'members_page.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  @override
  initState(){
    super.initState();
    checkLogin();
  }

   void checkLogin()  {
    var tkn =  ApiService.isLoggedIn();
    if(tkn == false){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage())) ;
    }
  }

  int _selectedIndex = 2;
  static final List<Widget> _widgetOptions = <Widget>[
    const ExplorePage(),
    const SchedulePage(),
    const HomePage(),
    const MembersPage(),
    const UserProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        theme: ThemeData(
          primaryColor: AppColors.navyBlue,
          backgroundColor: Colors.white,
        ),
      debugShowCheckedModeBanner: false,
      locale: Locale('sw'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
      home:  Scaffold(
        body: Center(
          child: _widgetOptions[_selectedIndex],
        ),
        bottomNavigationBar: BottomNavigationBar(
          // backgroundColor : Colors.blue,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          elevation: 10,
          iconSize : 35,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedItemColor: AppColors.navyBlue,
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: const Color(0xFF526480),
          items: const <BottomNavigationBarItem> [
            BottomNavigationBarItem(
              icon: Icon(FluentSystemIcons.ic_fluent_search_regular),
              activeIcon: Icon(FluentSystemIcons.ic_fluent_search_filled),
              label: "Explore",
            ),
            BottomNavigationBarItem(
                icon: Icon(FluentSystemIcons.ic_fluent_calendar_regular),
                activeIcon: Icon(FluentSystemIcons.ic_fluent_calendar_filled),
                label: "Schedule"),
            BottomNavigationBarItem(
                icon: Icon(FluentSystemIcons.ic_fluent_home_regular),
                activeIcon: Icon(FluentSystemIcons.ic_fluent_home_filled),
                label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(FluentSystemIcons.ic_fluent_people_regular),
                activeIcon: Icon(FluentSystemIcons.ic_fluent_people_filled),
                label: "Members"),
            BottomNavigationBarItem(
                icon: Icon(FluentSystemIcons.ic_fluent_person_regular),
                activeIcon: Icon(FluentSystemIcons.ic_fluent_person_filled),
                label: "Profile")
          ],
        ),
      )
    );



  }
}
