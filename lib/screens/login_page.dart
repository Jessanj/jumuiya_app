import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jumuiya_app/screens/bottom_nav.dart';
import 'package:jumuiya_app/util/app_layouts.dart';

class LogPage extends StatefulWidget {
  const LogPage({Key? key}) : super(key: key);

  @override
  State<LogPage> createState() => _LogPageState();

}

class _LogPageState extends State<LogPage> {
  late  Image loginImage;
  @override
  void initState() {
    super.initState();
    loginImage = Image.asset('assets/images/greenleaf.jpg');
  }

  @override
  Widget build(BuildContext context) {
    final size = AppLayouts.getSize(context);
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: size.height * 0.28,
            width: size.width,
            child: loginImage,
          ),
          Container(
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'User Name',
                        hintText: 'Enter Your Name',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        hintText: 'Enter Password',
                      ),
                    ),
                  ),
                ],
              ) ,
          )
          ),
          Container(
            width: size.width*0.5,
            child:ElevatedButton(onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BottomNav()),
              );
            },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: const Text('Login') , ),
          ),

          TextButton(onPressed: (){}, child: Text('Forget Password'))

      ]
      )
    );
  }
}
