import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../screens/member_detail.dart';
import '../util/app_styles.dart';
class MembersList extends StatelessWidget {
  const MembersList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.only(left: 8, right: 8),
        children: [
          const Gap(10),
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
                        icon: const Icon(Icons.arrow_forward),
                        color: Styles.secondaryColor,
                        iconSize: 30,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const MemberDetail()),
                          );
                        },
                      ) ,
                    ),
                  ],
                ),
              )
          ),
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
                        icon: const Icon(Icons.arrow_forward),
                        color: Styles.secondaryColor,
                        iconSize: 30,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const MemberDetail()),
                          );
                        },
                      ) ,
                    ),
                  ],
                ),
              )
          ),Card(
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
                        icon: const Icon(Icons.arrow_forward),
                        color: Styles.secondaryColor,
                        iconSize: 30,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const MemberDetail()),
                          );
                        },
                      ) ,
                    ),
                  ],
                ),
              )
          ),Card(
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
                        icon: const Icon(Icons.arrow_forward),
                        color: Styles.secondaryColor,
                        iconSize: 30,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const MemberDetail()),
                          );
                        },
                      ) ,
                    ),
                  ],
                ),
              )
          ),Card(
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
                        icon: const Icon(Icons.arrow_forward),
                        color: Styles.secondaryColor,
                        iconSize: 30,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const MemberDetail()),
                          );
                        },
                      ) ,
                    ),
                  ],
                ),
              )
          ),Card(
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
                        icon: const Icon(Icons.arrow_forward),
                        color: Styles.secondaryColor,
                        iconSize: 30,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const MemberDetail()),
                          );
                        },
                      ) ,
                    ),
                  ],
                ),
              )
          ),Card(
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
                        icon: const Icon(Icons.arrow_forward),
                        color: Styles.secondaryColor,
                        iconSize: 30,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const MemberDetail()),
                          );
                        },
                      ) ,
                    ),
                  ],
                ),
              )
          ),Card(
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
                        icon: const Icon(Icons.arrow_forward),
                        color: Styles.secondaryColor,
                        iconSize: 30,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const MemberDetail()),
                          );
                        },
                      ) ,
                    ),
                  ],
                ),
              )
          ),Card(
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
                        icon: const Icon(Icons.arrow_forward),
                        color: Styles.secondaryColor,
                        iconSize: 30,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const MemberDetail()),
                          );
                        },
                      ) ,
                    ),
                  ],
                ),
              )
          ),Card(
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
                        icon: const Icon(Icons.arrow_forward),
                        color: Styles.secondaryColor,
                        iconSize: 30,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const MemberDetail()),
                          );
                        },
                      ) ,
                    ),
                  ],
                ),
              )
          ),Card(
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
                        icon: const Icon(Icons.arrow_forward),
                        color: Styles.secondaryColor,
                        iconSize: 30,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const MemberDetail()),
                          );
                        },
                      ) ,
                    ),
                  ],
                ),
              )
          ),Card(
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
                        icon: const Icon(Icons.arrow_forward),
                        color: Styles.secondaryColor,
                        iconSize: 30,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const MemberDetail()),
                          );
                        },
                      ) ,
                    ),
                  ],
                ),
              )
          ),Card(
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
                        icon: const Icon(Icons.arrow_forward),
                        color: Styles.secondaryColor,
                        iconSize: 30,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const MemberDetail()),
                          );
                        },
                      ) ,
                    ),
                  ],
                ),
              )
          ),Card(
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
                        icon: const Icon(Icons.arrow_forward),
                        color: Styles.secondaryColor,
                        iconSize: 30,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const MemberDetail()),
                          );
                        },
                      ) ,
                    ),
                  ],
                ),
              )
          ),Card(
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
                        icon: const Icon(Icons.arrow_forward),
                        color: Styles.secondaryColor,
                        iconSize: 30,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const MemberDetail()),
                          );
                        },
                      ) ,
                    ),
                  ],
                ),
              )
          ),Card(
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
                        icon: const Icon(Icons.arrow_forward),
                        color: Styles.secondaryColor,
                        iconSize: 30,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const MemberDetail()),
                          );
                        },
                      ) ,
                    ),
                  ],
                ),
              )
          ),Card(
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
                        icon: const Icon(Icons.arrow_forward),
                        color: Styles.secondaryColor,
                        iconSize: 30,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const MemberDetail()),
                          );
                        },
                      ) ,
                    ),
                  ],
                ),
              )
          ),Card(
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
                        icon: const Icon(Icons.arrow_forward),
                        color: Styles.secondaryColor,
                        iconSize: 30,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const MemberDetail()),
                          );
                        },
                      ) ,
                    ),
                  ],
                ),
              )
          ),Card(
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
                        icon: const Icon(Icons.arrow_forward),
                        color: Styles.secondaryColor,
                        iconSize: 30,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const MemberDetail()),
                          );
                        },
                      ) ,
                    ),
                  ],
                ),
              )
          ),

        ]);
  }
}
