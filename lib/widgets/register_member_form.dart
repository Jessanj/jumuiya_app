import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:jumuiya_app/util/app_layouts.dart';

import 'members_list.dart';

class RegisterMemberForm extends StatefulWidget {
  const RegisterMemberForm({Key? key}) : super(key: key);

  @override
  State<RegisterMemberForm> createState() => _RegisterMemberFormState();
}

class _RegisterMemberFormState extends State<RegisterMemberForm> {
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
            ),
        const Gap(10),
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Middle Name',
            hintText: 'Enter Your Middle Name',
          ),
        ),
        const Gap(10),
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Last Name',
            hintText: 'Enter Your Last Name',
          ),
        ),
         const Gap(10),
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Phone Number 1',
            hintText: 'Enter Your Phone number Name',
          ),
        ),
        const Gap(10),
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Phone Number 2 (Optional)',
            hintText: 'Enter Your Phone number Name',
          ),
        ),
        const Gap(10),
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Email',
            hintText: 'Enter Your Email',
          ),
        ),
        const Gap(10),
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'ID NUMBER (NIN , voterID , License)',
            hintText: 'Enter Your ID',
          ),
        ),
        const  Gap(10),
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Address',
            hintText: 'Enter Your ID',
          ),
        ),
        const  Gap(10),
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Address',
            hintText: 'Enter Your ID',
          ),
        ),
        const Gap(10),
        Container(
          width: size.width*0.5,
          child:ElevatedButton(onPressed: (){
            TabBarView(children: [
              MembersList()
            ],);
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
