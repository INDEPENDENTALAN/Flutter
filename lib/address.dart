import 'package:alan/new_address.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyAddressPage extends StatefulWidget {
  MyAddressPage({Key key, this.title, this.price, this.products}) : super(key: key);

  final String title, price, products;

  @override
  _MyAddressPageState createState() => _MyAddressPageState(price, products);
}
//
class MyAddress {
  //
  String id;
  String name;
  String lane;
  String city;
  String code;
  String phone;
}
//
class _MyAddressPageState extends State<MyAddressPage> {
  //
  _MyAddressPageState(this.price, this.products);
  //
  final String price, products;
  //
  final databaseReference = Firestore.instance;
  //
  List<MyAddress> list = List<MyAddress>();
  var myaddress;
  var _init = 0;
  //
  int _radioValue = 0;
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
      await databaseReference.collection("orders").add({
        'client': client,
        'price': price,
        'address': list[_radioValue].name + ', ' + list[_radioValue].lane + ', ' + list[_radioValue].city,
        'products': products,
        'confirm': 'Wait'
      }).then((_) => {
        Navigator.pop(context)
      }); 
    }
    //
    void _query() { 
      databaseReference.collection("addresses").getDocuments().then((QuerySnapshot snapshot) {
        snapshot.documents.forEach((f) => {
          myaddress = new MyAddress(),
          myaddress.id = f.documentID,
          myaddress.name = f.data['name'],
          myaddress.lane = f.data['lane'],
          myaddress.city = f.data['city'],
          myaddress.code = f.data['code'],
          myaddress.phone = f.data['phone'],
          list.add(myaddress)
        });
      }).then((_) => {
        setState(() {
          //
        })
      });     
    }
    //
    if (_init == 0) {
      _query();
      _init++;
    }
    //
    Widget iconButton_back = //
    Padding(padding: const EdgeInsets.only(top: 38, left: 6,),
    child: Container(alignment: Alignment.topLeft,
    child: IconButton(icon: Icon(Icons.arrow_back_ios), 
    color: Colors.black,
    onPressed: (){
    Navigator.pop(context);  
    })),);
    //  
    Widget text_address = //
    Padding(padding: const EdgeInsets.only(top: 38, left: 6,),
    child: Container(
    child: Text("Address", style: TextStyle(color: Colors.black,fontSize: 23,
    fontWeight: FontWeight.w600),),),);
    //
    void _handleRadioValueChange(int value) {
      setState(() {
        _radioValue = value;
      });
    }
    //
    Widget listItem(BuildContext context, int index) {
    return Padding(padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10,),
    child: Container(width: MediaQuery.of(context).size.width,
    child: Card(child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
    Padding(padding: const EdgeInsets.only(top: 20, left: 20, right: 20,bottom: 20), 
    child: Container(child: Column(children: <Widget>[
    Text(list[index].name,
    style: TextStyle(color: Colors.black,
    fontSize: 16,fontWeight: FontWeight.w600,),),
    Text(list[index].lane,
    style: TextStyle(color: Colors.black,
    fontSize: 16,fontWeight: FontWeight.w600,),),
    Text(list[index].city,
    style: TextStyle(color: Colors.black,
    fontSize: 16,fontWeight: FontWeight.w600,),),
    Text(list[index].code,
    style: TextStyle(color: Colors.black,
    fontSize: 16,fontWeight: FontWeight.w600,),),
    Text(list[index].phone,
    style: TextStyle(color: Colors.black,
    fontSize: 16,fontWeight: FontWeight.w600,),),],),),),
    Padding(padding: const EdgeInsets.only(right: 20,), 
    child: Container(child: Radio(value: index,
    groupValue: _radioValue,
    onChanged: _handleRadioValueChange,),),),
    ],),),),);}
    //
    Widget listView = //
    Padding(padding: const EdgeInsets.only(), 
    child: Container(height: 440,
    child: ListView.builder(
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    itemCount: list.length,
    itemBuilder: (BuildContext context, int index) {
    return listItem(context, index);
    },),),);
    //
    Widget flatButton_new_address = Padding(padding: const EdgeInsets.only(top: 32, left: 96, right: 96,),
    child: Container(alignment: Alignment.center,
    height: 50,width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
    color: Color(0xFF4682B4),  
    borderRadius: BorderRadius.circular(26.0)),
    child: FlatButton(onPressed: (){
      //
      Navigator.push(context,MaterialPageRoute(builder: (context) => MyNewAddressPage(title: 'New Addres',)));
    },
    child: Row(mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[Text('New Address',style: TextStyle(color: Colors.white,
    fontSize: 20,fontWeight: FontWeight.w600,),),],),),),);
    //
    Widget flatButton_Confirm = Padding(padding: const EdgeInsets.only(top: 32, left: 96, right: 96, bottom: 32),
    child: Container(alignment: Alignment.center,
    height: 50,width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
    color: Color(0xFF4682B4), 
    borderRadius: BorderRadius.circular(26.0)),
    child: FlatButton(onPressed: (){
      //
      _insert();      
    },
    child: Text('Confirm',style: TextStyle(color: Colors.white,
    fontSize: 20,fontWeight: FontWeight.w600,),),),),);
    //
    return Scaffold(body: //
      Column(children: <Widget>[
      //  
      Row(children: <Widget>[
      //
      iconButton_back,
      text_address,
      //
      ],),
      //      
      listView,
      //
      flatButton_new_address,
      flatButton_Confirm,
      //
      ],),
    );
    //
  }
}