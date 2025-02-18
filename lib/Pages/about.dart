import 'dart:convert';
import 'package:firebase_ecommerces_project/compronet/api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
class About extends StatefulWidget {
  var id;
  About({super.key, this.id});
  @override
  State<About> createState() => _AboutState();
}
class _AboutState extends State<About> {
  Map data = {};
  void GetData()async{
    var url = Uri.parse('https://fakestoreapi.com/products/?id=${widget.id}');
    Response res = await get(url);
    var decode = jsonDecode(res.body)[0];
      setState(() {
        data=decode;
      });
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details page"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20,),
          Container(
            height: 300,
              width: 300,
              child: Image(image: NetworkImage('${data['image']}'))),
          Container(

            margin: EdgeInsets.symmetric(horizontal: 20,vertical: 20),

              child: Center(child: Text('${data['title']}',style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),))),
          SizedBox(width: 30,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Container(
              height: 35,
                width: 150,
                decoration: BoxDecoration(color: Colors.grey),

                child: Text('${data['price']}taka',style: TextStyle(fontSize:25,fontWeight: FontWeight.bold),)),
          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: Text('${data['description']}...',style: TextStyle(fontSize: 20
                ,color: Colors.grey[700]),)),
          ),
          SizedBox(height: 10,),

        ],
      ),
    );
  }
}
