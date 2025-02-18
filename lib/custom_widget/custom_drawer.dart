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
            UserAccountsDrawerHeader(accountName: Text('Shahed'), accountEmail: Text('shahedroks@gmail.com')),
            ListTile(
              onTap: (){},
              leading: Icon(MaterialCommunityIcons.face_profile),
              title: Text('Profile'),
            ),
            ListTile(
              onTap: (){},
              leading: Icon(Icons.contact_support),
              title: Text('Support'),
            ),ListTile(
              onTap: (){
                showDialog(context: context, builder:(BuildContext bc){
                  return AlertDialog(
                    title:Text('Do You Want Logout'),
                    actions: [
                      TextButton(onPressed: (){
                        Navigator.of(context).pop();
                      }, child:Text('No')),
                      TextButton(onPressed: (){
                        onLogout();
                        Navigator.pushReplacementNamed(context, '/loginpage');
                      }, child: Text('Yes'))

                    ],
                  );
                } );
              },
              leading: Icon(Icons.login),
              title: Text('Logout'),
            ),
          ],
        ),
      );;
  }
}

