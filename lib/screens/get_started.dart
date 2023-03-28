import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:jumuiya_app/screens/login_page.dart';
import 'package:jumuiya_app/util/app_layouts.dart';
import 'package:jumuiya_app/util/app_styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  @override
  State<GetStarted> createState() => _GetStartedState();

}

class _GetStartedState extends State<GetStarted> {
  late  Image getStared;
  @override
  void initState() {
    super.initState();
    getStared = Image.asset('assets/images/greenleaf.jpg');
  }

  @override
  Widget build(BuildContext context) {
    final size = AppLayouts.getSize(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: size.height - (0.4 * size.height),
            width: size.width,
            child: getStared,
          ),
          Container(
            padding: EdgeInsets.only(bottom: 20),
            alignment: Alignment.center,
            child: Text(AppLocalizations.of(context)!.welcome , style: Styles.headLineStyle1,),
          ),
         Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 20),
            child: Text(AppLocalizations.of(context)!.community_quote , style: Styles.headLineStyle2, textAlign: TextAlign.center),
          ),
          SizedBox(
            width: size.width *0.8 ,
            child: ElevatedButton(onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LogPage()),
              );
            },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(AppLocalizations.of(context)!.getStarted) ),
          ),
          const Gap(20),
          Column(
              children:  [
                Text(AppLocalizations.of(context)!.by_continuing, style: TextStyle(fontSize: 18 ) ),
                Text(AppLocalizations.of(context)!.terms_condition , style: TextStyle( fontSize: 18, fontStyle: FontStyle.normal , fontWeight: FontWeight.bold ) ),
              ]
          )
        ],
      )
    );
  }
}
