import 'package:alan/utility.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDetailsPage extends StatefulWidget {
  MyDetailsPage({Key key, this.title, this.name, this.category, this.price, this.description, this.image}) : super(key: key);

  final String title, name, category, price, description, image;

  @override
  _MyDetailsPageState createState() => _MyDetailsPageState(name, category, price, description, image);
}

class _MyDetailsPageState extends State<MyDetailsPage> {
  //
  _MyDetailsPageState(this.name, this.category, this.price, this.description, this.image);
  //
  final String name, category, price, description, image;
  
  //
  final databaseReference = Firestore.instance;
  //
  String client;
  //
  @override
  Widget build(BuildContext context) {
    //
    void _onGet() async {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      client = sharedPreferences.getString('Name');
    }
    //
    _onGet();
    client = 'Client';
    //
    void _insert() async {
      await databaseReference.collection("carts").add({
        'client': client,
        'image': image,
        'name': name,
        'category': category,
        'price': price
      }).then((_) => {
        Navigator.pop(context)
      }); 
    }
    //
    Widget iconButton_back = //
    Padding(padding: const EdgeInsets.only(top: 38, left: 6,),
    child: Container(
    alignment: Alignment.topLeft,
    child: IconButton(icon: Icon(Icons.arrow_back_ios), 
    color: Colors.black,
    onPressed: (){
    Navigator.pop(context);  
    })),);
    //
    Widget image_image = //
    Padding(padding: const EdgeInsets.only(top: 38, left: 6,),
    child: Container(width: MediaQuery.of(context).size.width,
    alignment: Alignment.center,
    child: Image(image: Utility.imageFromBase64String(image).image),),);
    //
    Widget text_name = //
    Padding(padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
    child: Container(width: MediaQuery.of(context).size.width,
    alignment: Alignment.center,
    child: Text(name,
    style: TextStyle(fontSize: 16,color: Colors.black,),),),);
    //
    //
    Widget text_category = //
    Padding(padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
    child: Container(width: MediaQuery.of(context).size.width,
    alignment: Alignment.center,
    child: Text(category,
    style: TextStyle(fontSize: 16,color: Colors.black,),),),);
    //
    //
    Widget text_price = //
    Padding(padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
    child: Container(width: MediaQuery.of(context).size.width,
    alignment: Alignment.center,
    child: Text(price + '\$',
    style: TextStyle(fontSize: 16,color: Colors.black,),),),);
    //
    Widget text_description = //
    Padding(padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
    child: Container(width: MediaQuery.of(context).size.width,
    alignment: Alignment.center,
    child: Text(description,
    style: TextStyle(fontSize: 16,color: Colors.black,),),),);
    //
    Widget flatButton_purchase = //
    Padding(padding: const EdgeInsets.only(top: 32, left: 96, right: 96,),
    child: Container(width: MediaQuery.of(context).size.width,
    alignment: Alignment.center,
    decoration: BoxDecoration(
    color: Color(0xFF4682B4),  
    borderRadius: BorderRadius.circular(26.0)),
    child: FlatButton(onPressed: (){
      //
      _insert();      
    },
    child: Text('Purchase',style: TextStyle(color: Colors.white,
    fontSize: 20,fontWeight: FontWeight.w600,),),),),);
    //
    return Scaffold(body: //
      Container(child:
      ListView(children: <Widget>[
      Column(children: <Widget>[
      //  
      Row(children: <Widget>[
      //
      iconButton_back,
      //
      ],),
      //
      image_image,
      text_name,
      text_category,
      text_price,
      text_description,
      flatButton_purchase,
      //
      ],),],),
    ),);
    //
  }
}