
import 'package:flutter/material.dart';
import '../Helpers/api_services.dart';
import '../models/user.dart';
import '../screens/member_detail.dart';
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
            print('it has data');
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Card(
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
                          Text(snapshot.data![index].first_name , style: Styles.usernameStyle,),
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
                );
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
