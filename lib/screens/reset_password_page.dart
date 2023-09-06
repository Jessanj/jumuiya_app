
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:jumuiya_app/screens/login_page.dart';
import 'package:jumuiya_app/util/app_layouts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../Helpers/api_services.dart';
import '../util/app_colors.dart';
import '../util/constants.dart';
import '../widgets/custom_button.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final GlobalKey<FormState> _form = GlobalKey();
  late Image loginImage;
  String _new_password = "";
  String _confirm_password = "";
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
    return   Scaffold(
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
                                  return "Last password cannot be null.";
                                }
                                if(value.length < 8){
                                  return "Password must be at least 8 characters long";
                                }
                                return null;
                              },
                              onSaved: (value){
                                _new_password = value!;
                              },
                              decoration:
                              AppConstants.inputDecorationLogin.copyWith(
                                hintText: "New Password",
                              ),
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
                                  return "Cannot be null.";
                                }
                                if(value != _new_password){
                                  return 'Password Not Match';
                                }
                                return null;
                              },
                              onSaved: (value){
                                _confirm_password = value!;
                              },
                              decoration:
                              AppConstants.inputDecorationLogin.copyWith(
                                hintText: "Confirm Password",
                              ),
                            ),
                            const Gap(10),
                            CustomButton(
                              onTap: (){
                                showLoaderDialog(context);
                                _ResetPassword();
                              },
                              title: "Update Password",
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]))
            ]));

  }

  Future<void> _ResetPassword() async {
    if (!(_form.currentState?.validate() ?? true)){
      Navigator.pop(context);
      return ;
    }else{
      _form.currentState?.save();
      Object ResetStatus = await ApiService.resetPassword(_new_password);
      if(ResetStatus == true){
        Navigator.pop(context);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage())) ;
      }else{
        setState(() {
          Navigator.pop(context);
          loginResponse = ResetStatus.toString();
        });
      }

    }
  }

}
