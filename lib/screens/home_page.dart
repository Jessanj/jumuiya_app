
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:jumuiya_app/Helpers/api_services.dart';
import 'package:jumuiya_app/screens/Transaction/create_payment_page.dart';
import 'package:jumuiya_app/screens/notifications_page.dart';
import 'package:jumuiya_app/screens/reg_groups/register_jumuiya_page.dart';
import 'package:jumuiya_app/screens/shares_page.dart';
import 'package:jumuiya_app/util/app_layouts.dart';
import 'package:jumuiya_app/util/app_styles.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/event.dart';
import '../util/app_colors.dart';
import '../widgets/left_drawer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'contribution_page.dart';
import 'login_page.dart';

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

   Future? _events;
   Future? _attendance;
   Future? _billboard;
  @override
  void initState() {
    super.initState();
    fetchBillboards();
    _events = fetchEvents();
    _attendance = fetchAttendance();
    _billboard = fetchBillboards();
    checkJumuiya();
  }
  int _slidercurrent = 0;
  final CarouselController _slidercontroller = CarouselController();
  Map<String , dynamic> billboardData = {} ;

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
    'together_image.jpg',
    'networking_image.jpg',
    'stay_connected.jpg',
    'tree_money.jpg'
  ];

  void checkJumuiya() async {
    final prefs = await SharedPreferences.getInstance();
    var id = prefs.getInt('userId');
    var group;
     id == null ? Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage()))  :
     group = await  ApiService.getUserGroup(id);
    if(group == 'failed'){
      if(group.length <= 0 || true ){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const RegisterJumuiyaPage())) ;
      }
    }else{

    }
  }
   String get_date_from_string(DateTime parseDate , String format) {
     // Define the date format string.
     String date_format = format;

     // Create a DateFormat object with the date format string.
     String data  = DateFormat(date_format).format(parseDate).toString();

     // Return the date.
     return data;
   }

  Future fetchBillboards() async {

  }

  Future fetchAttendance() async{

    var eventData = await ApiService.getMonthEvent();
    return eventData;
  }

   Future fetchEvents() async{
      // var eventData = await ApiService.getEvents();
      // return eventData;
   }
  
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
    Locale myLocale = Localizations.localeOf(context);

    print(myLocale);

    return  Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.navyBlue,
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
            // const Gap(6),
            // Card(
            //     child: SizedBox(
            //       height: 65,
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         crossAxisAlignment: CrossAxisAlignment.center,
            //         children:  [
            //           Container(
            //             height: 60,
            //             width: 60,
            //             decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(30),
            //                 image: const DecorationImage(
            //                     fit: BoxFit.fitHeight,
            //                     image: AssetImage('assets/images/jmProfile.jpg')
            //                 )
            //             ),
            //           ),
            //           Text("JESSAN MICHAEL", style: Styles.usernameStyle,),
            //           SizedBox(
            //             height: 55,
            //             width: 55,
            //             child: IconButton(
            //               icon: const Icon(Icons.wallet),
            //               color: Styles.secondaryColor,
            //               iconSize: 40,
            //               tooltip: 'Notifications',
            //               onPressed: () {
            //                 Navigator.push(
            //                   context,
            //                   MaterialPageRoute(builder: (context) => const NotificationPage()),
            //                 );
            //               },
            //             ) ,
            //           ),
            //         ],
            //       ),
            //     )
            // ),

            const Gap(6),
            FutureBuilder(future: _billboard, builder: (context , billboards){
              if(billboards.hasData){
                return SizedBox(
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
                );
              }else{
                return SizedBox(
                  height: size.height * 0.3,
                  child: Stack(
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
                      Positioned(
                          top: size.height* 0.1,
                          left: size.width*0.45,
                          child: SizedBox(
                            height : 35,
                            width: 35,
                            child: CircularProgressIndicator(),
                          )
                      ),
                      Positioned(
                          bottom: 10,
                          left: size.width * 0.1,
                          right: size.width * 0.1,
                          child:
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
                      )


                    ],
                  ),
                );
              }
            }),
            const Gap(4),
            FutureBuilder(future: fetchBillboards(), builder: (context , groupData){
              if(groupData.hasData){
                return Container(
                  margin: const EdgeInsets.only(left: 10 , right: 10) ,
                  child: Text("JM YA MT THERESIA WA MTOTO YESU MAGOMENI" , style: Styles.headLineStyle2, textAlign: TextAlign.center),
                );
              }else{
                return Container(
                  margin: const EdgeInsets.only(left: 10 , right: 10) ,
                  child: Text(AppLocalizations.of(context)!.no_group_attached +' ('+ AppLocalizations.of(context)!.pending_for_approval +' )' , style: Styles.headLineStyle2, textAlign: TextAlign.center),
                );
              }
            }),

            const Divider(
              color: Colors.black, //color of divider
              height: 5, //height spacing of divider
              thickness: 2, //thickness of divier line
              indent: 25, //spacing at the start of divider
              endIndent: 25, //spacing at the end of divider
            ),
            const Gap(20),
            Text(AppLocalizations.of(context)!.upcoming_events, style: Styles.headLineStyle6, ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 10 , top: 5 , right: 10),
              child: FutureBuilder(
                future:  _events,
                builder: (context , events){
                  if(events.hasData){
                    List<Widget> eventWidget = [];
                    for(Event event in events.data){
                      eventWidget.add(
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
                                    Flexible(
                                      child: Text( event.title,
                                        style: const TextStyle(
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    )
                                  ],
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Card(
                                      color: Colors.green,
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text( get_date_from_string(DateTime.parse(event.startDate.toString()) , 'dd'), style: Styles.headLineStyle2w,) ,
                                            Text(get_date_from_string(DateTime.parse(event.startDate.toString()) , 'MMM') , style: Styles.headLineStyle2w,) ,
                                          ],
                                        ),
                                      ),
                                    ),
                                    const Gap(5),
                                    Flexible(
                                        child: Text( event.description!.toString(),
                                          style: const TextStyle(
                                              fontFamily: "Poppins",
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 4,
                                        )
                                    )
                                  ],
                                ),

                              ]
                          ),
                        )
                      );
                    }
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: eventWidget,
                    );
                  }else{
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.only(right: 5),
                          height: 120,
                          width: size.width*0.5,
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          decoration: const BoxDecoration(
                              color: AppColors.lightNavyBlue,
                              borderRadius: BorderRadius.vertical(bottom: Radius.circular(10) , top: Radius.circular(10) )
                          ),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      child: Text(AppLocalizations.of(context)!.get_started_event,
                                        style: const TextStyle(
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    )
                                  ],
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Card(
                                      color: Colors.green,
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(DateTime.now().day.toString(), style: Styles.headLineStyle2w,) ,
                                            Text (DateFormat.MMM().format(DateTime.now()).toString() , style: Styles.headLineStyle2w,) ,
                                          ],
                                        ),
                                      ),
                                    ),
                                    const Gap(5),
                                    Flexible(
                                        child: Text(
                                          "ibada  itaanza saa 2 kamlli  wahini wote hcgh",
                                          style: const TextStyle(
                                              fontFamily: "Poppins",
                                              fontWeight: FontWeight.w500,
                                              fontSize: 13
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 4,
                                        )
                                    )
                                  ],
                                ),

                              ]
                          ),
                        ),
                        Container(
                          width: 6.0,
                          height: 6.0,
                          margin: const EdgeInsets.symmetric(vertical: 1 , horizontal: 1),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: (Colors.black).withOpacity(0.4)
                          ),
                        ),
                        Container(
                          width: 6.0,
                          height: 6.0,
                          margin: const EdgeInsets.symmetric(vertical: 1 , horizontal: 1),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: (Colors.black).withOpacity(0.4)
                          ),
                        ),
                        Container(
                          width: 6.0,
                          height: 6.0,
                          margin: const EdgeInsets.symmetric(vertical: 1 , horizontal: 1),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: (Colors.black).withOpacity(0.4)
                          ),
                        ),
                        Container(
                          width: 6.0,
                          height: 6.0,
                          margin: const EdgeInsets.symmetric(vertical: 1 , horizontal: 1),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: (Colors.green).withOpacity(1)
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.only(right: 5),
                          height: 120,
                          width: size.width*0.5,
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          decoration: const BoxDecoration(
                              color: AppColors.lightNavyBlue,
                              borderRadius: BorderRadius.vertical(bottom: Radius.circular(10) , top: Radius.circular(10) )
                          ),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      child: Text(AppLocalizations.of(context)!.title_of_the_event,
                                        style: const TextStyle(
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    )
                                  ],
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Card(
                                      color: Colors.green,
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(DateTime.now().day.toString(), style: Styles.headLineStyle2w,) ,
                                            Text (DateFormat.MMM().format(DateTime.now()).toString() , style: Styles.headLineStyle2w,) ,
                                          ],
                                        ),
                                      ),
                                    ),
                                    const Gap(5),
                                    Flexible(
                                        child: Text( AppLocalizations.of(context)!.desc_message,
                                          style: const TextStyle(
                                              fontFamily: "Poppins",
                                              fontWeight: FontWeight.w500,
                                              fontSize: 13
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 4,
                                        )
                                    )
                                  ],
                                ),

                              ]
                          ),
                        ),
                      ],
                    );
                  }

                },
              ) ,
            ),
            const Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(AppLocalizations.of(context)!.donate, style: Styles.headLineStyle6,),

                      Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              color : Colors.blue,
                              child: InkWell(
                                onTap: (){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) =>  const CreatePaymentPage()),
                                  );
                                }, child: SizedBox(
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
                              ),) ,
                            ),

                  ],
                ),
                Column(
                  children: [
                    Text(AppLocalizations.of(context)!.contribute, style: Styles.headLineStyle6,),
                     Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        color : Colors.blue,
                        child: InkWell(
                          onTap: () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const ContributionPage()),
                            ),
                          },
                          child:
                          SizedBox(
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
                        ),),
                      ),
                  ],
                ),
                Column(
                  children: [
                    Text(AppLocalizations.of(context)!.share, style: Styles.headLineStyle6,),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      color : Colors.blue,
                      child: InkWell(
                        onTap: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const SharesPage()),
                          ),
                        },
                        child:
                      SizedBox(
                        height: 50,
                        width: 90,
                        child: Container(
                            alignment: Alignment.center,
                            child: Card(
                              color: Colors.green,
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Icon(Icons.monetization_on , size: 35, color: Colors.white,)  ,
                              ),
                            )
                        ),
                      ), ),
                    ),
                  ],
                ),
              ],
            ),
            const Gap(10),
            Text(AppLocalizations.of(context)!.meeting_attendance , style: Styles.headLineStyle6, ),
            const Gap(5),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: FutureBuilder(future: _attendance, builder: (context , attendances){
                if(attendances.hasData && attendances.data.isNotEmpty){
                  List<Widget> attendanceWidgets = [];
                  for (Map<String , dynamic> attendance in attendances.data) {
                    attendanceWidgets.add(
                      Padding(padding: EdgeInsets.only( left: 8),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 195,
                              width: 115,
                              child: Container(
                                  decoration : BoxDecoration(
                                    color: AppColors.lightNavyBlue,
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: const LinearGradient(
                                      colors: [AppColors.attendanceBlue, AppColors.attendanceDBlue],
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                    ),
                                  ),
                                  padding: const EdgeInsets.all(3),
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: [
                                      const Gap(5),
                                      Row(
                                        children: [
                                          Icon(Icons.event , color: Colors.green, size: 18,),
                                          Gap(3),
                                          Text( get_date_from_string( DateTime.parse(attendance['startDate'].toString()), 'dd MMM yyyy'), style: TextStyle(fontWeight: FontWeight.bold , color: Colors.white)),
                                        ],
                                      ),
                                      const Gap(5),
                                      const Divider(
                                        color: Colors.black, //color of divider
                                        height: 2, //height spacing of divider
                                        thickness: 2, //thickness of divier line
                                        indent: 0, //spacing at the start of divider
                                        endIndent: 0, //spacing at the end of divider
                                      ),
                                      Column(
                                        children: [
                                          Text(AppLocalizations.of(context)!.present , style: TextStyle(fontWeight: FontWeight.bold , color: Colors.white)),
                                          Gap(5),
                                          Text( attendance['present'].toString(), style: TextStyle(fontWeight: FontWeight.bold , fontSize: 18),)
                                        ],
                                      ),
                                      const Divider(
                                        color: Colors.black, //color of divider
                                        height: 2, //height spacing of divider
                                        thickness: 2, //thickness of divier line
                                        indent: 0, //spacing at the start of divider
                                        endIndent: 0, //spacing at the end of divider
                                      ),
                                      Column(
                                        children: [
                                          Text(AppLocalizations.of(context)!.absent , style: TextStyle(fontWeight: FontWeight.bold , color: Colors.white)),
                                          Gap(5),
                                          Text( attendance['absent'].toString(), style: TextStyle(fontWeight: FontWeight.bold , fontSize: 18),)
                                        ],
                                      ),
                                      const Divider(
                                        color: Colors.black, //color of divider
                                        height: 2, //height spacing of divider
                                        thickness: 2, //thickness of divier line
                                        indent: 0, //spacing at the start of divider
                                        endIndent: 0, //spacing at the end of divider
                                      ),
                                      Column(
                                        children: [
                                          Text(AppLocalizations.of(context)!.guest , style: TextStyle(fontWeight: FontWeight.bold , color: Colors.white)),
                                          Gap(5),
                                          Text( attendance['is_guest'].toString(), style: TextStyle(fontWeight: FontWeight.bold , fontSize: 18),)
                                        ],
                                      ),
                                    ],
                                  )
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: attendanceWidgets,
                  );
                }else{
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(padding: EdgeInsets.only( left: 8),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 195,
                              width: 110,
                              child: Container(
                                  decoration : BoxDecoration(
                                    color: AppColors.lightNavyBlue,
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: const LinearGradient(
                                      colors: [AppColors.attendanceBlue, AppColors.attendanceDBlue],
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                    ),
                                  ),
                                  padding: const EdgeInsets.all(3),
                                  alignment: Alignment.center,
                                  child: Column(
                                    mainAxisAlignment : MainAxisAlignment.center,
                                    children: [
                                     Text(AppLocalizations.of(context)!.getStarted , style: TextStyle(fontSize : 18 ,fontWeight: FontWeight.bold , color: Colors.white)),
                                      Text(AppLocalizations.of(context)!.record , style: TextStyle(fontWeight: FontWeight.bold),),
                                      Text(AppLocalizations.of(context)!.attendance , style: TextStyle(fontWeight: FontWeight.bold),),
                                      Text(AppLocalizations.of(context)!.for_ , style: TextStyle(fontWeight: FontWeight.bold),),
                                      Text(AppLocalizations.of(context)!.events , style: TextStyle(fontWeight: FontWeight.bold),),

                                    ],
                                  )
                              ),
                            )
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 8.0,
                            height: 8.0,
                            margin: const EdgeInsets.symmetric(vertical: 2 , horizontal: 2),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: (Colors.black).withOpacity(0.4)
                            ),
                          ),
                          Container(
                            width: 8.0,
                            height: 8.0,
                            margin: const EdgeInsets.symmetric(vertical: 2 , horizontal: 2),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: (Colors.black).withOpacity(0.4)
                            ),
                          ),
                          Container(
                            width: 8.0,
                            height: 8.0,
                            margin: const EdgeInsets.symmetric(vertical: 2 , horizontal: 2),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: (Colors.black).withOpacity(0.4)
                            ),
                          ),
                          Container(
                            width: 8.0,
                            height: 8.0,
                            margin: const EdgeInsets.symmetric(vertical: 2 , horizontal: 2),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: (Colors.green).withOpacity(1)
                            ),
                          ),
                        ],
                      ),
                      Padding(padding: EdgeInsets.only( left: 2),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 195,
                              width: 110,
                              child: Container(
                                  decoration : BoxDecoration(
                                    color: AppColors.lightNavyBlue,
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: const LinearGradient(
                                      colors: [AppColors.attendanceBlue, AppColors.attendanceDBlue],
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                    ),
                                  ),
                                  padding: const EdgeInsets.all(3),
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: [
                                      const Gap(5),
                                      Row(
                                        children: [
                                          Icon(Icons.event , color: Colors.green, size: 18,),
                                          Gap(3),
                                          Text( get_date_from_string(DateTime.now() , 'd MMM yyyy'), style: TextStyle(fontWeight: FontWeight.bold , color: Colors.white)),
                                        ],
                                      ),
                                      const Gap(5),
                                      const Divider(
                                        color: Colors.black, //color of divider
                                        height: 2, //height spacing of divider
                                        thickness: 2, //thickness of divier line
                                        indent: 0, //spacing at the start of divider
                                        endIndent: 0, //spacing at the end of divider
                                      ),
                                      Column(
                                        children: [
                                          Text(AppLocalizations.of(context)!.present , style: TextStyle(fontWeight: FontWeight.bold , color: Colors.white)),
                                          Gap(5),
                                          Text( '0', style: TextStyle(fontWeight: FontWeight.bold , fontSize: 18),)
                                        ],
                                      ),
                                      const Divider(
                                        color: Colors.black, //color of divider
                                        height: 2, //height spacing of divider
                                        thickness: 2, //thickness of divier line
                                        indent: 0, //spacing at the start of divider
                                        endIndent: 0, //spacing at the end of divider
                                      ),
                                      Column(
                                        children: [
                                          Text(AppLocalizations.of(context)!.absent , style: TextStyle(fontWeight: FontWeight.bold , color: Colors.white)),
                                          Gap(5),
                                          Text( '0', style: TextStyle(fontWeight: FontWeight.bold , fontSize: 18),)
                                        ],
                                      ),
                                      const Divider(
                                        color: Colors.black, //color of divider
                                        height: 2, //height spacing of divider
                                        thickness: 2, //thickness of divier line
                                        indent: 0, //spacing at the start of divider
                                        endIndent: 0, //spacing at the end of divider
                                      ),
                                      Column(
                                        children: [
                                          Text(AppLocalizations.of(context)!.guest, style: TextStyle(fontWeight: FontWeight.bold , color: Colors.white)),
                                          Gap(5),
                                          Text( '0', style: TextStyle(fontWeight: FontWeight.bold , fontSize: 18),)
                                        ],
                                      ),
                                    ],
                                  )
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  );
                }
              })
            ),
            const Gap(20),
          ],
        )
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
}
