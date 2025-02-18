import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ecommerces_project/compronet/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart';
class SignIn extends StatefulWidget {
  const SignIn({super.key});
  @override
  State<SignIn> createState() => _SignInState();
}
class _SignInState extends State<SignIn> {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore store =FirebaseFirestore.instance;
  TextEditingController email =TextEditingController();
  TextEditingController password =TextEditingController();
  FirebaseMessaging fm = FirebaseMessaging.instance;
  bool _isVisible = false;

  void onChakSignIn ()async{
    try{
      var isAuthState =await auth.signInWithEmailAndPassword(email: email.text, password: password.text);
      Navigator.pushNamed(context, '/homepage');
    } on FirebaseException
    catch(e)
   {
     print(e);
   }
  }


@override
  void initState()  {

  }
  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Container(
          width:MediaQuery.of(context).size.width*10,
          height:MediaQuery.of(context).size.height*10,
          // decoration: BoxDecoration(image:DecorationImage(image: AssetImage('Assets/Buy')) ),
            decoration: BoxDecoration(image: DecorationImage(image: AssetImage('Assets/SignIn.jpeg'),fit: BoxFit.cover)),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: SingleChildScrollView(
                child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 150,),
                    Container(
                      margin: EdgeInsets.only(left: 80,top: 200),
                      child: Text('Welcome Back',
                        style: TextStyle(
                            fontSize: 40,fontWeight: FontWeight.bold,color: Colors.black,),),
                    ),
                    SizedBox(height: 70,),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                      child: TextField(controller: email,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(color: Colors.grey)),labelText: 'Enter Your Email',
                        focusedBorder: OutlineInputBorder(borderSide:BorderSide(color: Colors.black),borderRadius: BorderRadius.circular(25),)
                      ),),
                      ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                            child: TextFormField(controller: password,
                              obscureText:!_isVisible ,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(onPressed: (){
                                 setState(() {
                                   _isVisible = !_isVisible;
                                 });
                                }, icon: _isVisible?Container(child: Icon(CupertinoIcons.eye)):Container(child: Icon(CupertinoIcons.eye_slash))),
                                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(25),borderSide: BorderSide(color: Colors.grey)),labelText: 'Password',
                                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black),borderRadius: BorderRadius.circular(25))
                              ),),
                          ),
                    AnimatedContainer(duration: Duration(
                    )),
                    SizedBox(height: 130,),
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 40),
                          child: Text('Sing in',style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: (){
                            onChakSignIn();
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 40),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Container(
                                decoration: BoxDecoration(color: Colors.grey),
                                child: Icon(Icons.arrow_forward,size: 60,),)
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 160,),
                    Row(children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, '/signup');
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 40),
                            child: Text('Sing up',style: TextStyle(fontSize: 20,decoration: TextDecoration.underline),)),
                      ),
                      Spacer(),
                      Container(
                          margin:EdgeInsets.only(right: 30),
                          child: Text('forgate password',style: TextStyle(color: Colors.green,fontSize: 15,),))
                    ],
                    )
                  ],
                ),
              ),
            ),
        );
  }
}
