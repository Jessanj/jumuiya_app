import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:jumuiya_app/screens/login_page.dart';
import 'package:jumuiya_app/util/app_styles.dart';
import '../Helpers/api_services.dart';
import '../util/app_layouts.dart';
import 'bottom_nav.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}
enum GroupType { jumuiya, private }
class _RegistrationPageState extends State<RegistrationPage> {
  final group_name = TextEditingController();
  GroupType ? _grouptype = GroupType.jumuiya;
  final first_name = TextEditingController();
  final last_name = TextEditingController();
  final middle_name = TextEditingController();
  final phone = TextEditingController();
  final email = TextEditingController();
  final address = TextEditingController();


  late  Image loginImage;
  @override
  void initState() {
    super.initState();
    loginImage = Image.asset('assets/images/jm_logo.jpg');
  }

  _saveUser(){
    var memberDetail =  Map<String, dynamic>();

    memberDetail['group_name'] = group_name.text;
    // memberDetail['group_type'] = _grouptype;
    memberDetail['first_name'] = first_name.text;
    memberDetail['last_name'] = last_name.text;
    memberDetail['middle_name'] = middle_name.text;
    memberDetail['phone'] = phone.text;
    memberDetail['email'] = email.text;
    memberDetail['address'] = address.text;

    var response = ( ApiService().RegUser(memberDetail));
    if(response == "success"){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage()));
    }else{
      return ;
    }
  }
  @override
  void dispose() {
    group_name.dispose();
    first_name.dispose();
    last_name.dispose();
    middle_name.dispose();
    phone.dispose();
    email.dispose();
    address.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final size = AppLayouts.getSize(context);
    return Scaffold(
        body: ListView(
          shrinkWrap: true,
          children:  [
            SizedBox(
              height: size.height * 0.18,
              width: size.width,
              child: Image.asset('assets/images/jumuiya_app_logo.png'),
            ),
            const Gap(15),

            Padding(
              padding: EdgeInsets.only(left: 15 , bottom: 10 , right: 15),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Group/Community Name',
                  hintText: 'Enter Your Community Name',
                ),
                controller: group_name,
              ),
            ),

            Padding(padding: const EdgeInsets.only(left: 15 , right: 15),
            child:  Text('Group/Communty Type' , style: Styles.headLineStyle3 ),
            ),
            Padding(padding: const EdgeInsets.only(left: 15 , bottom: 10 , right: 15 ),
                child: Row(
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            const Text('Jumuiya'),
                            Radio<GroupType>(
                              value: GroupType.jumuiya,
                              groupValue: _grouptype,
                              onChanged: (GroupType? value) {
                                setState(() {
                                  _grouptype = value;
                                });
                              },
                            ),
                          ],
                        )

                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            const Text('Private'),
                            Radio<GroupType>(
                              value: GroupType.private,
                              groupValue: _grouptype,
                              onChanged: (GroupType? value) {
                                setState(() {
                                  _grouptype = value;
                                });
                              },
                            ),
                          ],
                        )

                      ],
                    ),
                  ],
                ),
            ),

            Padding(
              padding: EdgeInsets.only(left: 15 , bottom: 10 , right: 15),
              child: TextField(
                scrollPadding: EdgeInsets.only(bottom:100),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'First Name',
                  hintText: 'Enter Your Name',
                ),
                controller: first_name,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15 , bottom: 10 , right: 15),
              child: TextField(
                scrollPadding: EdgeInsets.only(bottom:100),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Middle Name',
                  hintText: 'Enter Your Middle Name',
                ),
                controller: middle_name,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15 , bottom: 10 , right: 15),
              child: TextField(
                scrollPadding: EdgeInsets.only(bottom:100),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Last Name',
                  hintText: 'Enter Your Last Name',
                ),
                controller: last_name,
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 15 , bottom: 10 , right: 15 , top: 10),
              child: TextField(
                scrollPadding: EdgeInsets.only(bottom:100),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Address/Location',
                  hintText: 'Enter Your group location',
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(left: 15 , bottom: 10 , right: 15),
              child: TextField(
                scrollPadding: EdgeInsets.only(bottom:100),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                  hintText: 'Enter Your Email',
                ),
                controller: email,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15 , bottom: 5 , right: 15),
              child: TextField(
                scrollPadding: EdgeInsets.only(bottom:250),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Phone Number',
                  hintText: 'Enter Your Phonenumber',
                ),
                controller: phone,
              ),
            ),

            Container(
              width: size.width*0.2,
              padding: EdgeInsets.only(left: 60 , right: 60),
              child:ElevatedButton(onPressed: (){
                _saveUser();
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => const BottomNav()),
                // );
              },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: const Text('Register') , ),
            ),

          const Gap(30),
          ],
        ),
    );
  }
}
