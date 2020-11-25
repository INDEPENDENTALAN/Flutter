import 'package:alan/client.dart';
import 'package:alan/merchant.dart';
import 'package:alan/sign_up.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MySignInPage extends StatefulWidget {
  MySignInPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MySignInPageState createState() => _MySignInPageState();
}

class _MySignInPageState extends State<MySignInPage> {
  //
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final databaseReference = Firestore.instance;
  //
  final _textFieldController_email = TextEditingController();
  final _textFieldController_password = TextEditingController();
  //
  String _name;
  String _specific;
  //
  @override
  void dispose() {
    //
    _textFieldController_email.dispose();
    _textFieldController_password.dispose();
    super.dispose();
  }
  //
  @override
  Widget build(BuildContext context) {
    //
    void _onSetSharedPreferences(String name, String specific) async {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString('Name', name);
      sharedPreferences.setString('Specific', specific);
    }
    //
    void _query(String email) {
      databaseReference.collection("accounts").document(email).get().then((value) => {
        _name = value.data['name'],
        _specific = value.data['specific']
      }).then((_) => {
        if (_specific == 'Merchant') {
          //
          _onSetSharedPreferences(_name, _specific),
          Navigator.push(context,MaterialPageRoute(builder: (context) => MyMerchantPage(title: 'Merchant',)))
        } else if (_specific == 'Client') {
          //
          _onSetSharedPreferences(_name, _specific),
          Navigator.push(context,MaterialPageRoute(builder: (context) => MyClientPage(title: 'Client',)))
        }
      }); 
      
    }
    //
    void _signInWithEmail({@required String email, @required String password,}) async {
      FirebaseUser user;
      try {
        user = (await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password)) as FirebaseUser;
      } catch (e) {
        print(e.toString());
      } finally {
        if (user != null) {
          // sign in successful!          
          // ex: bring the user to the home page
        } else {
          // sign in unsuccessful
          _query(email);
          // ex: prompt the user to try again
        }
      }
    }
    //
    Widget text_sign_in = //
    Padding(padding: const EdgeInsets.only(top: 64, left: 20,),
    child: Container(width: MediaQuery.of(context).size.width,
    child: Text("Sign In", style: TextStyle(color: Colors.black,fontSize: 23,
    fontWeight: FontWeight.w600),),),);
    //
    Widget textField_email = //
    Padding(padding: const EdgeInsets.only(top: 38, left: 20, right: 20,),
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
    Widget flatButton_sign_in = //
    Padding(padding: const EdgeInsets.only(top: 64, left: 96, right: 96,),
    child: Container(width: MediaQuery.of(context).size.width,
    alignment: Alignment.center,
    decoration: BoxDecoration(
    color: Color(0xFF4682B4), 
    borderRadius: BorderRadius.circular(26.0)),
    child: FlatButton(onPressed: (){      
      if (_textFieldController_email.text.isNotEmpty &&
        _textFieldController_password.text.isNotEmpty) {
        //
        _signInWithEmail(email: _textFieldController_email.text, password: _textFieldController_password.text);
      } else {
        //
      }
    },
    child: Text('Sign In',style: TextStyle(color: Colors.white,
    fontSize: 20,fontWeight: FontWeight.w600,),),),),);
    //
    Widget flatButton_sign_up = //
    Padding(padding: const EdgeInsets.only(top: 20, left: 44,right: 20),
    child: Container(width: MediaQuery.of(context).size.width,
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[Text('You don\'t have an account',
    style: TextStyle(fontSize: 16,color: Colors.grey,),),
    FlatButton(padding: EdgeInsets.only(right: 44),
    onPressed: () {
      Navigator.push(context,MaterialPageRoute(builder: (context) => MySignUpPage(title: 'Sign Up',)));
    },
    child: Text('Sign Up',style: TextStyle(fontSize: 16,
    color: Colors.black,),textAlign: TextAlign.right,),),],),),);
    //
    return Scaffold(body: //
      Container(child: 
      ListView(children: <Widget>[
      Column(children: <Widget>[
      Row(children: <Widget>[],),
      //
      text_sign_in,
      textField_email,
      textField_password,
      flatButton_sign_in,
      flatButton_sign_up,
      //
      ],),],),
    ),);
    //
  }
}