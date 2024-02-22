
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:jumuiya_app/screens/home_page.dart';
import 'package:jumuiya_app/screens/nida_verification_page.dart';
import 'package:jumuiya_app/screens/reg_groups/register_jumuiya_page.dart';
import 'package:jumuiya_app/screens/registration_page.dart';
import 'package:jumuiya_app/screens/reset_password_page.dart';
import 'package:jumuiya_app/util/app_layouts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../Helpers/api_services.dart';
import '../util/app_colors.dart';
import '../util/app_styles.dart';
import '../util/constants.dart';
import '../widgets/custom_button.dart';
import 'bottom_nav.dart';
import 'chats/chats_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _form = GlobalKey();
  late Image loginImage;
  String _username = "";
  String _password = "";
  String _phone_number = '';
  String loginResponse = "";
  late DateTime currentBackPressTime;
  @override
  void initState() {
    super.initState();
    loginImage = Image.asset('assets/images/jm_logo.png');
  }

  @override
  Widget build(BuildContext context) {
    final size = AppLayouts.getSize(context);
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

    void forgotPasswordBottomSheet(context){
      showModalBottomSheet(context: context,  isScrollControlled: true , builder: (BuildContext bc){
        return Container(
          height: MediaQuery.of(context).size.height * 0.4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(
                child: Text('Enter Phone Number Linked To Account' , style: Styles.headLineStyle5,),
              ),
              Padding(padding: const EdgeInsets.only(left: 15 , bottom: 10 , right: 15) ,
                child: TextFormField(
                  decoration:
                  AppConstants.inputDecorationLogin.copyWith(
                    labelText: "Phone Number",
                  ),
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 17.0,
                  ),

                  onSaved: (value) => _phone_number = value?.trim() ?? "",
                  validator: (value) {
                    if (value == null || value == "")
                      return "Please Enter Phone Number.";

                    return null;
                  },
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                ),
              ),
              CustomButton(
                title: 'Get OTP Token',
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ResetPasswordPage())) ;
                },
              )
            ],
          ),
        );
      });
    }

    return PopScope(
        canPop: true,
        onPopInvoked: (didPop) async {
          if (didPop) {
            backPressedDialog();
          } else {

          }
        },
        child:  Scaffold(
            resizeToAvoidBottomInset: true,
              body: SafeArea(
                bottom: true,
              child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.15,
                      width: size.width,
                      child: loginImage,
                    ),
                    Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Form(
                              key: _form,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text( loginResponse , style: TextStyle(
                                    color: AppColors.red,
                                    fontSize: 15,
                                  ),),
                                  const Gap(8),
                                  TextFormField(
                                    decoration:
                                    AppConstants.inputDecorationLogin.copyWith(
                                      labelText: "Username (Email/Phone)",
                                    ),
                                    style: TextStyle(
                                      color: AppColors.black,
                                      fontSize: 17.0,
                                    ),

                                    onSaved: (value) => _username = value?.trim() ?? "",
                                    validator: (value) {
                                      if (value == null || value == "")
                                        return "Please Enter Username.";

                                      return null;
                                    },
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.next,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    style: TextStyle(
                                      color: AppColors.black,
                                      fontSize: 17.0,
                                    ),
                                    obscureText: true,
                                    validator: (value) {
                                      if (value == null || value.trim() == "") {
                                        return "Password cannot be null.";
                                      }
                                      return null;
                                    },
                                    onSaved: (value){
                                      _password = value!;
                                    },
                                    decoration:
                                    AppConstants.inputDecorationLogin.copyWith(
                                      hintText: "Enter Password",
                                    ),
                                  ),
                                  const Gap(10),
                                  CustomButton(
                                    onTap: (){
                                      showLoaderDialog(context);
                                      _Login();
                                    },
                                    title: "Sign In",
                                  ),
                                ],
                              ),
                            ),
                          ),

                          Align(
                            alignment: Alignment.center,
                            child: TextButton(onPressed: () {
                              // forgotPasswordBottomSheet(context);
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const BottomNav())) ;

                            },
                              child: const Text('Forgot Password ?' , style: TextStyle(color: AppColors.navyBlue , fontSize: 18)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15 , right: 15),
                            child:  Row(
                              children: [
                                const Text('Don\'t have an account ?' , style: TextStyle(color: Colors.black54 , fontSize: 18)),
                                TextButton(onPressed: () { Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const RegistrationPage())) ; },
                                  child: const Text('Register Here' , style: TextStyle(color: AppColors.navyBlue , fontSize: 18)),
                                ),
                              ],
                            ),
                          )

                        ]))
                  ]),
            )
            ),
    );

  }
  Future<bool> backPressedDialog() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Exit App'),
          content: Text('Do you want to exit the app?'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),
            TextButton(
              child: Text('Exit'),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
          ],
        );
      },
    ).then((value) => value as bool);
  }

  Future<void> _Login() async {
    if (!(_form.currentState?.validate() ?? true)){
      Navigator.pop(context);
      return ;
    }else{
      _form.currentState?.save();
      Object loginStatus = await ApiService.logInRequest(_username , _password);
      print(loginStatus);
      print('login status');
      if(loginStatus == true){
        Navigator.pop(context);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const BottomNav())) ;
      }else{
        setState(() {
          Navigator.pop(context);
          loginResponse = loginStatus.toString();
        });
      }

    }
  }

}
