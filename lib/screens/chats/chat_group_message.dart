import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../models/ChatMessage.dart';
import '../../util/app_colors.dart';

class ChatGroupMessage extends StatefulWidget {
  const ChatGroupMessage({Key? key}) : super(key: key);

  @override
  State<ChatGroupMessage> createState() => _ChatGroupMessageState();
}

class _ChatGroupMessageState extends State<ChatGroupMessage> {
  List<ChatMessage> messages = [
    ChatMessage(messageContent: "Hello, Will", messageType: "receiver" ,created_at: '23:23' , group_id: '2'),
    ChatMessage(messageContent: "How have you been?", messageType: "receiver" , created_at: '23:23' , group_id: '2'),
    ChatMessage(messageContent: "Hey Kriss, I am doing fine dude. wbu?", messageType: "sender" , created_at: '23:23' , group_id: '2'),
    ChatMessage(messageContent: "ehhhh, doing OK.", messageType: "receiver" , created_at: '23:23' , group_id: '2'),
    ChatMessage(messageContent: "Is there any thing wrong? JASJBJASJSJKA JBSJAJS HAIHS KAKJKAJKAJAKAJKAJK", messageType: "sender" , created_at: '23:23' , group_id: '2'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.navyBlue,
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back,color: Colors.white,),
                ),
                // SizedBox(width: 2,),
                // CircleAvatar(
                //   backgroundImage: AssetImage(''),
                //   maxRadius: 20,
                // ),
                SizedBox(width: 12,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Group Chat",style: TextStyle( fontSize: 16 , color: Colors.white,fontWeight: FontWeight.w600),),
                      SizedBox(height: 6,),
                      Text(" 23 Online",style: TextStyle(color: Colors.white,  fontSize: 13),),
                    ],
                  ),
                ),
                Icon(Icons.groups,color: Colors.white,),
              ],
            ),
          ),
        ),
      ),
      body:
      Stack(
        children: <Widget>[
          ListView.builder(
            itemCount: messages.length,
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 10,bottom: 10),
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index){
              return Column(
                children: [
                  Padding(padding: EdgeInsets.only(left: 30,right: 14,top: 5,bottom: 0) ,
                    child :
                    Align(
                      alignment: (messages[index].messageType == "receiver"?Alignment.topLeft:Alignment.topRight),
                      child: (messages[index].messageType == "receiver"? Text('Jessan J' , style: TextStyle(fontWeight: FontWeight.bold),) : Text('')) ,
                    ),
                  ),

                  Container(
                  padding: EdgeInsets.only(left: 14,right: 14,top: 1,bottom: 10),
                  child: Align(
                  alignment: (messages[index].messageType == "receiver"?Alignment.topLeft:Alignment.topRight),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: (messages[index].messageType  == "receiver"?Colors.grey.shade200:Colors.blue[200]),
                    ),
                    padding: EdgeInsets.all(16),
                    child: Text(messages[index].messageContent, style: TextStyle(fontSize: 15),),
                  ),
                  ),
                  ),
                  Padding( padding: EdgeInsets.only(left: 30 , right: 14) ,
                      child :Align(
              alignment: (messages[index].messageType == "receiver"?Alignment.bottomLeft:Alignment.bottomRight),
              child: Text('20:23'),
              ),

                  ),
                    ],
              );
            },
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(left: 10,bottom: 10,top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(Icons.add, color: Colors.white, size: 20, ),
                    ),
                  ),
                  SizedBox(width: 15,),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: "Write message...",
                          hintStyle: TextStyle(color: Colors.black54),
                          border: InputBorder.none
                      ),
                    ),
                  ),
                  SizedBox(width: 15,),
                  FloatingActionButton(
                    onPressed: (){},
                    child: Icon(Icons.send,color: Colors.white,size: 18,),
                    backgroundColor: Colors.blue,
                    elevation: 0,
                  ),
                ],

              ),
            ),
          ),
        ],
      ),
    );
  }
}
