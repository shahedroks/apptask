import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  void onLogout ()async{
    SharedPreferences profs =await SharedPreferences.getInstance();
    profs.remove('token');
    profs.remove('user_id');
    profs.remove('role');
    Navigator.pushReplacementNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          children: [
            const UserAccountsDrawerHeader(accountName: Text('Shahed'), accountEmail: Text('shahedroks@gmail.com')),
            ListTile(
              onTap: (){},
              leading: const Icon(MaterialCommunityIcons.face_profile),
              title: const Text('Profile'),
            ),
            ListTile(
              onTap: (){},
              leading: const Icon(Icons.contact_support),
              title: const Text('Support'),
            ),ListTile(
              onTap: (){
                showDialog(context: context, builder:(BuildContext bc){
                  return AlertDialog(
                    title:const Text('Do You Want Logout'),
                    actions: [
                      TextButton(onPressed: (){
                        Navigator.of(context).pop();
                      }, child:const Text('No')),
                      TextButton(onPressed: (){
                        onLogout();
                        Navigator.pushReplacementNamed(context, '/loginpage');
                      }, child: const Text('Yes'))

                    ],
                  );
                } );
              },
              leading: const Icon(Icons.login),
              title: const Text('Logout'),
            ),
          ],
        ),
      );
  }
}

