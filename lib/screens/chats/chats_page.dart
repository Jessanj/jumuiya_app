import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:jumuiya_app/util/app_colors.dart';

import '../../models/ChartUser.dart';
import '../bottom_nav.dart';
import '../explore_page.dart';
import '../home_page.dart';
import '../members_page.dart';
import '../schedule_page.dart';
import '../user_profile_page.dart';
import 'conversation_list.dart';


class ChatsPage extends StatefulWidget {
  const ChatsPage({Key? key}) : super(key: key);

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {

  List<ChatUsers> chatUsers = [
    ChatUsers(name: "Jane Russel", messageText: "Awesome Setup", imageURL: "https://picsum.photos/250?image=9", time: "Now"),
    ChatUsers(name: "Glady's Murphy", messageText: "That's Great", imageURL: "https://picsum.photos/250?image=9", time: "Yesterday"),
    ChatUsers(name: "Jorge Henry", messageText: "Hey where are you?", imageURL: "https://picsum.photos/250?image=9", time: "31 Mar"),
    ChatUsers(name: "Philip Fox", messageText: "Busy! Call me in 20 mins", imageURL: "https://picsum.photos/250?image=9", time: "28 Mar"),
    ChatUsers(name: "Debra Hawkins", messageText: "Thankyou, It's awesome", imageURL: "https://picsum.photos/250?image=9", time: "23 Mar"),
    ChatUsers(name: "Jacob Pena", messageText: "will update you in evening", imageURL: "https://picsum.photos/250?image=9", time: "17 Mar"),
    ChatUsers(name: "Andrey Jones", messageText: "Can you please share the file?", imageURL: "https://picsum.photos/250?image=9", time: "24 Feb"),
    ChatUsers(name: "John Wick", messageText: "How are you?", imageURL: "https://picsum.photos/250?image=9", time: "18 Feb"),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body:  SingleChildScrollView(
       physics: BouncingScrollPhysics(),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: <Widget>[
           SafeArea(
             child: Padding(
               padding: EdgeInsets.only(left: 16,right: 16,top: 10),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: <Widget>[
                   Text("Conversations",style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold),),
                   Container(
                     padding: EdgeInsets.only(left: 8,right: 8,top: 2,bottom: 2),
                     height: 30,
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(30),
                       color: Color(0xFF687daf),
                     ),
                     child: Row(
                       children: <Widget>[
                         Icon(Icons.add,color: AppColors.navyBlue ,size: 20,),
                         SizedBox(width: 2,),
                         Text("Add New",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                       ],
                     ),
                   ),
                 ],
               ),
             ),
           ),
           Padding(
             padding: EdgeInsets.only(top: 16,left: 16,right: 16),
             child: TextField(
               decoration: InputDecoration(
                 hintText: "Search...",
                 hintStyle: TextStyle(color: Colors.grey.shade600),
                 prefixIcon: Icon(Icons.search,color: Colors.grey.shade600, size: 20,),
                 filled: true,
                 fillColor: Colors.grey.shade100,
                 contentPadding: EdgeInsets.all(8),
                 enabledBorder: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(20),
                     borderSide: BorderSide(
                         color: Colors.grey.shade100
                     )
                 ),
               ),
             ),
           ),
           Column(
             children: [
               ListView.builder(
                 itemCount: chatUsers.length,
                 shrinkWrap: true,
                 padding: EdgeInsets.only(top: 16),
                 physics: NeverScrollableScrollPhysics(),
                 itemBuilder: (context, index){
                   return ConversationList(
                     name: chatUsers[index].name,
                     messageText: chatUsers[index].messageText,
                     imageUrl: chatUsers[index].imageURL,
                     time: chatUsers[index].time,
                     isMessageRead: (index == 0 || index == 3)?true:false,
                   );
                 },
               )
             ],
           )
         ],
       ),
     ),
    );
  }
}
