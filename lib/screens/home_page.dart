import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:jumuiya_app/screens/notifications_page.dart';
import 'package:jumuiya_app/util/app_layouts.dart';
import 'package:jumuiya_app/util/app_styles.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../widgets/left_drawer.dart';

class LangItem {
  const LangItem(this.name,this.icon);
  final String name;
   //final ImageIcon icon;
  final Icon icon;
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  @override
  void initState() {
    super.initState();
  }
  int _slidercurrent = 0;
  final CarouselController _slidercontroller = CarouselController();

  List<LangItem> lang = [
  //   const LangItem('ENG', ImageIcon(
  // AssetImage("assets/images/united-states.png"),
  // size: 24,
  // ),),
  //   const LangItem('KISW', ImageIcon(
  //     AssetImage("assets/images/tanzania.png"),
  //     size: 24,
  //   ),),
    const LangItem('ENG', Icon(Icons.flag),),
    const LangItem('KISW', Icon(Icons.flag_circle_outlined),),
  ];
  List <String> imgList = [
    'united-states.png',
    'greenleaf.jpg',
    'jmProfile.jpg',
    'tanzania.png'
  ];
  
  @override
  Widget build(BuildContext context) {
    final size  =  AppLayouts.getSize(context);
    LangItem defaultLang = lang.first;
    final List<Widget> imageSliders = imgList.map((item) => Container(
      child: Container(
        margin: const EdgeInsets.only(left: 5),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(12)),
          child: Stack(
            children: <Widget>[
              Image.asset('assets/images/$item', fit: BoxFit.fill, width: size.width,),
              Positioned(
                bottom: 0.0,
                left: 0,
                right: 0,
                child: Container(
                  decoration:
                  const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(200, 0, 0, 0),
                        Color.fromARGB(0, 0, 0, 0)
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  child: Text(
                    'No. ${imgList.indexOf(item)} image',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    )).toList();

    return  Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          DropdownButton(
            value: defaultLang ,
            style: const TextStyle(color: Colors.deepPurple),
            items: lang.map((LangItem lang) {
              return DropdownMenuItem(
                value: lang,
                child: Row(
                  children: [
                   lang.icon,
                    const SizedBox(width: 10, ),
                    Text(
                      lang.name,
                      style:  const TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                defaultLang = value!;
              });
            },
          ),
          const SizedBox(width: 10, ),
          IconButton(
            icon: const Icon(Icons.add_alert),
            tooltip: 'Notifications',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NotificationPage()),
              );
            },
          ),
        ],
      ),
      drawer:  const Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: LeftDrawer(),
      ),
      body: ListView(
        padding: const EdgeInsets.only(left: 8, right: 8),
        children: [
          const Gap(6),
          Card(
              child: SizedBox(
                height: 65,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:  [
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          image: const DecorationImage(
                              fit: BoxFit.fitHeight,
                              image: AssetImage('assets/images/jmProfile.jpg')
                          )
                      ),
                    ),
                    Text('Jessan Michael' , style: Styles.usernameStyle,),
                    SizedBox(
                      height: 55,
                      width: 55,
                      child: IconButton(
                        icon: const Icon(Icons.wallet),
                        color: Styles.secondaryColor,
                        iconSize: 40,
                        tooltip: 'Notifications',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const NotificationPage()),
                          );
                        },
                      ) ,
                    ),
                  ],
                ),
              )
          ),
          const Gap(8),
          Expanded(
            child: SizedBox(
              height: size.height*0.3,
              child: Column(
                children: [
                  CarouselSlider(
                    items: imageSliders,
                    carouselController: _slidercontroller,
                    options: CarouselOptions(
                        viewportFraction: 1,
                        autoPlay: true,
                        onPageChanged: (index , reason){
                          setState(() {
                            _slidercurrent = index;
                          });
                        }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: imageSliders.asMap().entries.map((entry) {
                      return GestureDetector(
                        onTap: () => _slidercontroller.animateToPage(entry.key),
                        child: Container(
                          width: 12.0,
                          height: 12.0,
                          margin: const EdgeInsets.symmetric(vertical: 8 , horizontal: 8),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: (Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black).withOpacity(_slidercurrent == entry.key? 0.9 : 0.4)
                          ),
                        ),
                      );
                    }).toList(),
                  )
                ],
              ),
            ),
            ),
          const Gap(4),
          Container(
            margin: const EdgeInsets.only(left: 10 , right: 10) ,
            child: Text("JM YA MT THERESIA WA MTOTO YESU MAGOMENI" , style: Styles.headLineStyle2, textAlign: TextAlign.center),
          ),
          const Divider(
            color: Colors.black, //color of divider
            height: 5, //height spacing of divider
            thickness: 2, //thickness of divier line
            indent: 25, //spacing at the start of divider
            endIndent: 25, //spacing at the end of divider
          ),
          const Gap(20),
          Text("Upcoming Events" , style: Styles.headLineStyle3,),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              children: [
                Card(
                  color : Colors.red,
                  child: SizedBox(
                    height: 120,
                    width: size.width*0.5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: 50,
                          height: 120,
                          color: Colors.green,
                          child: Text('31 JUN' , style: Styles.headLineStyle2, textAlign: TextAlign.center),
                        ),
                        VerticalDivider(
                            color: Colors.black, //color of divider
                            width: size.width*0.5, //height spacing of divider
                            thickness: 2, //thickness of divier line
                            indent: 0, //spacing at the start of divider
                            endIndent: 0, //spacing at the end of divider

                        ),
                        Row( children: [
                          Text("Weekly Mass" , )
                        ],)
                      ],
                    ),
                  ),
                ),
                Card(
                  color : Colors.blue,
                  child: SizedBox(
                    height: 120,
                    width: size.width*0.5,
                  ),
                ),
                Card(
                  color : Colors.green,
                  child: SizedBox(
                    height: 120,
                    width: size.width*0.5,
                  ),
                ),
              ],
            ),
          )
        ],
      )
    );
  }
}
