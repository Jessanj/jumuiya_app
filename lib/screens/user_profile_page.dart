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
            Column(
              children: [
                Positioned(
                  top: 50,
                  bottom: 50,
                  left: size.width*0.5,
                  right: size.width*0.5,
                  child: Container(
                    height: 85,
                    width: 74,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                        image: const DecorationImage(
                            fit: BoxFit.fitHeight,
                            image: AssetImage('assets/images/jmProfile.jpg')
                        )
                    ),
                  ),
                ),
                Positioned(
                    child: Container(
                      height: 150 ,
                      width: size.width,
                      decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(30)
                      ),
                    ),
                ),
                ],
            ),


          ],
        )
    );
  }
}
