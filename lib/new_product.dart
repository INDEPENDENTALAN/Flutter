import 'dart:io';

import 'package:alan/utility.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MyNewProductPage extends StatefulWidget {
  MyNewProductPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyNewProductPageState createState() => _MyNewProductPageState();
}

class _MyNewProductPageState extends State<MyNewProductPage> {
  //
  final databaseReference = Firestore.instance;
  //
  final _textFieldController_name = TextEditingController();
  final _textFieldController_price = TextEditingController();
  final _textFieldController_description = TextEditingController();
  String _dropdownButton = 'Categories';
  File _pickedImage;
  //
  @override
  void dispose() {
    //
    _textFieldController_name.dispose();
    _textFieldController_price.dispose();
    _textFieldController_description.dispose();
    super.dispose();
  }
  //
  @override
  Widget build(BuildContext context) {
    //
    void _insert() async {
      await databaseReference.collection("products").add({
        'name': _textFieldController_name.text,
        'price': _textFieldController_price.text,
        'category': _dropdownButton,
        'description': _textFieldController_description.text,
        'image': Utility.base64String(_pickedImage.readAsBytesSync())
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
    Widget text_new_product = //
    Padding(padding: const EdgeInsets.only(top: 20, left: 6,),
    child: Container(
    child: Text("New Product", style: TextStyle(color: Colors.black,fontSize: 23,
    fontWeight: FontWeight.w600),),),);
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
    Widget textField_price = //
    Padding(padding: const EdgeInsets.only(top: 20, left: 20, right: 20,),
    child: Container(width: MediaQuery.of(context).size.width,
    child: TextField(controller: _textFieldController_price,
    style: TextStyle(color: Colors.black,fontSize: 20),
    decoration: InputDecoration(hintText: "Price",
    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0),
    borderSide: BorderSide(color: Colors.black, width: 1.2),),
    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0),
    borderSide: BorderSide(color: Color(0xFF4682B4), width: 1.2),),),),),);
    //
    Widget dropdownButton_category = //
    Padding(padding: const EdgeInsets.only(top: 20, left: 20, right: 20,),
    child: Container(width: MediaQuery.of(context).size.width,
    child: DropdownButton<String>(value: _dropdownButton,
    iconSize: 26,elevation: 16,
    style: TextStyle(color: Colors.black, fontSize: 20,),
    items: <String>['Categories', 'Shop', 'Decor', 'Style'].map<DropdownMenuItem<String>>((String value) {
    return DropdownMenuItem<String>(value: value,
    child: Text(value),);}).toList(), 
    onChanged: (String value) { _dropdownButton = value; },),),);
    //
    Widget textField_description = //
    Padding(padding: const EdgeInsets.only(top: 20, left: 20, right: 20,),
    child: Container(width: MediaQuery.of(context).size.width,
    child: TextField(controller: _textFieldController_description,
    style: TextStyle(color: Colors.black,fontSize: 20),
    decoration: InputDecoration(hintText: "Description",
    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0),
    borderSide: BorderSide(color: Colors.black, width: 1.2),),
    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0),
    borderSide: BorderSide(color: Color(0xFF4682B4), width: 1.2),),),),),);
    //
    void _pickImage() async {
      final imageSource = await showDialog<ImageSource>(
      context: context,builder: (context) =>
      AlertDialog(title: Text("Select the image source"),
      actions: <Widget>[
      MaterialButton(child: Text("Camera"),
      onPressed: () => Navigator.pop(context, ImageSource.camera),),
      MaterialButton(child: Text("Gallery"),
      onPressed: () => Navigator.pop(context, ImageSource.gallery),)],));
      if(imageSource != null) {
        final file = await ImagePicker.pickImage(source: imageSource);
        if(file != null) {
          setState(() => _pickedImage = file);
        }
      }
    }
    //
    Widget image_pick_image = //
    Padding(padding: const EdgeInsets.only(top: 20, left: 20, right: 20,),
    child: Container(width: MediaQuery.of(context).size.width,alignment: Alignment.center,
    child: _pickedImage == null ? Text("No Image") : Image(image: FileImage(_pickedImage),),),);
    //
    Widget flatButton_pick_image = //
    Padding(padding: const EdgeInsets.only(top: 32, left: 96, right: 96,),
    child: Container(alignment: Alignment.center,
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
    color: Color(0xFF4682B4),
    borderRadius: BorderRadius.circular(26.0)),
    child: FlatButton(onPressed: (){
      //
      _pickImage();
    },
    child: Text('Pick Image',style: TextStyle(color: Colors.white,
    fontSize: 20,fontWeight: FontWeight.w600,),),),),);
    //
    Widget flatButton_add_product = //
    Padding(padding: const EdgeInsets.only(top: 32, left: 96, right: 96, bottom: 32),
    child: Container(alignment: Alignment.center,
    height: 48,width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
    color: Color(0xFF4682B4), 
    borderRadius: BorderRadius.circular(26.0)),
    child: FlatButton(onPressed: (){
      //
      
      if (_textFieldController_name.text.isNotEmpty &&
        _textFieldController_price.text.isNotEmpty &&
        _textFieldController_description.text.isNotEmpty) {
        //
        _insert();
      } else {
        //
      }
    },
    child: Text('Add Product',style: TextStyle(color: Colors.white,
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
      text_new_product,
      // 
      ],),
      //      
      textField_name,
      textField_price,
      dropdownButton_category,
      textField_description,
      image_pick_image,
      flatButton_pick_image,
      flatButton_add_product,
      //
      ],),],),
    ),);
    //
  }
}