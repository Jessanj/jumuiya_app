import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:jumuiya_app/util/app_layouts.dart';

import '../Helpers/api_services.dart';
import 'members_list.dart';

class RegisterMemberForm extends StatefulWidget {
  const RegisterMemberForm({Key? key}) : super(key: key);

  @override
  State<RegisterMemberForm> createState() => _RegisterMemberFormState();
}

class _RegisterMemberFormState extends State<RegisterMemberForm> {
  final first_name = TextEditingController();
  final last_name = TextEditingController();
  final middle_name = TextEditingController();
  final phone1 = TextEditingController();
  final phone2 = TextEditingController();
  final email = TextEditingController();
  final NIN = TextEditingController();
  final address = TextEditingController();


    _saveMember(){
      var memberDetail =  Map<String, dynamic>();
        memberDetail['first_name'] = first_name.text;
        memberDetail['last_name'] = last_name.text;
        memberDetail['middle_name'] = middle_name.text;
        memberDetail['phone1'] = phone1.text;
        memberDetail['phone2'] = phone2.text;
        memberDetail['email'] = email.text;
        memberDetail['NIN'] = NIN.text;
        memberDetail['address'] = address.text;

      var response = ( ApiService().RegUser(memberDetail));
      return response;
  }
  @override
  void dispose() {
    first_name.dispose();
    last_name.dispose();
    middle_name.dispose();
    phone1.dispose();
    phone2.dispose();
    email.dispose();
    NIN.dispose();
    address.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size  = AppLayouts.getSize(context);
    return ListView(
     padding:  const  EdgeInsets.only(left: 20 , right: 20),
      scrollDirection: Axis.vertical,
      children:[
            const Gap(10),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'First Name',
                hintText: 'Enter Your First Name',
              ),
              controller: first_name,
            ),
        const Gap(10),
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Middle Name',
            hintText: 'Enter Your Middle Name',
          ),
          controller: middle_name,
        ),
        const Gap(10),
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Last Name',
            hintText: 'Enter Your Last Name',
          ),
          controller: last_name,
        ),
         const Gap(10),
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Phone Number 1',
            hintText: 'Enter Your Phone number Name',
          ),
          controller: phone1,
        ),
        const Gap(10),
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Phone Number 2 (Optional)',
            hintText: 'Enter Your Phone number Name',
          ),
          controller: phone2,
        ),
        const Gap(10),
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Email',
            hintText: 'Enter Your Email',
          ),
          controller: email,
        ),
        const Gap(10),
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'ID NUMBER (NIN , voterID , License)',
            hintText: 'Enter Your ID',
          ),
          controller: NIN,
        ),
        const  Gap(10),
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Address',
            hintText: 'Enter Your ID',
          ),
          controller: address,
        ),
        const  Gap(10),

        Container(
          width: size.width*0.5,
          child:ElevatedButton(onPressed: (){
            var resp  = _saveMember();
            if(false){
              const TabBarView(children: [
                MembersList()
              ],);
            }else{
              var snackBar = const SnackBar(content: Text('Sorry something went wrong' , textAlign: TextAlign.center,));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.lightBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            child: const Text('SAVE MEMBER') , ),
        ),

      ],
    );
  }
}
