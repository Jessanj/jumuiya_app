import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:jumuiya_app/screens/bottom_nav.dart';

import '../../Helpers/api_services.dart';
import '../../util/app_styles.dart';
import '../../util/constants.dart';
import '../../widgets/custom_button.dart';

class RegisterJumuiyaForm extends StatefulWidget {
  const RegisterJumuiyaForm({Key? key}) : super(key: key);

  @override
  State<RegisterJumuiyaForm> createState() => _RegisterJumuiyaFormState();
}

class _RegisterJumuiyaFormState extends State<RegisterJumuiyaForm> {
  final GlobalKey<FormState> regForm = GlobalKey<FormState>();
  String _DialogAlertText = 'Loading...';
  String _groupName = "";
  String _groupType = "Private";
  String _location = "";
  String _description = "";

  _saveGroup() async {

    if (!(regForm.currentState?.validate() ?? true)){
      Navigator.pop(context);
      return ;
    }else{

      var groupDetail =  <String, dynamic>{};
      groupDetail['group_name'] = _groupName;
      groupDetail['group_type'] = _groupType;
      groupDetail['group_location'] = _location;
      groupDetail['created_by'] = 1 ;
      groupDetail['description'] = _description;

      var response = await ApiService.SaveGroup(groupDetail);

      if(response.toString() == 'true'){
        Navigator.pop(context);
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const BottomNav()));
      }else{
        Navigator.pop(context);
        return ;
      }

    }

  }

  @override
  Widget build(BuildContext context) {

    showLoaderDialog(BuildContext context){
      AlertDialog alert=AlertDialog(
        content: Row(
          children: [
            const CircularProgressIndicator(),
            Container(margin: const EdgeInsets.only(left: 10),child: Text(_DialogAlertText)),
          ],),
      );

      showDialog(barrierDismissible: false,
        context:context,
        builder:(BuildContext context){
          return alert;
        },
      );
    }

    return Form(
        key: regForm,
        child: Column(
        children: [
          const Gap(30),
          Padding(
          padding: EdgeInsets.only(left: 15 , bottom: 10 , right: 15),
          child:
              TextFormField(
                  scrollPadding: EdgeInsets.only(bottom:100),
                decoration: AppConstants.inputDecorationLogin.copyWith(
                    labelText: 'Group/Community Name',
                    hintText: 'Enter Your Community Name',
                  ),
                  validator: (value) {
                  if(value == null || value.trim() == ""){
                    return "Community/Group cannot be null";
                  }
                  return null;
                  },
                  onChanged: (value) {
                    _groupName = value;
                  },
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child:  Padding(padding: const EdgeInsets.only(left: 15 , right: 15),
                child:  Text('Group/Communty Type' , style: Styles.headLineStyle3 ),
              ),
            ),
            Row(
            children: [
              Radio(
                value: "Private",
                groupValue: _groupType,
                onChanged: (value) {
                  setState(() {
                    _groupType = value.toString();
                  });
                },
              ),
              Text("Private"),
              Radio(
                value: "Jumuiya",
                groupValue: _groupType,
                onChanged: (value) {
                  setState(() {
                    _groupType = value.toString();
                  });
                },
              ),
              Text("Jumuiya"),
            ],
          ),

          Padding(
            padding: EdgeInsets.only(left: 15 , bottom: 10 , right: 15),
            child:
            TextFormField(
              scrollPadding: EdgeInsets.only(bottom:100),
              decoration: AppConstants.inputDecorationLogin.copyWith(
                labelText: 'Location Based',
                hintText: 'Enter Your Community Location',
              ),
              validator: (value) {
                if(value == null || value.trim() == ""){
                  return "Location cannot be null";
                }
                return null;
              },
              onChanged: (value) {
                _location = value;
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15 , bottom: 10 , right: 15),
            child:
            TextFormField(
              scrollPadding: EdgeInsets.only(bottom:100),
              decoration: AppConstants.inputDecorationLogin.copyWith(
                labelText: 'Group Description',
                hintText: 'Enter Community/Group Summary ',
              ),
              validator: (value) {
                if(value == null || value.trim() == ""){
                  return "Description cannot be null";
                }
                return null;
              },
              onChanged: (value) {
                _description = value;
              },
            ),
          ),
          const Gap(15),
          Container(
            alignment: Alignment.center,
            child:  CustomButton(
              onTap: (){
                showLoaderDialog(context);
                _saveGroup();
              },
              title: "Register",
            ),
          ),
        ],
      ),
    );
  }
}
