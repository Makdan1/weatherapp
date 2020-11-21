import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  bool _isLoading = false;
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
    final deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _scaffoldKey,
      body: ListView(children: <Widget>[
        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 60,
              ),
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
                      labelStyle: TextStyle(color: Colors.grey, fontSize: 12),
                      prefixIcon: Icon(Icons.person_outline)),
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
                            passwordVisible = !passwordVisible;
                          });
                        },
                      ),
                      hintText: '*******',
                      hintStyle: TextStyle(
                        color: Colors.black45,
                      ),
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.grey, fontSize: 12),
                      prefixIcon: Icon(Icons.lock)),
                  obscureText: passwordVisible,
                  keyboardType: TextInputType.visiblePassword,
                  style: TextStyle(color: Colors.black),
                  cursorColor: Colors.black,
                ),
              ),
              Container(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, "/ResetPasswordPage");
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
      ]),
      bottomNavigationBar: Container(
        //color:appTheme,
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              color: Colors.black,
              width: deviceWidth / 2,
              height: 70,
              child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, "/RegisterPage");
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
              color: Colors.blue,
              width: deviceWidth / 2,
              height: 70,
              child: InkWell(
                  onTap: () {
                    _handleLogin(context);
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(20),
                        child:  _isLoading
                            ? Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.white,
                          ),
                        )
                            : Text(
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
    );
  }

  _handleLogin(BuildContext context) async {
    prefs = await SharedPreferences.getInstance();
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Fluttertoast.showToast(msg: 'Fields can\'t be empty');
    } else {
      setState(() {
        _isLoading = true;
      });
      try {
        FirebaseUser user = (await FirebaseAuth.instance
                .signInWithEmailAndPassword(
                    email: emailController.text.trim(),
                    password: passwordController.text.trim()))
            .user;
//
//
        await prefs.setString('id', user.uid);

        return Navigator.of(context).pushReplacementNamed('/Home');

      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        if (Platform.isAndroid) {
          switch (e.message) {
            case 'There is no user record corresponding to this identifier. The user may have been deleted.':
              // errorType = authProblems.UserNotFound;
              error = 'User record not available,please contact your HOA.';
              break;
            case 'The password is invalid or the user does not have a password.':
              //errorType = authProblems.PasswordNotValid;
              error = 'The password is invalid.';
              break;
            case 'A network error (such as timeout, interrupted connection or unreachable host) has occurred.':
              //errorType = authProblems.NetworkError;
              error =
                  'A network error (such as timeout, interrupted connection or unreachable host) has occurred.';
              break;
            // ...
            default:
              _showErrorDialog(message: ' ${e.message}');
              print('${e.message}');
          }
        } else if (Platform.isIOS) {
          setState(() {
            _isLoading = false;
          });
          switch (e.message) {
            case 'There is no user record corresponding to this identifier. The user may have been deleted.':
              //errorType = authProblems.UserNotFound;
              error = 'User record not available, please contact your HOA.';
              break;
            case 'The password is invalid or the user does not have a password.':
              //errorType = authProblems.PasswordNotValid;
              error = 'The password is invalid.';
              break;
            case 'A network error (such as timeout, interrupted connection or unreachable host) has occurred.':
              //errorType = authProblems.NetworkError;
              error =
                  'A network error (such as timeout, interrupted connection or unreachable host) has occurred.';
              break;
            // ...
            default:
              _showErrorDialog(message: ' ${e.message}');
              print('${e.message}');
          }
        }
        print('The error is $error');
        _showErrorDialog(message: '$error');
      }
    }
  }
}
