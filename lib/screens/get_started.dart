import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:jumuiya_app/screens/login_page.dart';
import 'package:jumuiya_app/util/app_layouts.dart';
import 'package:jumuiya_app/util/app_styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  @override
  State<GetStarted> createState() => _GetStartedState();

}

class _GetStartedState extends State<GetStarted> {

  @override
  void initState() {
    super.initState();
    _skipIntro();
    getStared = Image.asset('assets/images/jumuiya_app_logo.png');
  }

  final introKey = GlobalKey<IntroductionScreenState>();
  late  Image getStared;

  Future<void> _skipIntro() async {
  final SharedPreferences prefs =  await SharedPreferences.getInstance();
  var skip = prefs.getBool('skip_intro');
    print(skip);
    if(skip == true){
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const LoginPage()),
      );
    }
  }
Future<void> _onIntroEnd(context)  async {
    final SharedPreferences pref  = await SharedPreferences.getInstance();
    pref.setBool('skip_intro', true);
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const LoginPage()),
    );
  }

  Widget _buildFullscreenImage() {
    return Image.asset(
      'assets/fullscreen.jpg',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    );
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('assets/images/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    final size = AppLayouts.getSize(context);
    const bodyStyle =  TextStyle(fontSize: 19.0);

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
        allowImplicitScrolling: true,
        autoScrollDuration: 3000,
        globalHeader: Align(
        alignment: Alignment.topRight,
        child: SafeArea(
          child: Padding(
          padding: const EdgeInsets.only(top: 16, right: 16),
          child: _buildImage('jumuiya_app_logo.png', 200),
        ),
    ),
    ),

      globalFooter: SizedBox(
        width: double.infinity,
        height: 60,
        child: ElevatedButton(
          style:  ElevatedButton.styleFrom(
              backgroundColor : const Color.fromRGBO(57,21,97,1),) ,
          child: const Text(
            'Let\'s go right away!',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          onPressed: () => _onIntroEnd(context),
        ),
      ),
      pages: [
      PageViewModel(
      title: AppLocalizations.of(context)!.welcome,
      body:
      "Instead of having to buy an entire share, invest any amount you want.",
      image: _buildImage('stay_connected.jpg'),
      decoration: pageDecoration,
    ),
    PageViewModel(
    title: "Learn as you go",
    body:
    "Download the Stockpile app and master the market with our mini-lesson.",
    image: _buildImage('networking_image.jpg'),
    decoration: pageDecoration,
    ),
        PageViewModel(
          title: "Learn as you go",
          body:
          "Download the Stockpile app and master the market with our mini-lesson.",
          image: _buildImage('together_image.jpg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Learn as you go",
          body:
          "Download the Stockpile app and master the market with our mini-lesson.",
          image: _buildImage('tree_money.jpg'),
          decoration: pageDecoration,
        ),
    ],

    onDone: () => _onIntroEnd(context),
    showSkipButton: false,
    skipOrBackFlex: 0,
    nextFlex: 0,
    showBackButton: true,
    back: const Icon(Icons.arrow_back , color: Colors.white,),
    skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600 , color: Colors.white,)),
    next: const Icon(Icons.arrow_forward , color: Colors.white,),
    done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600 , color: Colors.white,)),
    curve: Curves.fastLinearToSlowEaseIn,
    controlsMargin: const EdgeInsets.all(16),
    controlsPadding: kIsWeb
    ? const EdgeInsets.all(12.0)
        : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
    dotsDecorator: const DotsDecorator(
    size: Size(10.0, 10.0),
    color: Color(0xFFBDBDBD),
    activeSize: Size(22.0, 10.0),
    activeShape: RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(25.0)),
    ),
    ),
    dotsContainerDecorator: const ShapeDecoration(
    color: Colors.black87,
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
    ),
    ),
    );

  }
}
// MaterialApp(
// debugShowCheckedModeBanner: false,
// home:  Scaffold(
// backgroundColor: Colors.white,
// body: Column(
// children: [
// SizedBox(
// height: size.height - (0.4 * size.height),
// width: size.width,
// child: getStared,
// ),
// Container(
// padding: EdgeInsets.only(bottom: 20),
// alignment: Alignment.center,
// child: Text(AppLocalizations.of(context)!.welcome , style: Styles.headLineStyle1,),
// ),
// Container(
// alignment: Alignment.center,
// padding: const EdgeInsets.only(bottom: 20),
// child: Text(AppLocalizations.of(context)!.community_quote , style: Styles.headLineStyle2, textAlign: TextAlign.center),
// ),
// SizedBox(
// width: size.width *0.8 ,
// child: ElevatedButton(onPressed: (){
// Navigator.push(
// context,
// MaterialPageRoute(builder: (context) => const LogPage()),
// );
// },
// style: ElevatedButton.styleFrom(
// backgroundColor: Colors.lightBlue,
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(30),
// ),
// ),
// child: Text(AppLocalizations.of(context)!.getStarted) ),
// ),
// const Gap(20),
// Column(
// children:  [
// Text(AppLocalizations.of(context)!.by_continuing, style: TextStyle(fontSize: 18 ) ),
// Text(AppLocalizations.of(context)!.terms_condition , style: TextStyle( fontSize: 18, fontStyle: FontStyle.normal , fontWeight: FontWeight.bold ) ),
// ]
// )
// ],
// )
// ),
// );