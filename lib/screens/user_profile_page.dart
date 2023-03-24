import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:jumuiya_app/util/app_layouts.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  OverlayEntry ? overlayEntry ;
  @override
  Widget build(BuildContext context) {
    final size = AppLayouts.getSize(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('My Profile'),
        ),
        body: 
        ListView(

          children: [
            Stack(
                  children: [
                    Align(
                      alignment: AlignmentDirectional.center,
                      child: Container(
                        margin: EdgeInsets.only(top: 40),
                        width: size.width,
                        height: 200,
                        decoration: BoxDecoration(
                                  color: Colors.black12,
                                  borderRadius: BorderRadius.circular(30)
                              ),
                        child: Column(
                          children: [
                              Padding(padding: EdgeInsets.only(top: 60),
                                child: Text('Jessan Michael' , style: TextStyle(fontSize: 24 , fontWeight: FontWeight.bold , ),)
                              ),
                            Text('Level 1'),
                            const Gap(15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 50),
                                  alignment: Alignment.center,
                                  width: 100,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.lightBlueAccent,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text('1000' , style: TextStyle(fontSize: 23 , fontWeight: FontWeight.bold , color: Colors.white),),
                                ),
                                Container(
                                  margin: EdgeInsets.only(right: 50),
                                  alignment: Alignment.center,
                                  width: 100,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.lightBlueAccent,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text('10' , style: TextStyle(fontSize: 23 , fontWeight: FontWeight.bold , color: Colors.white),),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 50),
                                  alignment: Alignment.center,
                                  width: 100,
                                  child: Text('Balance' , style: TextStyle(fontSize: 15 , fontWeight: FontWeight.bold , color: Colors.black38),),
                                ),
                                Container(
                                  margin: EdgeInsets.only(right: 50),
                                  alignment: Alignment.center,
                                  width: 100,
                                  child: Text('Shares' , style: TextStyle(fontSize: 15 , fontWeight: FontWeight.bold , color: Colors.black38),),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),


                    ),
                    Positioned(
                      right: size.width*0.4,
                      left: size.width*0.4,
                      top: 10,
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(60),
                            image: const DecorationImage(
                                image: AssetImage('assets/images/jmProfile.jpg')
                            )
                        ),

                      ),
                    ),
                    Positioned(
                        top: 50,
                        right: 30,
                        child: ElevatedButton(onPressed: () {},
                          style:ButtonStyle() ,
                          child: Text('Edit'),
                        ),
                    ),

                  ],
                ),
            const Gap(20),
            Container(
              height: 200,
              width: 10,
              decoration: BoxDecoration(
                color: Colors.black38,
                borderRadius: BorderRadius.circular(30)
              ),
              child: Column(

              ),
            )

          ],
        )
    );
  }
}
