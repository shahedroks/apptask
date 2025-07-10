import 'dart:convert';
import 'package:firebase_ecommerces_project/model/custom_details.dart';
import 'package:firebase_ecommerces_project/Pages/about.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
class DetailsCopy extends StatefulWidget {
  var id;
   DetailsCopy({super.key,this.id});

  @override
  State<DetailsCopy> createState() => _DetailsCopyState();
}

class _DetailsCopyState extends State<DetailsCopy> {
  @override
  Widget build(BuildContext context) {
    Map data = {};
    void GetData()async{
      var url = Uri.parse('https://fakestoreapi.com/products/?id=${widget.id}');
      Response res = await get(url);
      var decode = jsonDecode(res.body)[0];
        setState(() {
          data=decode.map((e)=>Detail.fromJson(e)).toList();
        });
    }
    @override
    void initState() {
      // TODO: implement initState
      super.initState();
      GetData();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details page"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20,),
          SizedBox(
              height: 300,
              width: 300,
              child: Image(image: NetworkImage('${data['image']}'))),
          Container(

              margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),

              child: Center(child: Text('${data['title']}',style: const TextStyle(fontSize: 40,fontWeight: FontWeight.bold),))),
          const SizedBox(width: 30,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Container(
                height: 35,
                width: 150,
                decoration: const BoxDecoration(color: Colors.grey),

                child: Text('${data['price']}taka',style: const TextStyle(fontSize:25,fontWeight: FontWeight.bold),)),
          ),
          const SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: Text('${data['description']}...',style: TextStyle(fontSize: 20
                ,color: Colors.grey[700]),)),
          ),
          const SizedBox(height: 10,),

        ],
      ),
    );
  }
}
