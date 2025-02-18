import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ecommerces_project/Bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
class SignUp extends StatefulWidget {
  const SignUp({super.key});
  @override
  State<SignUp> createState() => _SignUpState();
}
class _SignUpState extends State<SignUp> {
  FirebaseAuth auth =FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;
  TextEditingController name =TextEditingController();
  TextEditingController email =TextEditingController();
  TextEditingController password =TextEditingController();
  bool isVisible = false;

  void onSignUp() async {
    try{
      var authState = await auth.createUserWithEmailAndPassword(email: email.text, password: password.text);
      Navigator.pushNamed(context, '/');
      await db.collection('user').add({
        'name': name.text,
        'email': email.text,
        'id': authState.user!.uid,
        'role': 'user',
      });

      print('ok');
    }
    on FirebaseAuthException
    catch(err){
      if(err.code == 'email-already-in-use'){
        Fluttertoast.showToast(
            msg: "Email Already In Use",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }
      else{
        Fluttertoast.showToast(
            msg: "Sign Up Successful!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }
    }
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
              SizedBox(
                height: 80,
              ),
              Container(
                margin: EdgeInsets.only(left: 80,top: 200),
                child: Text(
                  'Create Account',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextField(
                  controller: name,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(color: Colors.grey)),
                      labelText: 'Name',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(25),
                      )),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextField(
                  controller: email,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(color: Colors.grey)),
                      labelText: 'Enter Your Email',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(25),
                      )),
                ),
              ),
              Container(
                        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: TextFormField(
                          controller: password,
                          onChanged: (value) {
                            BlocProvider.of<CounterBolc>(context)
                                .add(onPasswordChsk(value));
                            // onPasswordMatch(password.text);
                          },
                          obscureText:!isVisible,
                          decoration: InputDecoration(
                              suffixIcon:IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isVisible = !isVisible;
                                    });
                                  },
                                  icon:isVisible ? Icon(CupertinoIcons.eye)
                                      : Icon(CupertinoIcons.eye_slash)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: BorderSide(color: Colors.grey)),
                              labelText: 'Password',
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(25))),
                        )),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  BlocBuilder<CounterBolc, CounterState>(builder: (context, state) {
                    return AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      margin: EdgeInsets.only(left: 25),
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                          color:  state.isPasswordEight != false? Colors.green : Colors.transparent,
                          border: Border.all(color: Colors.grey.shade500),
                          borderRadius: BorderRadius.circular(50)),
                      child: Container(
                          child: Icon(
                            CupertinoIcons.checkmark_alt,
                            size: 15,
                            color: Colors.white,
                          )),
                    );
                  }),
                  SizedBox(
                    width: 10,
                  ),
                  Text('Must be 8 Characters')
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  BlocBuilder<CounterBolc, CounterState>(builder: (context, state) {
                    return AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      margin: EdgeInsets.only(left: 25),
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                          color: state.isPasswordOne != false? Colors.green
                             : Colors.transparent,
                          border: Border.all(color: Colors.grey.shade500),
                          borderRadius: BorderRadius.circular(50)),
                      child: Container(
                          child: Icon(
                            CupertinoIcons.checkmark_alt,
                            size: 15,
                            color: Colors.white,
                          )),
                    );
                  }),
                  SizedBox(
                    width: 10,
                  ),
                  Text('Must be Math One Number')
                ],
              ),
              SizedBox(
                height: 130,
              ),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 40),
                    child: Text(
                      'Sing up',
                      style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: (){
                      onSignUp();
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 40),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Container(
                            decoration: BoxDecoration(color: Colors.grey),
                            child: Icon(Icons.arrow_forward,
                              size: 60,
                            ),
                          )),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 120,
              ),
              Row(
                children: [
                  Container(
                      margin: EdgeInsets.only(left: 40),
                      child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/');
                          },
                          child: Text(
                            'Sing in',
                            style: TextStyle(
                                fontSize: 20, decoration: TextDecoration.underline),
                          ))),
                ],
              ),
            ],
          )
        ),
      ),
    );
  }
}
