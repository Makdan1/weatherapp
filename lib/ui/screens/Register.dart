import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider_architecture/_viewmodel_provider.dart';
import 'package:weatherapp/ui/utils/colors.dart';
import 'package:weatherapp/ui/widget/curvePainter.dart';
import 'package:weatherapp/viewmodels/signupViewModel.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Parameters initialized
  final TextEditingController firstNameController = new TextEditingController();
  final TextEditingController lastNameController = new TextEditingController();
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();



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




    return ViewModelProvider<SignUpViewModel>.withConsumer(
    viewModelBuilder: () => SignUpViewModel(),
    builder: (context, model, child) => Scaffold(
      backgroundColor: Colors.blueAccent,
      body: SingleChildScrollView(
        // Optional
        child: Container(
          padding: EdgeInsets.only(top: 20.0),
          child: Column(
            children: <Widget>[
              SizedBox(height: 50,),
              appBar,

              Center(
              child: Padding(
              padding: const EdgeInsets.all(25.0),
    child: ClipRRect(
    borderRadius: BorderRadius.circular(20),
    child: CustomPaint(
    painter: CurvePainter(),
    child: Container(
    height: 500,
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
SizedBox(height: 30,),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "First Name",
                        labelStyle: TextStyle(color: Colors.black),
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.black38,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black38),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                      keyboardType: TextInputType.text,
                      style: TextStyle(color: Colors.black),
                      cursorColor: Colors.black,
                      controller: firstNameController,
                    ),
                    SizedBox(height: 10.0),
      TextFormField(
        decoration: InputDecoration(
          labelText: "Last Name",
          labelStyle: TextStyle(color: Colors.black),
          prefixIcon: Icon(
            Icons.person,
            color: Colors.black38,
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black38),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
        ),
        keyboardType: TextInputType.text,
        style: TextStyle(color: Colors.black),
        cursorColor: Colors.black,
        controller: lastNameController,
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
                          borderSide: BorderSide(color: Colors.blue),
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
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      style: TextStyle(color: Colors.black),
                      cursorColor: Colors.black,
                      controller: _passwordController,
                      obscureText: true,
                      // obscureText: ,
                    ),
                    SizedBox(height: 10.0),
      Padding(
        padding: EdgeInsets.only(top: 20.0),
        child: Container(
          margin: EdgeInsets.only(top: 10.0, bottom: 20.0),
          height: 60.0,
          width: 250,
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
              onPressed: () {
                model.signUp(
                    email: _emailController.text,
                    password: _passwordController.text,
                    firstName: firstNameController.text,
                    lastName: lastNameController.text);
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
      )
                  ],
                ),
              )
    )
    )
    )

              )
            ],
          ),
        ),
      ),
    )

    );
  }


}
