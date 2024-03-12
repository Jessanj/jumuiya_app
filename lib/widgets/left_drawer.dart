import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:jumuiya_app/Helpers/api_URL.dart';
import 'package:jumuiya_app/screens/attandance/attendance_page.dart';
import 'package:jumuiya_app/screens/bottom_nav.dart';
import 'package:jumuiya_app/screens/chats/chat_group_message.dart';
import 'package:jumuiya_app/screens/contribution_page.dart';
import 'package:jumuiya_app/screens/groups/group_detail_page.dart';
import 'package:jumuiya_app/screens/home_page.dart';
import 'package:jumuiya_app/screens/login_page.dart';
import 'package:jumuiya_app/screens/members_page.dart';
import 'package:jumuiya_app/screens/schedule_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Helpers/api_services.dart';
import '../screens/elections/create_election_page.dart';
import '../util/app_colors.dart';

class LeftDrawer extends StatefulWidget {
  const LeftDrawer({Key? key}) : super(key: key);

  @override
  State<LeftDrawer> createState() => _LeftDrawerState();

}

class _LeftDrawerState extends State<LeftDrawer> {

   Future _fetchData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map<String, dynamic> userData = {
      'full_name' : pref.getString('full_name'),
      'phone' : pref.getString('phone'),
      'email' : pref.getString('email'),
      'profile_image' : pref.getString('profile_image')
    };
    return userData;
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
         SizedBox(
          height:150,
          child:
          DrawerHeader(
            decoration: BoxDecoration(
              color: AppColors.navyBlue,
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: FutureBuilder(
                    future: _fetchData(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Row(
                          children: [
                            snapshot.data['profile_image'].toString() == 'null' ?
                            CircleAvatar(
                              backgroundImage: AssetImage('assets/images/avatorProfile.png'),
                              maxRadius: 30,
                            ) :
                            CircleAvatar(
                              backgroundImage: NetworkImage(snapshot.data['profile_image'].toString()),
                              maxRadius: 30,
                            ),
                            Gap(4),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(snapshot.data['full_name'].toString(), style: TextStyle(fontSize: 16 , color: Colors.white), ),
                                Text(snapshot.data['email'].toString(),style: TextStyle(fontSize: 13,color: Colors.white),textAlign: TextAlign.start,),
                                Text(snapshot.data['phone'].toString() , style: TextStyle(fontSize: 13, color: Colors.white)),
                              ],
                            )
                          ],
                        );
                      } else {
                        // Show loading indicator or other placeholder
                        return CircularProgressIndicator();
                      }
                    },
                  ),
                ),
                // Icon(Icons.arrow_forward_ios_outlined)
              ],
            ),
          ),
        ),
        Expanded(child:
        ListView(
          shrinkWrap: true,
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
          SizedBox(
          height: 50,
          child: ListTile(
            leading : Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const BottomNav() ));
            },
          ),
          ),
            SizedBox(
              height: 50,
              child: ListTile(
                leading : Icon(Icons.handshake_outlined),
                title: const Text('jumuiya/Group Detail'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const GroupDetailPage() ));
                },
              ),
            ),
            SizedBox(
              height: 50,
              child: ListTile(
                leading : Icon(Icons.money),
                title: const Text('Transactions'),
                onTap: () {
                  // Then close the drawer
                  Navigator.pop(context);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ContributionPage() ));
                },
              ),
            ),
           SizedBox(
             height: 50,
             child: ListTile(
               leading: Icon(Icons.calendar_month),
               title: const Text('Events'),
               onTap: () {
                 Navigator.pop(context);
                 Navigator.pushReplacement(
                     context, MaterialPageRoute(builder: (context) => const SchedulePage()));
                 // Update the state of the app
                 // ...
                 // Then close the drawer

               },
             ),
           ),
           SizedBox(
             height: 50,
             child: ListTile(
               leading: Icon(Icons.perm_contact_calendar),
               title: const Text('Attendance'),
               onTap: () {
                 Navigator.pop(context);
                 Navigator.pushReplacement(
                     context, MaterialPageRoute(builder: (context) => const AttendancePage()));
                 // Update the state of the app
                 // ...
                 // Then close the drawer

               },
             ),
           ),
           SizedBox(
             height: 50,
             child: ListTile(
               leading: Icon(Icons.group),
               title: const Text('Members'),
               onTap: () {
                 Navigator.pop(context);
                 Navigator.pushReplacement(
                     context, MaterialPageRoute(builder: (context) => const MembersPage()));
                 // Update the state of the app
                 // ...
                 // Then close the drawer

               },
             ),
           ),

          SizedBox(
            height: 50,
            child: ListTile(
              leading: Icon(Icons.diamond),
              title: const Text('Donation & Contribution'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => const ContributionPage()));
              },
            ),
          ),
        SizedBox(
              height: 50,
              child: ListTile(
                leading: Icon(Icons.how_to_vote),
                title: const Text('Votes & Leadership'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (context) => const CreateElectionPage()));
                },
              ),
            ),
          SizedBox(
            height: 50,
            child: ListTile(
              leading: Icon(Icons.analytics_outlined),
              title: const Text('Reports'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
            Divider(),
            Padding(padding: EdgeInsets.only(left: 28),
                child : Text('Community Explore' , style: TextStyle(fontSize: 15  , fontWeight: FontWeight.bold),)
            ),
            SizedBox(
              height: 50,
              child: ListTile(
                leading: Icon(Icons.message),
                title: const Text('Chats'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => const ChatGroupMessage()));
                },
              ),
            ),

            SizedBox(
              height: 50,
              child: ListTile(
                leading: Icon(Icons.tv_rounded),
                title: const Text('Billboard Ads'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),

            const Divider(),
          ],
        ),
        ),
        SizedBox(
          height: 50,
          child: ListTile(
            leading: Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        Expanded(
          flex: 0,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 50,
              child:  ListTile(
                leading: Icon(Icons.logout_outlined),
                title:  const Text('Logout'),
                onTap: () {
                  ApiService.logout();
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (context) => const LoginPage()));
                  // Update the state of the app
                  // ...
                  // Then close the drawer

                },
              ),
            ),
          ),
        ),
        const Gap(20),
      ],
    );
  }
}
