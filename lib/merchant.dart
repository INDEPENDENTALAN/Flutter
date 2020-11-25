import 'package:alan/merchant_orders.dart';
import 'package:alan/new_product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyMerchantPage extends StatefulWidget {
  MyMerchantPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyMerchantPageState createState() => _MyMerchantPageState();
}
//
enum MyPopupMenuButton { sign_out }
//
class _MyMerchantPageState extends State<MyMerchantPage> {
  //
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
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
    Widget popupMenuButton_menu = //
    Padding(padding: const EdgeInsets.only(top: 20, right: 6,),
    child: Container(
    alignment: Alignment.topRight,
    child: PopupMenuButton<MyPopupMenuButton>(onSelected: (MyPopupMenuButton result) 
    { setState(() {
    if (result == MyPopupMenuButton.sign_out) {
      //
      _onRemoveSharedPreferences();
      _signOut();
    }
    }); },
    itemBuilder: (BuildContext context) => <PopupMenuEntry<MyPopupMenuButton>>[
    const PopupMenuItem<MyPopupMenuButton>(
    value: MyPopupMenuButton.sign_out,
    child: Padding(padding: const EdgeInsets.only(left: 10, right: 40,),
    child: Text('Sign Out', style: TextStyle(color: Colors.black,fontSize: 16,
    fontWeight: FontWeight.w600),),),),],),),);
    //
    Widget text_merchant = //
    Padding(padding: const EdgeInsets.only(top: 20, left: 20,),
    child: Container(
    child: Text("Merchant", style: TextStyle(color: Colors.black,fontSize: 23,
    fontWeight: FontWeight.w600),),),);
    //
    Widget flatButton_new_product = Padding(padding: const EdgeInsets.only(top: 450, left: 96, right: 96,),
    child: Container(alignment: Alignment.center,
    height: 50,width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
    color: Color(0xFF4682B4), 
    borderRadius: BorderRadius.circular(26.0)),
    child: FlatButton(onPressed: (){
      Navigator.push(context,MaterialPageRoute(builder: (context) => MyNewProductPage(title: 'New Product',)));
    },
    child: Text('New Product',style: TextStyle(color: Colors.white,
    fontSize: 20,fontWeight: FontWeight.w600,),),),),);
    //
    Widget flatButton_orders = Padding(padding: const EdgeInsets.only(top: 32, left: 96, right: 96,),
    child: Container(alignment: Alignment.center,
    height: 50,width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
    color: Color(0xFF4682B4), 
    borderRadius: BorderRadius.circular(26.0)),
    child: FlatButton(onPressed: (){
      Navigator.push(context,MaterialPageRoute(builder: (context) => MyMerchantOrdersPage(title: 'Orders',)));
    },
    child: Text('Orders',style: TextStyle(color: Colors.white,
    fontSize: 20,fontWeight: FontWeight.w600,),),),),);
    //
    return Scaffold(body: //
      Container(child:
      ListView(children: <Widget>[
      Column(children: <Widget>[
      //        
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
      //
      text_merchant,
      popupMenuButton_menu,
      //  
      ],),
      //
      flatButton_new_product,
      flatButton_orders,
      //
      ],),],),
    ),);
    //
  }
}