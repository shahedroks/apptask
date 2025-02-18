import 'package:firebase_ecommerces_project/compronet/color.dart';
import 'package:flutter/material.dart';
AppBar CustomAppber(){
  return AppBar(
    flexibleSpace:Image(image: AssetImage('Assets/Soping.gif'),fit: BoxFit.cover,),
    elevation: 3,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50),
            bottomRight: Radius.circular(50))),
            shadowColor: Colors.black,
    iconTheme: IconThemeData(color:Colors.white,size: 35,),
  );
}