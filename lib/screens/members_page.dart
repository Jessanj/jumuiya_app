import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../util/app_colors.dart';
import '../util/app_styles.dart';
import '../widgets/members_list.dart';
import '../widgets/register_member_form.dart';
import 'member_detail.dart';

class MembersPage extends StatefulWidget {
  const MembersPage({Key? key}) : super(key: key);

  @override
  State<MembersPage> createState() => _MembersPageState();

}

class _MembersPageState extends State<MembersPage> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 1,
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.navyBlue,
            title: const Text('Members'),
            bottom : const TabBar(
              indicatorColor: Colors.white70,
              indicatorWeight: 3,
              tabs: <Widget>[
                Tab(
                  icon: Icon(Icons.people_sharp),
                  text: "Members",
                ),
                Tab(
                  text: "Register",
                  icon: Icon(Icons.person_add_sharp),
                ),
                Tab(
                  text: "Requests",
                  icon: Icon(Icons.brightness_5_sharp),
                ),
              ],
            ),
          ),
          body: const TabBarView(
            children: <Widget>[
              Center(
                child:  MembersList(),
              ),
              Center(
                child: RegisterMemberForm() ,
              ),
              Center(
                child: Text("It's sunny here"),
              ),
            ],
          ),

        )
      );
  }
}
