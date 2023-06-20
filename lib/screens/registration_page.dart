import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:jumuiya_app/screens/login_page.dart';
import 'package:jumuiya_app/util/app_styles.dart';
import '../Helpers/api_services.dart';
import '../util/app_colors.dart';
import '../util/app_layouts.dart';
import '../util/constants.dart';
import '../widgets/custom_button.dart';
import 'bottom_nav.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}
enum GroupType { jumuiya, private }
class _RegistrationPageState extends State<RegistrationPage>  with TickerProviderStateMixin {

  final GlobalKey<FormState> regForm = GlobalKey<FormState>();

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

    loginImage = Image.asset('assets/images/jm_logo.jpg');

    super.initState();
  }

  _saveUser(){

    if (!(regForm.currentState?.validate() ?? true)){
      Navigator.pop(context);
      return ;
    }else{

      var memberDetail =  <String, dynamic>{};
      memberDetail['group_name'] = group_name.text;
      // memberDetail['group_type'] = _grouptype;
      memberDetail['first_name'] = first_name.text;
      memberDetail['last_name'] = last_name.text;
      memberDetail['middle_name'] = middle_name.text;
      memberDetail['phone'] = phone.text;
      memberDetail['email'] = email.text;
      memberDetail['address'] = address.text;

      var response = ( ApiService().registerUser(memberDetail));

      if(response == "success"){
        Navigator.pop(context);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage()));
      }else{
        return ;
      }

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
            Form(
              key: regForm , child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 15 , bottom: 10 , right: 15),
                    child: TextFormField(
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
                      controller: group_name,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child:  Padding(padding: const EdgeInsets.only(left: 15 , right: 15),
                      child:  Text('Group/Communty Type' , style: Styles.headLineStyle3 ),
                    ),
                  ),

                   Padding(padding: const EdgeInsets.only(left: 15 , bottom: 10 , right: 15 ),
                      child:
                      Row(
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
                    child: TextFormField(
                      scrollPadding: EdgeInsets.only(bottom:100),
                      decoration: AppConstants.inputDecorationForms.copyWith(
                        labelText: 'First Name',
                        hintText: 'Enter Your Name',
                      ),
                      validator: (value) {
                        if (value == null || value == "") {
                          return "First Username cannot be null.";
                        }
                        return null;
                      },
                      controller: first_name,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15 , bottom: 10 , right: 15),
                    child: TextFormField(
                      scrollPadding: EdgeInsets.only(bottom:100),
                      decoration:  AppConstants.inputDecorationForms.copyWith(
                        labelText: 'Middle Name',
                        hintText: 'Enter Your Middle Name',
                      ),
                      controller: middle_name,
                      validator: (value) {
                        if (value == null || value == "") {
                          return "Middle Username cannot be null.";
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15 , bottom: 10 , right: 15),
                    child: TextFormField(
                      scrollPadding: EdgeInsets.only(bottom:100),
                      decoration: AppConstants.inputDecorationForms.copyWith(
                        labelText: 'Last Name',
                        hintText: 'Enter Your Last Name',
                      ),
                      controller: last_name,
                      validator: (value) {
                        if (value == null || value == "") {
                          return "Last Username cannot be null.";
                        }
                        return null;
                      },
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 15 , bottom: 10 , right: 15 , top: 10),
                    child: TextFormField(
                        scrollPadding: EdgeInsets.only(bottom:100),
                        decoration: AppConstants.inputDecorationForms.copyWith(
                          labelText: 'Address/Location',
                          hintText: 'Enter Your group location',
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
                    padding: EdgeInsets.only(left: 15 , bottom: 10 , right: 15),
                    child: TextFormField(
                      scrollPadding: EdgeInsets.only(bottom:100),
                      decoration: AppConstants.inputDecorationForms.copyWith(
                        labelText: 'Email',
                        hintText: 'Enter Your Email',
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
                    padding: EdgeInsets.only(left: 15 , bottom: 5 , right: 15),
                    child: TextFormField(
                      scrollPadding: EdgeInsets.only(bottom:250),
                      decoration: AppConstants.inputDecorationForms.copyWith(
                        labelText: 'Phone Number',
                        hintText: 'Enter Your Phonenumber',
                      ),
                      controller: phone,
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
                          _saveUser();
                          },
                        title: "Register",
               ),
             ),

            Center(
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('I have an account !' , style: TextStyle(color: Colors.black54 , fontSize: 18)),
                  TextButton(onPressed: () { Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage())) ; },
                    child: const Text('Sign in' , style: TextStyle(color: AppColors.navyBlue , fontSize: 18)),
                  ),
                ],
              ),
            )
          ],
        ),
    );
  }
}
