import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:jumuiya_app/screens/get_started.dart';
import 'package:jumuiya_app/util/app_styles.dart';
import 'package:jumuiya_app/screens/bottom_nav.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: primary,
        backgroundColor: Colors.white,
      ),

      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,

      home: const SplashScreen() ,
      locale: Locale('sw'),
    );
  }
}

// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//
//   @override
//   Widget build(BuildContext context) {
//     return  MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primaryColor: primary,
//         backgroundColor: Colors.white,
//       ),
//
//       localizationsDelegates: [
//         AppLocalizations.delegate, // Add this line
//         GlobalMaterialLocalizations.delegate,
//         GlobalWidgetsLocalizations.delegate,
//         GlobalCupertinoLocalizations.delegate,
//       ],
//
//       supportedLocales: [
//         Locale('en'), // English
//         Locale('es'), // Spanish
//       ],
//
//       home: const GetStarted(),
//     );
//   }
// }


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState  extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 3)).then((value){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const GetStarted()));
    });
  }
  @override
  Widget build(BuildContext context) {
     return Scaffold(
        body: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Image(image: AssetImage("assets/images/jm_logo.png"),
                width: 300,
              ),

            Text('ᒍᑌᗰᑌIYᗩ ᗩᑭᑭ' , style: TextStyle(fontSize: 40 , fontWeight: FontWeight.bold),),
              SizedBox(
                height: 50 ,
              ),
            SpinKitSquareCircle(
              color: Colors.purple ,
              size: 50.0,
            ),
            ],
          ),
        )
     );
  }
}
