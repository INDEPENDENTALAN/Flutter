import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyClientOrdersPage extends StatefulWidget {
  MyClientOrdersPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyClientOrdersPageState createState() => _MyClientOrdersPageState();
}
//
class MyOrder {
  //
  String id;
  String client;
  String price;
  String address;
  String products;
  String confirm;
}
//
class _MyClientOrdersPageState extends State<MyClientOrdersPage> {
  //
  final databaseReference = Firestore.instance;
  //
  List<MyOrder> list = List<MyOrder>();
  var myorder;
  var _init = 0;
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
    void _query(String client) {
      databaseReference.collection("orders").where("client", isEqualTo: client).getDocuments().then((QuerySnapshot snapshot) {
        snapshot.documents.forEach((f) => {
          myorder = new MyOrder(),
          myorder.id = f.documentID,
          myorder.client = f.data['client'],
          myorder.price = f.data['price'],
          myorder.address = f.data['address'],
          myorder.products = f.data['products'],
          myorder.confirm = f.data['confirm'],
          list.add(myorder)
        });
      }).then((_) => {
        setState(() {
          //
        })
      });     
    }
    //
    if (_init == 0) {
      _query(client);
      _init++;
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
    Widget text_my_orders = //
    Padding(padding: const EdgeInsets.only(top: 38, left: 6,),
    child: Container(
    child: Text("My Orders", style: TextStyle(color: Colors.black,fontSize: 23,
    fontWeight: FontWeight.w600),),),);
    //
    Widget listItem(BuildContext context, int index) {
    return Padding(padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20,),
    child: Container(alignment: Alignment.center,
    width: MediaQuery.of(context).size.width,    
    child: Card(child: Row(children: <Widget>[
    Padding(padding: const EdgeInsets.only(top: 20, right: 20, left: 20), 
    child: Container(
    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
    Text(list[index].products,
    style: TextStyle(color: Colors.black,
    fontSize: 16,fontWeight: FontWeight.w600,),),
    Text(list[index].price + '\$',
    style: TextStyle(color: Colors.black,
    fontSize: 16,fontWeight: FontWeight.w600,),),
    Container(width: 300,  child: 
    Text(list[index].address,
    style: TextStyle(color: Colors.black,
    fontSize: 16,fontWeight: FontWeight.w600,),),),
    Padding(padding: const EdgeInsets.only(top: 20, left: 60, bottom: 20), 
    child: Container(alignment: Alignment.center,
    width: 200,
    decoration: BoxDecoration(
    color: Color(0xFF4682B4), 
    borderRadius: BorderRadius.circular(26.0)),
    child: FlatButton(onPressed: (){
      //
    },
    child: Text('Order Details',style: TextStyle(color: Colors.white,
    fontSize: 16,fontWeight: FontWeight.w600,),),),),),],),),    
    ),],),),),);}
    //
    Widget listView = //
    Padding(padding: const EdgeInsets.only(), 
    child: Container(
    child: ListView.builder(
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    itemCount: list.length,
    itemBuilder: (BuildContext context, int index) {
    return listItem(context, index);
    },),),);
    //
    return Scaffold(body: //
      Container(child: 
      Column(children: <Widget>[
      //  
      Row(children: <Widget>[
      //
      iconButton_back,
      text_my_orders,
      //
      ],),
      //
      listView,
      //
      ],),
    ),);
    //
  }
}