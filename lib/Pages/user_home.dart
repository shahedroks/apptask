import 'dart:convert';
import 'package:firebase_ecommerces_project/Pages/about.dart';
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
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
class UsersHomePage extends StatefulWidget {
  const UsersHomePage({super.key});
  @override
  State<UsersHomePage> createState() => _UsersHomePageState();
}
class _UsersHomePageState extends State<UsersHomePage> {
  List data =[];
  void onGetData()async{
    Response response = await get(api);
    var decode = jsonDecode(response.body);
    setState(() {
      data = decode;
          // .map((el) => Details.formjson(el)).toList();
    });
}
void onRefresh ()async {
    await Future.delayed(Duration (seconds: 3));
    onGetData();
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
      body: LiquidPullToRefresh(
        color: Colors.transparent,
        backgroundColor: Colors.amber,
        onRefresh: ()async{
          onRefresh();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10,),
              Text(text,style: TextStyle(fontSize: 20),),
              Column(
             children: data.take(6).map((el){
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
                       GestureDetector(
                         onTap: (){
                           Navigator.push(context, MaterialPageRoute(builder: (builder) => About(id: el['id'],)));
                         },
                         child: Container(
                             height: 200,
                             width: 150,
                             child: Image(image: NetworkImage(el['image']),fit: BoxFit.cover,)),
                       ),
                       SizedBox(width: 10,),
                       Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
        
                         children: [
                           Text(
                             "${el['title']}".length > 15 ? '${el['title']}'.substring(0, 15)+'...' : '${el['title']}',
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
                               child: Center(child: Text('${el['price']} Taka',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),))),
        
                           SizedBox(height: 15,),
                           Row(
                             children: [
                               StarRating(rating: el['rating']['rate'].toDouble(),color:Colors.amber,),
                               Text('(${el['rating']['rate']})'),
                             ],
                           ),
                           Text("Sold \t (${el['rating']['count']})"),
                           SizedBox(height: 10,),
        
                           Text('${el['description']}'.length > 35?'${el["description"]}'.substring(0,35): '${el['description']}'),
                           Text('${el['description']}'.length > 70?'${el["description"]}'.substring(36,70): '${el['description']}'),
                           Text('${el['description']}'.length > 71?'${el["description"]}'.substring(71,105)+"...": '${el['description']}'),
        
        
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
      ),
    );
  }
}
