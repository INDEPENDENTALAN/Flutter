import 'package:flutter/material.dart';

class MyOrderDetailsPage extends StatefulWidget {
  MyOrderDetailsPage({Key key, this.title, this.client, this.price, this.address, this.products}) : super(key: key);

  final String title, client, price, address, products;

  @override
  _MyOrderDetailsPageState createState() => _MyOrderDetailsPageState(client, price, address, products);
}

class _MyOrderDetailsPageState extends State<MyOrderDetailsPage> {
  //
  _MyOrderDetailsPageState(this.client, this.price, this.address, this.products);
  //
  final String client, price, address, products;
  //
  @override
  Widget build(BuildContext context) {
    //
    Widget iconButton_back = //
    Padding(padding: const EdgeInsets.only(top: 20, left: 6,),
    child: Container(
    alignment: Alignment.topLeft,
    child: IconButton(icon: Icon(Icons.arrow_back_ios),
    color: Colors.black,
    onPressed: (){
    Navigator.pop(context);  
    })),);
    //
    Widget text_details = //
    Padding(padding: const EdgeInsets.only(top: 20, left: 6,),
    child: Container(
    child: Text("Order Details", style: TextStyle(color: Colors.black,fontSize: 23,
    fontWeight: FontWeight.w600),),),);
    //
    Widget text_client = //
    Padding(padding: const EdgeInsets.only(top: 38, left: 20,right: 20),
    child: Container(width: MediaQuery.of(context).size.width,
    alignment: Alignment.center,
    child: Column(children: <Widget>[Text('Client Name',
    style: TextStyle(fontSize: 16,color: Colors.grey,),),
    Text(client,
    style: TextStyle(fontSize: 16,color: Colors.black,),),],),),);
    //
    Widget text_products = //
    Padding(padding: const EdgeInsets.only(top: 20, left: 20,right: 20),
    child: Container(width: MediaQuery.of(context).size.width,
    alignment: Alignment.center,
    child: Column(children: <Widget>[Text('Client Products',
    style: TextStyle(fontSize: 16,color: Colors.grey,),),
    Text(products,
    style: TextStyle(fontSize: 16,color: Colors.black,),),],),),);
    //
    Widget text_price = //
    Padding(padding: const EdgeInsets.only(top: 20, left: 20,right: 20),
    child: Container(width: MediaQuery.of(context).size.width,
    alignment: Alignment.center,
    child: Column(children: <Widget>[Text('Products Price',
    style: TextStyle(fontSize: 16,color: Colors.grey,),),
    Text(price + '\$',
    style: TextStyle(fontSize: 16,color: Colors.black,),),],),),);
    //
    Widget text_address = //
    Padding(padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
    child: Container(width: MediaQuery.of(context).size.width,
    alignment: Alignment.center,
    child: Column(children: <Widget>[Text('Client Address',
    style: TextStyle(fontSize: 16,color: Colors.grey,),),
    Text(address,
    style: TextStyle(fontSize: 16,color: Colors.black,),),],),),);
    //
    Widget flatButton_accept = //
    Padding(padding: const EdgeInsets.only(top: 32, left: 96, right: 96,),
    child: Container(width: MediaQuery.of(context).size.width,
    alignment: Alignment.center,
    decoration: BoxDecoration(
    color: Color(0xFF4682B4),
    borderRadius: BorderRadius.circular(26.0)),
    child: FlatButton(onPressed: (){
      //
      Navigator.pop(context);
    },
    child: Text('Accept',style: TextStyle(color: Colors.white,
    fontSize: 20,fontWeight: FontWeight.w600,),),),),);
    //
    return Scaffold(body: //
      Container(child: 
      ListView(children: <Widget>[
      Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
      //  
      Row(children: <Widget>[
      //  
      iconButton_back,
      text_details,
      //
      ],),
      //      
      text_client,
      text_products,
      text_price,
      text_address,      
      flatButton_accept,
      //
      ],),],),
    ),);
    //
  }
}