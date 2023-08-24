import 'package:flutter/material.dart';
import 'package:jumuiya_app/screens/reg_groups/join_search_form.dart';
import 'package:jumuiya_app/screens/reg_groups/register_jumuiya_form.dart';

class RegisterJumuiyaPage extends StatefulWidget {
  const RegisterJumuiyaPage({Key? key}) : super(key: key);

  @override
  State<RegisterJumuiyaPage> createState() => _RegisterJumuiyaPageState();
}

class _RegisterJumuiyaPageState extends State<RegisterJumuiyaPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 1,
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Register Jumuiya/Group'),
            bottom : const TabBar(
              tabs: <Widget>[
                Tab(
                  icon: Icon(Icons.people_sharp),
                  text: "Join / Search",
                ),
                Tab(
                  text: "Register",
                  icon: Icon(Icons.person_add_sharp),
                ),
              ],
            ),
          ),
          body: const TabBarView(
            children: <Widget>[
              Center(
                child: JoinSearchForm()  ,
              ),
              Center(
                child: RegisterJumuiyaForm() ,
              ),
            ],
          ),

        )
    );
  }
}
