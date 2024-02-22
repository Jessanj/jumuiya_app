
import 'package:flutter/material.dart';
import '../Helpers/api_services.dart';
import '../models/user.dart';
import '../screens/member_detail.dart';
import '../util/app_colors.dart';
import '../util/app_styles.dart';

class MembersList extends StatefulWidget {
  const MembersList({Key? key}) : super(key: key);

  @override
  State<MembersList> createState() => _MembersListState();
}


class _MembersListState extends State<MembersList> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Padding(padding: EdgeInsets.all(2) , child:
    FutureBuilder<List<UserModel>>(
        future: ApiService.getUsers(),
        builder: (context, snapshot){
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
               return Padding(padding: EdgeInsets.only(top: 3 , bottom: 3 , left: 15 , right: 15) ,child: ListTile(
                  // leading: Image.network('https://example.com/image.png'),
                  leading: snapshot.data![index].profile_image == 'null'  ? Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        image: const DecorationImage(
                          fit: BoxFit.fitHeight,
                          image: AssetImage('assets/images/avatorProfile.png'),
                        )
                    ),
                  )  :
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        image: DecorationImage(
                            fit: BoxFit.fitHeight,
                            image: NetworkImage(snapshot.data![index].profile_image.toString()),
                        )
                    ),
                  ) ,
                  title: Text(snapshot.data![index].first_name +' '+ snapshot.data![index].last_name,  textAlign: TextAlign.left , style: Styles.usernameStyle,),

                  trailing: IconButton(
                    icon: const Icon(Icons.arrow_forward),
                    color: Styles.secondaryColor,
                    iconSize: 30,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  MemberDetail(snapshot.data![index])),
                      );
                    },
                  ),
                   tileColor: AppColors.white,
                   shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(10.0),
                   ),
                ));
                // return Card(
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
                //
                //                 image: const DecorationImage(
                //                     fit: BoxFit.fitHeight,
                //                     image: AssetImage('assets/images/jmProfile.jpg')
                //                 )
                //             ),
                //           ),
                //           Text(snapshot.data![index].first_name +' '+ snapshot.data![index].last_name , style: Styles.usernameStyle,),
                //           SizedBox(
                //             height: 55,
                //             width: 55,
                //             child: IconButton(
                //               icon: const Icon(Icons.arrow_forward),
                //               color: Styles.secondaryColor,
                //               iconSize: 30,
                //               onPressed: () {
                //                 Navigator.push(
                //                   context,
                //                   MaterialPageRoute(builder: (context) =>  MemberDetail(snapshot.data![index])),
                //                 );
                //               },
                //             ) ,
                //           ),
                //         ],
                //       ),
                //     )
                // );
              },
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const CircularProgressIndicator();
        })
    );

  }
}
