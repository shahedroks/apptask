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
      Fluttertoast.showToast(
          msg: "Login Successful!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
    // on FirebaseException
    catch(e)
   {
     print('erorr massage $e');
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
            decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('Assets/SignIn.jpeg'),fit: BoxFit.cover)),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: SingleChildScrollView(
                child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 150,),
                    Container(
                      margin: const EdgeInsets.only(left: 80,top: 200),
                      child: const Text('Welcome Back',
                        style: TextStyle(
                            fontSize: 40,fontWeight: FontWeight.bold,color: Colors.black,),),
                    ),
                    const SizedBox(height: 70,),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                      child: TextField(controller: email,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(25),
                            borderSide: const BorderSide(color: Colors.grey)),labelText: 'Enter Your Email',
                        focusedBorder: OutlineInputBorder(borderSide:const BorderSide(color: Colors.black),borderRadius: BorderRadius.circular(25),)
                      ),),
                      ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                            child: TextFormField(controller: password,
                              obscureText:!_isVisible ,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(onPressed: (){
                                 setState(() {
                                   _isVisible = !_isVisible;
                                 });
                                }, icon: _isVisible?Container(child: const Icon(CupertinoIcons.eye)):Container(child: const Icon(CupertinoIcons.eye_slash))),
                                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(25),borderSide: const BorderSide(color: Colors.grey)),labelText: 'Password',
                                focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.black),borderRadius: BorderRadius.circular(25))
                              ),),
                          ),
                    AnimatedContainer(duration: const Duration(
                    )),
                    const SizedBox(height: 130,),
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 40),
                          child: const Text('Sing in',style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: (){
                            onChakSignIn();
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 40),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Container(
                                decoration: const BoxDecoration(color: Colors.grey),
                                child: const Icon(Icons.arrow_forward,size: 60,),)
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 160,),
                    Row(children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, '/signup');
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 40),
                            child: const Text('Sing up',style: TextStyle(fontSize: 20,decoration: TextDecoration.underline),)),
                      ),
                      const Spacer(),
                      Container(
                          margin:const EdgeInsets.only(right: 30),
                          child: const Text('forgate password',style: TextStyle(color: Colors.green,fontSize: 15,),))
                    ],
                    )
                  ],
                ),
              ),
            ),
        );
  }
}
