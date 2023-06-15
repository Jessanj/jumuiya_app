import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../Helpers/api_services.dart';
import '../model/user.dart';

import '../screens/member_detail.dart';
import '../util/app_styles.dart';

class MembersList extends StatefulWidget {
  const MembersList({Key? key}) : super(key: key);

  @override
  State<MembersList> createState() => _MembersListState();
}

class _MembersListState extends State<MembersList> {
  late List<UserModel>? _userModel = [];

  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    _userModel = (await ApiService().getUsers())!;
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return _userModel == null || _userModel!.isEmpty
        ? const Center(
      child: CircularProgressIndicator(),
    )
        : ListView.builder(

      itemCount: _userModel!.length,
      itemBuilder: (context, index) {
        return Card(
        child: SizedBox(
        height: 65,
        child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:  [
        Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        image: const DecorationImage(
        fit: BoxFit.fitHeight,
        image: AssetImage('assets/images/jmProfile.jpg')
        )
        ),
        ),
        Text(_userModel![index].name , style: Styles.usernameStyle,),
        SizedBox(
        height: 55,
        width: 55,
        child: IconButton(
        icon: const Icon(Icons.arrow_forward),
        color: Styles.secondaryColor,
        iconSize: 30,
        onPressed: () {
        Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MemberDetail()),
        );
        },
        ) ,
        ),
        ],
        ),
        )
        );
      },
    );
  }
}
