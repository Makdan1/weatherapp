import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';





class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final Firestore _firestore = Firestore.instance;
  final DateTime timestamp = DateTime.now();
  final TextEditingController _fullNameController = new TextEditingController();
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();

  _showErrorDialog(
      {String message = "Both username and password fields are required."}) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error Registering"),
            content: Text(message),
            actions: <Widget>[
              FlatButton(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        }
    );
  }


  @override
  Widget build(BuildContext context) {

    final appBar = Padding(
      padding: EdgeInsets.only(bottom: 40.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          )
        ],
      ),
    );

    final pageTitle = Container(
      child: Text(
        "Tell us about you",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 20.0,
        ),
      ),
    );


    final submitBtn = Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: Container(
        margin: EdgeInsets.only(top: 10.0, bottom: 20.0),
        height: 60.0,
        width: MediaQuery
            .of(context)
            .size
            .width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7.0),
          border: Border.all(color: Colors.white),
        ),
        child: Material(
          borderRadius: BorderRadius.circular(7.0),
          color: Colors.blueAccent,
          elevation: 10.0,
          shadowColor: Colors.white70,
          child: MaterialButton(
            onPressed:(){
              signUp();
            },
            child: Text(
              'CREATE ACCOUNT',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 15.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );

    return Scaffold(
      key: _scaffoldKey,

      body: SingleChildScrollView(// Optional
      child:
            Container(
              padding: EdgeInsets.only(top: 20.0),
              child: Column(
                children: <Widget>[
                  appBar,
                  Container(

                    padding: EdgeInsets.only(left: 30.0, right: 30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        new Column(

                          children: <Widget>[

                          ],
                        ),
                        pageTitle,

                        TextFormField(
                          decoration: InputDecoration(
                            labelText:"First Name",
                            labelStyle: TextStyle(color: Colors.black),
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.black38,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black38),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.orange),
                            ),
                          ),
                          keyboardType: TextInputType.text,
                          style: TextStyle(color: Colors.black),
                          cursorColor: Colors.black,
                          controller: _fullNameController,

                        ),

              SizedBox(height: 10.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Email",
                  labelStyle: TextStyle(color: Colors.black),
                  prefixIcon: Icon(
                    Icons.email,
                    color: Colors.black38,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black38),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(color: Colors.black),
                cursorColor: Colors.black,
                controller: _emailController,
              ),
              SizedBox(height: 10.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Password",
                  labelStyle: TextStyle(color: Colors.black),
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Colors.black38,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black38),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange),
                  ),
                ),
                keyboardType: TextInputType.visiblePassword,
                style: TextStyle(color: Colors.black),
                cursorColor: Colors.black,
                controller:_passwordController ,
                obscureText: true,
                // obscureText: ,
              ),

                        SizedBox(height: 10.0),
                        submitBtn
                      ],
                    ),
                  )

                ],
              ),
            ),
      ),

    );
  }


 void signUp() async {
   _scaffoldKey.currentState.showSnackBar(
       new SnackBar(duration: new Duration(seconds: 4), content:

       new Row(

         children: <Widget>[
           new CircularProgressIndicator(),
           new Text("  Registering...")
         ],
       ),
       ));

     if (_fullNameController.text.isNotEmpty && _emailController.text.isNotEmpty
         && _passwordController.text.isNotEmpty) {

       try {
         FirebaseUser user = (await FirebaseAuth.instance
             .createUserWithEmailAndPassword(
             email: _emailController.text, password: _passwordController.text))
             .user;
         user.sendEmailVerification();
         Navigator.of(context).pushReplacementNamed('/Login');
         DocumentReference ref = _firestore.collection('users').document(
             user.uid);
         String userId = user.uid;
         return ref.setData({
           'userId': user.uid,
           'firstName': _fullNameController.text,
           'email': _emailController.text,},
         );
       }
       catch (e) {
         _showErrorDialog(message: e.toString());
         _scaffoldKey.currentState.hideCurrentSnackBar();
         print(e.message);
       }
     }
     else {
       Fluttertoast.showToast(msg: 'Field cannot be empty');
       _scaffoldKey.currentState.hideCurrentSnackBar();
     }
   }
 }





