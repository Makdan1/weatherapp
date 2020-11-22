import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider_architecture/_viewmodel_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherapp/ui/utils/colors.dart';
import 'package:weatherapp/ui/widget/curvePainter.dart';
import 'package:weatherapp/ui/widget/loading.dart';
import 'package:weatherapp/viewmodels/signinViewModel.dart';
import 'package:weatherapp/viewmodels/signupViewModel.dart';

class Login extends StatefulWidget {
  @override
  _AlmostThere createState() => _AlmostThere();
}

class _AlmostThere extends State<Login> {
  // Parameters initialized
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool passwordVisible;

  // ignore: must_call_super
  void initState() {
    // TODO: implement initState
    passwordVisible = true;
  }

  String token;
  SharedPreferences prefs;
  String error;

  _showErrorDialog(
      {String message = "Both username and password fields are required."}) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error logging in"),
            content: Text(message),
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(15)),
            actions: <Widget>[
              FlatButton(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery
        .of(context)
        .size
        .width;

    ProgressDialog pr;
    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);

    pr.style(
      message: '',
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      progressTextStyle: TextStyle(
          color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
      messageTextStyle: TextStyle(
          color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600),
    );

    return
      ViewModelProvider<SignInViewModel>.withConsumer(
          viewModelBuilder: () => SignInViewModel(),
          builder: (context, model, child) =>

              Stack(
                children: <Widget>[
              Scaffold(
                key: _scaffoldKey,
                backgroundColor: Colors.blueAccent,
                body:
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(20, 30,
                                        20, 10),
                                    child:
                                    Container(
                                      padding: EdgeInsets.all(20),
                                      child: Text(
                                        'Login',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25),
                                      ),
                                    ),
                                  ),

                                  Container(
                                    padding: EdgeInsets.only(left: 20),
                                    child: Text(
                                      'Get your location weather forecast in real time.',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w300,
                                          fontSize: 12),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(20),
                                    child: TextFormField(
                                      controller: emailController,
                                      decoration: InputDecoration(
                                          hintText: 'name@gmail.com',
                                          labelText: 'Username',
                                          hintStyle: TextStyle(
                                            color: Colors.black,
                                          ),
                                          labelStyle: TextStyle(
                                              color: Colors.grey, fontSize: 12),
                                          prefixIcon: Icon(
                                              Icons.person_outline)),
                                      keyboardType: TextInputType.emailAddress,
                                      style: TextStyle(color: Colors.black),
                                      cursorColor: Colors.black,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(20),
                                    child: TextFormField(
                                      controller: passwordController,
                                      decoration: InputDecoration(
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              // Based on passwordVisible state choose the icon
                                              passwordVisible
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                              color: Colors.black,
                                            ),
                                            onPressed: () {
                                              // Update the state i.e. toogle the state of passwordVisible variable
                                              setState(() {
                                                passwordVisible =
                                                !passwordVisible;
                                              });
                                            },
                                          ),
                                          hintText: '*******',
                                          hintStyle: TextStyle(
                                            color: Colors.black45,
                                          ),
                                          labelText: 'Password',
                                          labelStyle: TextStyle(
                                              color: Colors.grey, fontSize: 12),
                                          prefixIcon: Icon(Icons.lock)),
                                      obscureText: passwordVisible,
                                      keyboardType: TextInputType
                                          .visiblePassword,
                                      style: TextStyle(color: Colors.black),
                                      cursorColor: Colors.black,
                                    ),
                                  ),
                                  Container(
                                      padding: EdgeInsets.all(20),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween,
                                        children: <Widget>[
                                          InkWell(
                                            onTap: () {
                                              model.navigateToForgotPassword();
                                            },
                                            child: Text(
                                              'Forgot Password?',
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12),
                                            ),
                                          )
                                        ],
                                      )),

                                ]),
                          )


                      ),
                    ),
                  ),
                ),

                bottomNavigationBar: Container(
                  //color:appTheme,
                  height: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        color: Colors.lightBlue,
                        width: deviceWidth / 2,
                        height: 70,
                        child: InkWell(
                            onTap: () {
                              model.navigateToSignUp();
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(20),
                                  child: Text(
                                    'REGISTER',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12),
                                  ),
                                ),
                              ],
                            )),
                      ),
                      Container(
                        color: Colors.blueAccent,
                        width: deviceWidth / 2,
                        height: 70,
                        child: InkWell(
                            onTap: () {
                              model.login(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(),
                              );

                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(20),
                                  child: Text(
                                    'SIGN IN ',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12),
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                )
                              ],
                            )),
                      ),

                    ],
                  ),
                ),

              ),
                  Positioned(
                    child: model.busy ? Loading() : Container(),
                  ),
        ]
      )
      );
  }

}