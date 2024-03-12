import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:jumuiya_app/util/app_styles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jumuiya_app/Helpers/api_services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../models/user.dart';
import '../../util/app_colors.dart';
import '../../util/app_layouts.dart';

class UserRolePage extends StatefulWidget {
  final UserModel userData;
  const UserRolePage(this.userData, {super.key});

  @override
  State<UserRolePage> createState() => _UserRolePageState();
}

class _UserRolePageState extends State<UserRolePage> {
  var userRole;
  String _selectedRole = '1';
  Future fetchRoles()  async {

    // userRole = await ApiService.getUserRole(widget.userData.id.toString());
    userRole = await ApiService.getRoles();

  }
  Future<void> updateRole(int roleId)  async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
     ApiService.updateUserRole( roleId.toString() , prefs.getInt('userId').toString());
     setState(() {

     });
  }

  @override
  Widget build(BuildContext context) {
    final size  = AppLayouts.getSize(context);
    List<DropdownMenuItem<String>> buildMenuItems(data) {
      List<DropdownMenuItem<String>> items = [];
      if (data.isNotEmpty) { // Check if 'items' key exists and has valid data
        for (var item in data) {
          if (item is Map<String, dynamic> && item['role_name'] is String) { // Check type safety
            items.add(DropdownMenuItem(
              value: item['id'].toString(),
              child: Text(item['role_name']),
            ));
          } else {
            // Handle potential errors or invalid data types (optional)
          }
        }
      }
      return items;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.edit_user_role),
        backgroundColor: AppColors.navyBlue,
      ),
      body : FutureBuilder<void>(
        future: fetchRoles(), // Use the future from initState
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Column(
              children: [
                const  Gap(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Gap(10),
                    Text("${AppLocalizations.of(context)!.assigned_role}: ", style: Styles.headLineStyle6,),
                    const Gap(10),
                    Text("Admin" , style: Styles.headLineStyle6,),
                  ],
                ),
                const  Gap(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Gap(10),
                    Container(
                      alignment: Alignment.topCenter,
                      height: 100,
                      child: Text(AppLocalizations.of(context)!.change_role , style: Styles.headLineStyle6,),
                    ),
                    const Gap(10),
                    Container(
                      alignment: Alignment.topCenter,
                      width: 200,
                      height: 100,
                      child: DropdownButtonFormField<String>(
                        value: _selectedRole,
                        items: buildMenuItems(userRole),
                        onChanged: (String? value) {
                          _selectedRole = value!;
                          updateRole(value as int);
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0), // Rounded corners
                            borderSide: const BorderSide(color: Colors.blue), // Colored border
                          ),
                          filled: true, // Fill the background color
                          fillColor: Colors.grey[200], // Light grey background
                          contentPadding: const EdgeInsets.all(12.0), // Inner padding
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(AppLocalizations.of(context)!.permissions , style: Styles.headLineStyle6,)
                  ],
                ),
                SizedBox(
                  width: size.width,
                  height: 300,
                  child:  ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: userRole.length,
                    itemBuilder: (context, index) {
                      final role = userRole[index];
                      return ListTile(
                        title: Text(role['role_name']),
                        trailing: Switch(
                          value: true,
                          onChanged: null,
                        ),
                      );
                    },
                  ),
                )
              ],
            );
          }
        },
      ),
    );
  }
}
