import 'dart:developer';

import 'package:alan/cart.dart';
import 'package:alan/client_orders.dart';
import 'package:alan/details.dart';
import 'package:alan/utility.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyClientPage extends StatefulWidget {
  MyClientPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyClientPageState createState() => _MyClientPageState();
}
//
class MyProduct {
  //
  String id;
  String name;
  String price;
  String category;
  String description;
  String image;
}
//
enum MyPopupMenuButton { cart, my_orders, sign_out }
//
class _MyClientPageState extends State<MyClientPage> with TickerProviderStateMixin {
  //
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final databaseReference = Firestore.instance;
  //
  TabController _controller;
  //
  @override
  void initState() {
    super.initState();
    _controller = new TabController(length: 3, vsync: this);
  }
  //
  List<MyProduct> list = List<MyProduct>();  
  var myproduct;
  var _init = 0;
  var _checked = 0;
  //
  @override
  Widget build(BuildContext context) {
    //
    void _onRemoveSharedPreferences() async {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.remove("Name");
      sharedPreferences.remove("Specific");
    }
    //
    void _signOut() async {
      await FirebaseAuth.instance.signOut();
      Navigator.pop(context);
    }
    //
    void _query(String category) {
      databaseReference.collection("products").where("category", isEqualTo: category).getDocuments().then((QuerySnapshot snapshot) {
        snapshot.documents.forEach((f) => {
          log(f.data['name']),
          myproduct = new MyProduct(),
          myproduct.id = f.documentID,
          myproduct.name = f.data['name'],
          myproduct.price = f.data['price'],
          myproduct.category = f.data['category'],
          myproduct.description = f.data['description'],
          myproduct.image = f.data['image'],
          list.add(myproduct)
        });
      }).then((_) => {
        setState(() {
          //
          _checked++;
        })
      });    
    }
    //
    if (_checked == 0 && _init == 0) {
      _query('Shop');
      _init++;
    }
    //    
    _controller.addListener(() {
      if (_controller.index == 0 && _checked == 1 && _controller.indexIsChanging) {
        list.clear();
        setState(() {
          //          
        });
        _query('Shop');
        _checked--;
      } else if (_controller.index == 1 && _checked == 1 && _controller.indexIsChanging) {
        list.clear();
        setState(() {
          //          
        });
        _query('Decor');
        _checked--;
      } else if (_controller.index == 2 && _checked == 1 && _controller.indexIsChanging) {
        list.clear();
        setState(() {
          //          
        });
        _query('Style');  
        _checked--;
      }
    });
    // 
    Widget popupMenuButton_menu = //
    Padding(padding: const EdgeInsets.only(top: 38, right: 6,),
    child: Container(
    alignment: Alignment.topRight,
    child: PopupMenuButton<MyPopupMenuButton>(onSelected: (MyPopupMenuButton result) 
    { setState(() {
    if (result == MyPopupMenuButton.cart) {
      //
      Navigator.push(context,MaterialPageRoute(builder: (context) => MyCartPage(title: 'Cart',)));
    } else if (result == MyPopupMenuButton.my_orders) {
      //
      Navigator.push(context,MaterialPageRoute(builder: (context) => MyClientOrdersPage(title: 'My Orders',)));
    } else if (result == MyPopupMenuButton.sign_out) {
      //
      _onRemoveSharedPreferences();
      _signOut();
    }
    }); },
    itemBuilder: (BuildContext context) => <PopupMenuEntry<MyPopupMenuButton>>[
    const PopupMenuItem<MyPopupMenuButton>(
    value: MyPopupMenuButton.cart,
    child: Padding(padding: const EdgeInsets.only(left: 10, right: 40,),
    child: Text('Cart', style: TextStyle(color: Colors.black,fontSize: 16,
    fontWeight: FontWeight.w600),),),),
    const PopupMenuItem<MyPopupMenuButton>(
    value: MyPopupMenuButton.my_orders,
    child: Padding(padding: const EdgeInsets.only(left: 10, right: 40,),
    child: Text('My Orders', style: TextStyle(color: Colors.black,fontSize: 16,
    fontWeight: FontWeight.w600),),),),
    const PopupMenuItem<MyPopupMenuButton>(
    value: MyPopupMenuButton.sign_out,
    child: Padding(padding: const EdgeInsets.only(left: 10, right: 40,),
    child: Text('Sign Out', style: TextStyle(color: Colors.black,fontSize: 16,
    fontWeight: FontWeight.w600),),),),],),),);
    //
    Widget text_client = //
    Padding(padding: const EdgeInsets.only(top: 38, left: 20,),
    child: Container(
    child: Text("Client", style: TextStyle(color: Colors.black,fontSize: 23,
    fontWeight: FontWeight.w600),),),);
    //
    Widget tabBar = //
    Padding(padding: const EdgeInsets.only(left: 20, right: 20,),
    child: Container(decoration: new BoxDecoration(
    color: Colors.transparent),
    child: new TabBar(
    controller: _controller,
    indicatorColor: Colors.black,
    labelColor: Colors.black,
    labelStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),
    unselectedLabelColor: Colors.grey,
    tabs: [
    new Tab(text: 'Shop',),
    new Tab(text: 'Decor',),
    new Tab(text: 'Style',),
    ],),),); 
    //
    Widget gridItem(BuildContext context, int index) { //
    return Padding(padding: const EdgeInsets.only(),
    child: Container(height: double.infinity,
    child: Card(margin: EdgeInsets.all(8), child: Column(children: <Widget>[
    Padding(padding: const EdgeInsets.all(8),
    child: Container(child: Column(children: <Widget>[
    Image(image: Utility.imageFromBase64String(list[index].image).image,),
    Text(list[index].name,textAlign: TextAlign.center,style: TextStyle(color: Colors.black,
    fontSize: 20,fontWeight: FontWeight.w600,),),
    Text(list[index].price + '\$',textAlign: TextAlign.center,style: TextStyle(color: Color(0xFF4682B4),
    fontSize: 20,fontWeight: FontWeight.w600,),),],),),),
    Padding(padding: const EdgeInsets.all(8),
    child: Container(alignment: Alignment.center,width: 200,
    decoration: BoxDecoration(
    color: Color(0xFF4682B4), 
    borderRadius: BorderRadius.circular(26.0)),
    child: FlatButton(onPressed: (){
      //
      Navigator.push(context,MaterialPageRoute(builder: (context) => MyDetailsPage(
        title: 'Details',
        name: list[index].name,
        price: list[index].price,
        category: list[index].category,
        description: list[index].description,
        image: list[index].image
      )));
    },
    child: Text('Details',
    style: TextStyle(color: Colors.white,
    fontSize: 20,fontWeight: FontWeight.w600,),),),),),
    ],),),),);}
    //
    Widget gridView = //
    Container(
    child: GridView.builder(
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    itemCount: list.length,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 0.56),
    itemBuilder: (BuildContext context, int index) {
    return gridItem(context, index);},),);
    //
    Widget tabBarView = //
    Container(height: 500,
    child: TabBarView(
    controller: _controller,
    children: <Widget>[
    gridView,
    gridView,
    gridView,
    ],),);
    //
    return Scaffold(body: //
      Container(child: 
      Column(children: <Widget>[
      //
      Container(width: MediaQuery.of(context).size.width,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
      //
      text_client,
      popupMenuButton_menu,
      //
      ]),),
      //
      tabBar,
      tabBarView,
      //
      ],),
    ),);
    //
  }
}