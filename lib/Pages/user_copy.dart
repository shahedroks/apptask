import 'dart:convert';
import 'package:firebase_ecommerces_project/Pages/details_copy.dart';
import 'package:firebase_ecommerces_project/compronet/api.dart';
import 'package:firebase_ecommerces_project/compronet/color.dart';
import 'package:firebase_ecommerces_project/compronet/text.dart';
import 'package:firebase_ecommerces_project/custom_widget/custom_appber.dart';
import 'package:firebase_ecommerces_project/custom_widget/custom_details_card_view.dart';
import 'package:firebase_ecommerces_project/custom_widget/custom_drawer.dart';
import 'package:firebase_ecommerces_project/model/custom_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:http/http.dart';
class UserCopy extends StatefulWidget {
  const UserCopy({super.key});
  @override
  State<UserCopy> createState() => _UserCopyState();
}
class _UserCopyState extends State<UserCopy> {
  List data =[];
  void onGetData()async{
    Response response = await get(api);
    var decode = jsonDecode(response.body);
    setState(() {
      data = decode.map((el)=>Detail.fromJson(el)).toList();
    });
    // map((json) => Product.fromJson(json)).toList();

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    onGetData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(110.0),
          child: CustomAppber()),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10,),
            Text(text,style: TextStyle(fontSize: 20),),
            Column(
              children: data.take(6).map((i){
                return Card(
                  elevation: 10,
                  color: Color(red),
                  child: Container(
                    width: double.infinity,
                    height: 200,
                    margin: EdgeInsets.all(20),
                    child: SingleChildScrollView(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              height: 200,
                              width: 150,
                              child: Image(image: NetworkImage(i.image),fit: BoxFit.cover,)),
                          SizedBox(width: 10,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              Text(
                                "${i.title}".length > 15 ? '${i.title}'.substring(0, 15)+'...' : '${i.title}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 10,),
                              Container(
                                  height: 25,
                                  width: 100,
                                  decoration: BoxDecoration(color: Colors.white),
                                  child: Center(child: Text('${i.price} Taka',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),))),
                              SizedBox(height: 15,),
                              StarRating(rating: i.rating.rate!.toDouble(),color:Colors.red,),
                              Text('(${i.rating.rate})'),
                              SizedBox(height: 15,),
                              Text('${i.description}',)


                              // Text('${el['description']}'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList()
              ,)
          ],
        ),
      ),
    );
  }
}
