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
        scrollDirection: Axis.vertical,
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
          Text("Upcoming Events" , style: Styles.headLineStyle6, ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 10 , top: 5 , right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(right: 5),
                  height: 120,
                  width: size.width*0.5,
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  decoration: const BoxDecoration(
                      color: Colors.lightBlueAccent,
                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(10) , top: Radius.circular(10) )
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 2 , right: 2),
                              child: Text(
                                "Weekly Mass",
                                style: const TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                ),
                              ),
                            )
                          ],
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                                height: 80,
                                alignment: Alignment.center,
                                child: Card(
                                  color: Colors.green,
                                  child: Padding(
                                    padding: const EdgeInsets.all(2),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('14' , style: Styles.headLineStyle2w,) ,
                                        Text('JUN' , style: Styles.headLineStyle2w,) ,
                                      ],
                                    ),
                                  ),
                                )
                            ),
                            const Gap(5),
                            Expanded(
                                child: Text(
                                  "ibada  itaanza saa 2 kamlli  wahini wote.",
                                  style: const TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14
                                  ),
                                )
                            )
                          ],
                        ),

                      ]
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(right: 5),
                  height: 120,
                  width: size.width*0.5,
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  decoration: const BoxDecoration(
                      color: Colors.lightBlueAccent,
                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(10) , top: Radius.circular(10) )
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 2 , right: 2),
                              child: Text(
                                "Weekly Mass",
                                style: const TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                ),
                              ),
                            )
                          ],
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                                height: 80,
                                alignment: Alignment.center,
                                child: Card(
                                  color: Colors.green,
                                  child: Padding(
                                    padding: const EdgeInsets.all(2),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('14' , style: Styles.headLineStyle2w,) ,
                                        Text('JUN' , style: Styles.headLineStyle2w,) ,
                                      ],
                                    ),
                                  ),
                                )
                            ),
                            const Gap(5),
                            Expanded(
                                child: Text(
                                  "ibada  itaanza saa 2 kamlli  wahini wote.",
                                  style: const TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14
                                  ),
                                )
                            )
                          ],
                        ),

                      ]
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(right: 5),
                  height: 120,
                  width: size.width*0.5,
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  decoration: const BoxDecoration(
                      color: Colors.lightBlueAccent,
                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(10) , top: Radius.circular(10) )
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 2 , right: 2),
                              child: Text(
                                "Weekly Mass",
                                style: const TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                ),
                              ),
                            )
                          ],
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                                height: 80,
                                alignment: Alignment.center,
                                child: Card(
                                  color: Colors.green,
                                  child: Padding(
                                    padding: const EdgeInsets.all(2),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('14' , style: Styles.headLineStyle2w,) ,
                                        Text('JUN' , style: Styles.headLineStyle2w,) ,
                                      ],
                                    ),
                                  ),
                                )
                            ),
                            const Gap(5),
                            Expanded(
                                child: Text(
                                  "ibada  itaanza saa 2 kamlli  wahini wote.",
                                  style: const TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14
                                  ),
                                )
                            )
                          ],
                        ),

                      ]
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(right: 5),
                  height: 120,
                  width: size.width*0.5,
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  decoration: const BoxDecoration(
                      color: Colors.lightBlueAccent,
                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(10) , top: Radius.circular(10) )
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 2 , right: 2),
                              child: Text(
                                "Weekly Mass",
                                style: const TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                ),
                              ),
                            )
                          ],
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                                height: 80,
                                alignment: Alignment.center,
                                child: Card(
                                  color: Colors.green,
                                  child: Padding(
                                    padding: const EdgeInsets.all(2),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('14' , style: Styles.headLineStyle2w,) ,
                                        Text('JUN' , style: Styles.headLineStyle2w,) ,
                                      ],
                                    ),
                                  ),
                                )
                            ),
                            const Gap(5),
                            Expanded(
                                child: Text(
                                  "ibada  itaanza saa 2 kamlli  wahini wote.",
                                  style: const TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14
                                  ),
                                )
                            )
                          ],
                        ),

                      ]
                  ),
                ),
              ],
            ),
          ),
          const Gap(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text("Donate", style: Styles.headLineStyle6,),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color : Colors.blue,
                    child: SizedBox(
                      height: 50,
                      width: 90,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        height: 15,
                        width: 15,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                fit: BoxFit.fitHeight,
                                image: AssetImage('assets/images/donatelove.png')
                            )
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text("Contribute", style: Styles.headLineStyle6,),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color : Colors.blue,
                    child: SizedBox(
                      height: 50,
                      width: 90,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        height: 15,
                        width: 15,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                fit: BoxFit.fitHeight,
                                image: AssetImage('assets/images/coin.png')
                            )
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text("Shares", style: Styles.headLineStyle6,),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color : Colors.blue,
                    child: SizedBox(
                      height: 50,
                      width: 90,
                      child: Container(
                        alignment: Alignment.center,
                        child: Card(
                          color: Colors.green,
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Text('14' , style: Styles.headLineStyle1w,) ,
                          ), 
                        )
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Gap(10),
          Text("Meeting Attendance" , style: Styles.headLineStyle6, ),
          const Gap(5),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color : Colors.grey.shade500,
                      child: SizedBox(
                        height: 149,
                        width: 100,
                        child: Container(
                            padding: const EdgeInsets.all(3),
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  width: 100,
                                  color: Colors.green,
                                  child: Text('12 JUN' , style: Styles.headLineStyle2,),
                                ),
                                const Divider(
                                  color: Colors.black, //color of divider
                                  height: 2, //height spacing of divider
                                  thickness: 2, //thickness of divier line
                                  indent: 0, //spacing at the start of divider
                                  endIndent: 0, //spacing at the end of divider
                                ),
                                Text("Family" , style: Styles.headLineStyle7,),
                                const Gap(5),
                                Text("20"),
                                const Divider(
                                  color: Colors.black, //color of divider
                                  height: 2, //height spacing of divider
                                  thickness: 2, //thickness of divier line
                                  indent: 0, //spacing at the start of divider
                                  endIndent: 0, //spacing at the end of divider
                                ),
                                Text("Members" , style: Styles.headLineStyle7,),
                                const Gap(5),
                                Text("200"),
                                const Divider(
                                  color: Colors.black, //color of divider
                                  height: 2, //height spacing of divider
                                  thickness: 2, //thickness of divier line
                                  indent: 0, //spacing at the start of divider
                                  endIndent: 0, //spacing at the end of divider
                                ),
                                Text("New" , style: Styles.headLineStyle7,),
                                Text("5")
                              ],
                            )
                        ),
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color : Colors.grey.shade500,
                      child: SizedBox(
                        height: 149,
                        width: 100,
                        child: Container(
                            padding: const EdgeInsets.all(3),
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  width: 100,
                                  color: Colors.green,
                                  child: Text('17 JUN' , style: Styles.headLineStyle2,),
                                ),
                                const Divider(
                                  color: Colors.black, //color of divider
                                  height: 2, //height spacing of divider
                                  thickness: 2, //thickness of divier line
                                  indent: 0, //spacing at the start of divider
                                  endIndent: 0, //spacing at the end of divider
                                ),
                                Text("Family" , style: Styles.headLineStyle7,),
                                const Gap(5),
                                Text("2"),
                                const Divider(
                                  color: Colors.black, //color of divider
                                  height: 2, //height spacing of divider
                                  thickness: 2, //thickness of divier line
                                  indent: 0, //spacing at the start of divider
                                  endIndent: 0, //spacing at the end of divider
                                ),
                                Text("Members" , style: Styles.headLineStyle7,),
                                const Gap(5),
                                Text("20"),
                                const Divider(
                                  color: Colors.black, //color of divider
                                  height: 2, //height spacing of divider
                                  thickness: 2, //thickness of divier line
                                  indent: 0, //spacing at the start of divider
                                  endIndent: 0, //spacing at the end of divider
                                ),
                                Text("New" , style: Styles.headLineStyle7,),
                                Text("1")

                              ],
                            )
                        ),
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color : Colors.grey.shade500,
                      child: SizedBox(
                        height: 149,
                        width: 100,
                        child: Container(
                            padding: const EdgeInsets.all(3),
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  width: 100,
                                  color: Colors.green,
                                  child: Text('01 JUl' , style: Styles.headLineStyle2,),
                                ),
                                const Divider(
                                  color: Colors.black, //color of divider
                                  height: 2, //height spacing of divider
                                  thickness: 2, //thickness of divier line
                                  indent: 0, //spacing at the start of divider
                                  endIndent: 0, //spacing at the end of divider
                                ),
                                Text("Family" , style: Styles.headLineStyle7,),
                                const Gap(5),
                                Text("5"),
                                const Divider(
                                  color: Colors.black, //color of divider
                                  height: 2, //height spacing of divider
                                  thickness: 2, //thickness of divier line
                                  indent: 0, //spacing at the start of divider
                                  endIndent: 0, //spacing at the end of divider
                                ),
                                Text("Members" , style: Styles.headLineStyle7,),
                                const Gap(5),
                                Text("10"),
                                const Divider(
                                  color: Colors.black, //color of divider
                                  height: 2, //height spacing of divider
                                  thickness: 2, //thickness of divier line
                                  indent: 0, //spacing at the start of divider
                                  endIndent: 0, //spacing at the end of divider
                                ),
                                Text("New" , style: Styles.headLineStyle7,),
                                Text("3")

                              ],
                            )
                        ),
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color : Colors.grey.shade500,
                      child: SizedBox(
                        height: 149,
                        width: 100,
                        child: Container(
                            padding: const EdgeInsets.all(3),
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  width: 100,
                                  color: Colors.green,
                                  child: Text('06 AUG' , style: Styles.headLineStyle2,),
                                ),
                                const Divider(
                                  color: Colors.black, //color of divider
                                  height: 2, //height spacing of divider
                                  thickness: 2, //thickness of divier line
                                  indent: 0, //spacing at the start of divider
                                  endIndent: 0, //spacing at the end of divider
                                ),
                                Text("Family" , style: Styles.headLineStyle7,),
                                const Gap(5),
                                Text("10"),
                                const Divider(
                                  color: Colors.black, //color of divider
                                  height: 2, //height spacing of divider
                                  thickness: 2, //thickness of divier line
                                  indent: 0, //spacing at the start of divider
                                  endIndent: 0, //spacing at the end of divider
                                ),
                                Text("Members" , style: Styles.headLineStyle7,),
                                const Gap(5),
                                Text("20"),
                                const Divider(
                                  color: Colors.black, //color of divider
                                  height: 2, //height spacing of divider
                                  thickness: 2, //thickness of divier line
                                  indent: 0, //spacing at the start of divider
                                  endIndent: 0, //spacing at the end of divider
                                ),
                                Text("New" , style: Styles.headLineStyle7,),
                                Text("5")

                              ],
                            )
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      )
    );
  }
}
