import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:jumuiya_app/util/app_layouts.dart';

import '../Helpers/api_services.dart';
import '../util/app_styles.dart';
import '../util/constants.dart';
import 'custom_button.dart';
import 'members_list.dart';

class RegisterMemberForm extends StatefulWidget {
  const RegisterMemberForm({Key? key}) : super(key: key);

  @override
  State<RegisterMemberForm> createState() => _RegisterMemberFormState();
}

class _RegisterMemberFormState extends State<RegisterMemberForm> {

  final GlobalKey<FormState>  addMemberForm = GlobalKey<FormState>();
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
        memberDetail['jumuiya_name'] =
        memberDetail['first_name'] = first_name.text;
        memberDetail['last_name'] = last_name.text;
        memberDetail['middle_name'] = middle_name.text;
        memberDetail['phone1'] = phone1.text;
        memberDetail['phone2'] = phone2.text;
        memberDetail['email'] = email.text;
        memberDetail['NIN'] = NIN.text;
        memberDetail['address'] = address.text;

      var response = ApiService().registerUser(memberDetail);
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

    showLoaderDialog(BuildContext context){
      AlertDialog alert=AlertDialog(
        content: Row(
          children: [
            const CircularProgressIndicator(),
            Container(margin: const EdgeInsets.only(left: 10),child: const Text("Loading..." )),
          ],),
      );

      showDialog(barrierDismissible: false,
        context:context,
        builder:(BuildContext context){
          return alert;
        },
      );
    }

    return ListView(
     padding:  const  EdgeInsets.only(left: 20 , right: 20),
      scrollDirection: Axis.vertical,
      children:[
        const Gap(10),
        Form(
          key: addMemberForm ,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Gap(20),
              Padding(
                padding: const EdgeInsets.only( bottom: 20),
                child: TextFormField(
                  decoration: AppConstants.inputDecorationLogin.copyWith(
                    labelText: 'National Identity Number' ,
                    hintText: 'Enter NIN Number ',
                  ),
                  validator: (value) {
                    if(value == null || value.trim() == ""){
                      return "NIN cannot be null";
                    }
                    return null;
                  },
                  controller: NIN,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only( bottom: 20),
                child: TextFormField(
                  scrollPadding: EdgeInsets.only(bottom:100),
                  decoration: AppConstants.inputDecorationForms.copyWith(
                    labelText: 'First Name',
                    hintText: 'Enter members first name',
                  ),
                  validator: (value) {
                    if (value == null || value == "") {
                      return "First name cannot be null.";
                    }
                    return null;
                  },
                  controller: first_name,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only( bottom: 20),
                child: TextFormField(
                  scrollPadding: EdgeInsets.only(bottom:100),
                  decoration:  AppConstants.inputDecorationForms.copyWith(
                    labelText: 'Middle Name',
                    hintText: 'Enter Members Middle Name',
                  ),
                  controller: middle_name,
                  validator: (value) {
                    if (value == null || value == "") {
                      return "Middle name cannot be null.";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only( bottom: 20),
                child: TextFormField(
                  scrollPadding: EdgeInsets.only(bottom:100),
                  decoration: AppConstants.inputDecorationForms.copyWith(
                    labelText: 'Last Name',
                    hintText: 'Enter Members Last Name',
                  ),
                  controller: last_name,
                  validator: (value) {
                    if (value == null || value == "") {
                      return "Last name cannot be null.";
                    }
                    return null;
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.only( bottom: 20),
                child: TextFormField(
                  scrollPadding: EdgeInsets.only(bottom:100),
                  decoration: AppConstants.inputDecorationForms.copyWith(
                    labelText: 'Address/Location',
                    hintText: 'Enter members address location',
                  ),
                  controller: address,
                  validator: (value) {
                    if (value == null || value == "") {
                      return "Address/Location cannot be null.";
                    }
                    return null;
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.only( bottom: 20),
                child: TextFormField(
                  scrollPadding: EdgeInsets.only(bottom:100),
                  decoration: AppConstants.inputDecorationForms.copyWith(
                    labelText: 'Email',
                    hintText: 'Enter Members Email',
                  ),
                  controller: email,
                  validator: (value) {
                    if (value == null || value == "") {
                      return "Email cannot be null.";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only( bottom: 10),
                child: TextFormField(
                  scrollPadding: EdgeInsets.only(bottom:250),
                  decoration: AppConstants.inputDecorationForms.copyWith(
                    labelText: 'Phone Number',
                    hintText: 'Enter Members Phonenumber',
                  ),
                  controller: phone1,
                  validator: (value) {
                    if (value == null || value == "") {
                      return "Phonenumber cannot be null.";
                    }
                    return null;
                  },
                ),
              ),
            ]),
        ),

        const Gap(15),

        Container(
          alignment: Alignment.center,
          child:  CustomButton(
            onTap: (){
              showLoaderDialog(context);

            },
            title: "Register Member",
          ),
        ),


      ],
    );
  }
}
