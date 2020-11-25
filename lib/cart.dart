import 'package:alan/address.dart';
import 'package:alan/utility.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spinner_input/spinner_input.dart';

class MyCartPage extends StatefulWidget {
  MyCartPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyCartPageState createState() => _MyCartPageState();
}
//
class MyCart {
  //
  String id;
  String client;
  String image;
  String name;
  String price;
  String category;
  double spinner = 1;
}
//
class _MyCartPageState extends State<MyCartPage> {
  //
  final databaseReference = Firestore.instance;
  //
  List<MyCart> list = List<MyCart>();
  var mycart;
  var _init = 0;
  int total_price = 0;
  String products = 'All Products-';
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
      databaseReference.collection("carts").where("client", isEqualTo: client).getDocuments().then((QuerySnapshot snapshot) {
        snapshot.documents.forEach((f) => {
          mycart = new MyCart(),
          mycart.id = f.documentID,
          mycart.client = f.data['client'],
          mycart.image = f.data['image'],
          mycart.name = f.data['name'],
          mycart.price = f.data['price'],
          mycart.category = f.data['category'],
          list.add(mycart)
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
    Widget text_cart = //
    Padding(padding: const EdgeInsets.only(top: 38, left: 6,),
    child: Container(
    child: Text("Cart", style: TextStyle(color: Colors.black,fontSize: 23,
    fontWeight: FontWeight.w600),),),);
    //
    Widget listItem(BuildContext context, int index) {
    return Padding(padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10,),
    child: Container(width: MediaQuery.of(context).size.width,height: 200,
    child: Card(child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[ 
    Padding(padding: const EdgeInsets.only(top: 20, left: 20, bottom: 20),child: 
    Container(child: Image(image: Utility.imageFromBase64String(list[index].image).image,),), ),
    Padding(padding: const EdgeInsets.only(top: 48, left: 20, right: 20,),
    child: Container(
    child: Column(children: <Widget>[
    Text(list[index].name,
    style: TextStyle(color: Colors.black,
    fontSize: 20,fontWeight: FontWeight.w600,),),
    Text(list[index].category,
    style: TextStyle(color: Colors.grey,
    fontSize: 20,fontWeight: FontWeight.w600,),),
    Text(list[index].price + '\$',
    style: TextStyle(color: Color(0xFF4682B4),
    fontSize: 20,fontWeight: FontWeight.w600,),), 
    SpinnerInput(middleNumberStyle: TextStyle(fontWeight: FontWeight.w600,),
    plusButton: SpinnerButtonStyle(color: Colors.white, textColor: Colors.black),
    minusButton: SpinnerButtonStyle(color: Colors.white, textColor: Colors.black),
    spinnerValue: list[index].spinner, minValue: 1, maxValue: 99,
    onChange: (newValue) {setState(() {list[index].spinner = newValue;});},),
    ],),),),
    Padding(padding: const EdgeInsets.only(right: 20,),
    child: Container(alignment: Alignment.center,
    child: IconButton(onPressed: (){
      //
    },
    icon: Icon(Icons.delete_outline,),color: Colors.black, iconSize: 32,),),),
    ],),),),);}
    //
    Widget listView = //
    Padding(padding: const EdgeInsets.only(), 
    child: Container(height: 540,
    child: ListView.builder(
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    itemCount: list.length,
    itemBuilder: (BuildContext context, int index) {
    return listItem(context, index);
    },),),);
    //
    Widget flatButton_continue = //
    Padding(padding: const EdgeInsets.only(top: 32, left: 96, right: 96,),
    child: Container(alignment: Alignment.center,
    height: 50,width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
    color: Color(0xFF4682B4), 
    borderRadius: BorderRadius.circular(26.0)),
    child: FlatButton(onPressed: (){
      //
      list.forEach((element) {
        products = products + '\n' + element.spinner.toInt().toString() + ', ' + element.name;
        total_price += int.parse(element.price * element.spinner.toInt());
      });
      Navigator.push(context,MaterialPageRoute(builder: (context) => MyAddressPage(
        title: 'Address',
        price: total_price.toString(), 
        products: products,
      )));
    },
    child: Text('Continue',style: TextStyle(color: Colors.white,
    fontSize: 20,fontWeight: FontWeight.w600,),),),),);
    //
    return Scaffold(body: //
      Column(children: <Widget>[
      //  
      Row(children: <Widget>[
      //
      iconButton_back,
      text_cart,
      //
      ],),
      //
      listView,
      //
      flatButton_continue,
      //
      ],),
      );
    //
  }
}