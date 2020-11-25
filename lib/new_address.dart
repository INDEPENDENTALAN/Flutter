import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyNewAddressPage extends StatefulWidget {
  MyNewAddressPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyNewAddressPageState createState() => _MyNewAddressPageState();
}

class _MyNewAddressPageState extends State<MyNewAddressPage> {
  //
  final databaseReference = Firestore.instance;
  //
  final _textFieldController_name = TextEditingController();
  final _textFieldController_lane = TextEditingController();
  final _textFieldController_city = TextEditingController();
  final _textFieldController_postal_code = TextEditingController();
  final _textFieldController_phone_number = TextEditingController();
  //
  @override
  void dispose() {
    //
    _textFieldController_name.dispose();
    _textFieldController_lane.dispose();
    _textFieldController_city.dispose();
    _textFieldController_postal_code.dispose();
    _textFieldController_phone_number.dispose();
    super.dispose();
  }
  //
  @override
  Widget build(BuildContext context) {
    //
    void _insert() async {
      await databaseReference.collection("addresses").add({
        'name': _textFieldController_name.text,
        'lane': _textFieldController_lane.text,
        'city': _textFieldController_city.text,
        'code': _textFieldController_postal_code.text,
        'phone': _textFieldController_phone_number.text
      }).then((_) => {
        Navigator.pop(context)
      }); 
    }
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
    Widget text_new_address = //
    Padding(padding: const EdgeInsets.only(top: 20, left: 6,),
    child: Container(
    child: Text("New Address", style: TextStyle(color: Colors.black,
    fontSize: 23, fontWeight: FontWeight.w600),),),);
    //
    Widget textField_name = //
    Padding(padding: const EdgeInsets.only(top: 38, left: 20, right: 20,),
    child: Container(width: MediaQuery.of(context).size.width,
    child: TextField(controller: _textFieldController_name,
    style: TextStyle(color: Colors.black,fontSize: 20),
    decoration: InputDecoration(hintText: "Name",
    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0),
    borderSide: BorderSide(color: Colors.black, width: 1.2),),
    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0),
    borderSide: BorderSide(color: Color(0xFF4682B4), width: 1.2),),),),),);
    //
    Widget textField_address = //
    Padding(padding: const EdgeInsets.only(top: 20, left: 20, right: 20,),
    child: Container(width: MediaQuery.of(context).size.width,
    child: TextField(controller: _textFieldController_lane,
    style: TextStyle(color: Colors.black,fontSize: 20),
    decoration: InputDecoration(hintText: "Address Lane",
    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0),
    borderSide: BorderSide(color: Colors.black, width: 1.2),),
    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0),
    borderSide: BorderSide(color: Color(0xFF4682B4), width: 1.2),),),),),);
    //
    Widget textField_city = //
    Padding(padding: const EdgeInsets.only(top: 20, left: 20, right: 20,),
    child: Container(width: MediaQuery.of(context).size.width,
    child: TextField(controller: _textFieldController_city,
    style: TextStyle(color: Colors.black,fontSize: 20),
    decoration: InputDecoration(hintText: "City",
    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0),
    borderSide: BorderSide(color: Colors.black, width: 1.2),),
    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0),
    borderSide: BorderSide(color: Color(0xFF4682B4), width: 1.2),),),),),);
    //
    Widget textField_postal_code = //
    Padding(padding: const EdgeInsets.only(top: 20, left: 20, right: 20,),
    child: Container(width: MediaQuery.of(context).size.width,
    child: TextField(controller: _textFieldController_postal_code,
    style: TextStyle(color: Colors.black,fontSize: 20),
    decoration: InputDecoration(hintText: "Postal Code",
    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0),
    borderSide: BorderSide(color: Colors.black, width: 1.2),),
    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0),
    borderSide: BorderSide(color: Color(0xFF4682B4), width: 1.2),),),),),);
    //
    Widget textField_phone_number = //
    Padding(padding: const EdgeInsets.only(top: 20, left: 20, right: 20,),
    child: Container(width: MediaQuery.of(context).size.width,
    child: TextField(controller: _textFieldController_phone_number,
    style: TextStyle(color: Colors.black,fontSize: 20),
    decoration: InputDecoration(hintText: "Phone Number",
    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0),
    borderSide: BorderSide(color: Colors.black, width: 1.2),),
    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0),
    borderSide: BorderSide(color: Color(0xFF4682B4), width: 1.2),),),),),);
    //
    Widget flatButton_add_address = //
    Padding(padding: const EdgeInsets.only(top: 32, left: 96, right: 96,),
    child: Container(alignment: Alignment.center,
    height: 50,width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
    color: Color(0xFF4682B4), 
    borderRadius: BorderRadius.circular(26.0)),
    child: FlatButton(onPressed: (){
      //
      _insert();
    },
    child: Text('Add Address',style: TextStyle(color: Colors.white,
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
      text_new_address,
      //  
      ],),
      //
      textField_name,
      textField_address,
      textField_city,
      textField_postal_code,
      textField_phone_number,
      flatButton_add_address,
      //
      ],),],),
    ),);
    //
  }
}