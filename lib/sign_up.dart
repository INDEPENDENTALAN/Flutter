import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MySignUpPage extends StatefulWidget {
  MySignUpPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MySignUpPageState createState() => _MySignUpPageState();
}

class _MySignUpPageState extends State<MySignUpPage> {
  //
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final databaseReference = Firestore.instance;
  //
  final _textFieldController_name = TextEditingController();
  final _textFieldController_email = TextEditingController();
  final _textFieldController_password = TextEditingController();
  String _dropdownButton = 'Specific';
  //
  @override
  void dispose() {
    //
    _textFieldController_name.dispose();
    _textFieldController_email.dispose();
    _textFieldController_password.dispose();
    super.dispose();
  }
  //
  @override
  Widget build(BuildContext context) {
    //
    void _insert(String email) async {
      await databaseReference.collection("accounts").document(email).setData({
        'name': _textFieldController_name.text,
        'specific': _dropdownButton,
      });
      Navigator.pop(context);
    }
    //
    void _signUpWithEmail({@required String email, @required String password,}) async {
      FirebaseUser user;
      try {
        user = (await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password,)) as FirebaseUser;
      } catch (e) {
        print(e.toString());
      } finally {
        if (user != null) {
          // sign in successful!          
          // ex: bring the user to the home page
        } else {
          // sign in unsuccessful
          _insert(email);
          // ex: prompt the user to try again
        }
      }
    }
    //
    Widget text_sign_up = //
    Padding(padding: const EdgeInsets.only(top: 64, left: 20,),
    child: Container(width: MediaQuery.of(context).size.width,
    child: Text("Sign Up", style: TextStyle(color: Colors.black,fontSize: 23,
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
    Widget textField_email = //
    Padding(padding: const EdgeInsets.only(top: 20, left: 20, right: 20,),
    child: Container(width: MediaQuery.of(context).size.width,
    child: TextField(controller: _textFieldController_email,
    style: TextStyle(color: Colors.black,fontSize: 20),
    decoration: InputDecoration(hintText: "Email",
    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0),
    borderSide: BorderSide(color: Colors.black, width: 1.2),),
    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0),
    borderSide: BorderSide(color: Color(0xFF4682B4), width: 1.2),),),),),);
    //
    Widget textField_password = //
    Padding(padding: const EdgeInsets.only(top: 20, left: 20, right: 20,),
    child: Container(width: MediaQuery.of(context).size.width,
    child: TextField(controller: _textFieldController_password,
    style: TextStyle(color: Colors.black,fontSize: 20),
    decoration: InputDecoration(hintText: "Password",
    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0),
    borderSide: BorderSide(color: Colors.black, width: 1.2),),
    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0),
    borderSide: BorderSide(color: Color(0xFF4682B4), width: 1.2),),),),),);
    //
    Widget dropdownButton_specific = //
    Padding(padding: const EdgeInsets.only(top: 20, left: 20, right: 20,),
    child: Container(width: MediaQuery.of(context).size.width,
    child: DropdownButton<String>(value: _dropdownButton,
    iconSize: 26, elevation: 16,
    style: TextStyle(color: Colors.black, fontSize: 20,),
    items: <String>['Specific', 'Merchant', 'Client'].map<DropdownMenuItem<String>>((String value) {
    return DropdownMenuItem<String>(value: value,
    child: Text(value),);}).toList(), 
    onChanged: (String value) { _dropdownButton = value; },),),);
    //
    Widget flatButton_sign_up = //
    Padding(padding: const EdgeInsets.only(top: 64, left: 96, right: 96,),
    child: Container(width: MediaQuery.of(context).size.width,
    alignment: Alignment.center,
    decoration: BoxDecoration(
    color: Color(0xFF4682B4), 
    borderRadius: BorderRadius.circular(26.0)),
    child: FlatButton(onPressed: (){
      if (_textFieldController_name.text.isNotEmpty &&
        _textFieldController_email.text.isNotEmpty &&
        _textFieldController_password.text.isNotEmpty &&
        _dropdownButton != 'Specific') {
        //
        _signUpWithEmail(email: _textFieldController_email.text, password: _textFieldController_password.text);        
      } else {
        //
      }
    },
    child: Text('Sign Up',style: TextStyle(color: Colors.white,
    fontSize: 20,fontWeight: FontWeight.w600,),),),),);
    //
    Widget flatButton_sign_in = //
    Padding(padding: const EdgeInsets.only(top: 20, left: 55,right: 20),
    child: Container(width: MediaQuery.of(context).size.width,
    alignment: Alignment.bottomLeft,
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[Text('You have an account',
    style: TextStyle(fontSize: 16,color: Colors.grey,),),
    FlatButton(padding: EdgeInsets.only(right: 55),
    onPressed: () {
      Navigator.pop(context);
    },
    child: Text('Sign In',
    style: TextStyle(fontSize: 16,
    color: Colors.black,),
    textAlign: TextAlign.left,),),],),),);
    //
    return Scaffold(body: //
      Container(child:
      ListView(children: <Widget>[
      Column(children: <Widget>[
      Row(children: <Widget>[],),
      //
      text_sign_up,
      textField_name,
      textField_email,
      textField_password,
      dropdownButton_specific,
      flatButton_sign_up,
      flatButton_sign_in,
      //
      ],),],),
    ),);
    //
  }
}