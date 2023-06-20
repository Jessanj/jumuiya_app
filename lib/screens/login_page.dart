
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:jumuiya_app/screens/home_page.dart';
import 'package:jumuiya_app/screens/registration_page.dart';
import 'package:jumuiya_app/util/app_layouts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../Helpers/api_services.dart';
import '../util/app_colors.dart';
import '../util/app_styles.dart';
import '../util/constants.dart';
import '../widgets/custom_button.dart';

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
  String loginResponse = "";

  @override
  void initState() {
    super.initState();
    loginImage = Image.asset('assets/images/jm_logo.png');
  }

  @override
  Widget build(BuildContext context) {
    final size = AppLayouts.getSize(context);

    return Scaffold(
        body: Column(children: [
      SizedBox(
        height: size.height * 0.23,
        width: size.width,
        child: loginImage,
      ),
      Padding(
          padding: EdgeInsets.all(15),
          child: Column(children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15),
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
                      height: 15,
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
                    SizedBox(
                      height: 15,
                    ),
                    CustomButton(
                      onTap: _Login,
                      title: "Sign In",
                    ),
                  ],
                ),
              ),
            ),

            Align(
              alignment: Alignment.center,
              child: TextButton(onPressed: () { Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage())) ; },
                child: const Text('Forgot Password ?' , style: TextStyle(color: AppColors.navyBlue , fontSize: 18)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15 , right: 15) ,
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
    ]));
  }

  Future<void> _Login() async {
    if (!(_form.currentState?.validate() ?? true)){
      return ;
    }else{
      _form.currentState?.save();
      Object loginStatus = await ApiService.logInRequest(_username , _password);
      if(loginStatus == true){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage())) ;
      }else{
        setState(() {
          loginResponse = loginStatus.toString();
        });
      }

    }
  }
}
