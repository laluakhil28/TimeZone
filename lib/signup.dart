import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;
import 'package:watch_ui/constants.dart';

class Signup extends StatefulWidget {
  const Signup({Key key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool changeButton = false;

  void fetchsignup() async {
    const url = Api.signup;
    //json maping user entered details
    Map mapdata = {
      'user_name': _name.text,
      'email': _email.text,
      'phone': _phone.text,
      'address': _address.text,
      'password': _password.text,
      'status': _status.text,
    };
    //send  data using http post to our php code
    http.Response reponse = await http.post(Uri.parse(url), body: mapdata);
    //getting response from php code, here
    var data = jsonDecode(reponse.body);
    print("DATA: $data");
  }

  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _status = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black12,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Clr.pcolor,
          title: Text(
            'SIGN UP',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: Container(
          margin: EdgeInsets.all(
            20.0,
          ),
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: 20,
                ),
              ),
              Center(
                child: Container(
                  child: Text(
                    'Sign Up For Time Zone',
                    style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 40,
                ),
              ),
              TextField(
                controller: _name,
                style: TextStyle(
                  fontSize: 13.0,
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  labelText: 'Enter Your Name',
                  labelStyle: TextStyle(
                    fontSize: 13.0,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 30,
                ),
              ),
              TextField(
                controller: _email,
                style: TextStyle(
                  fontSize: 13.0,
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  labelText: 'Enter Your Email',
                  labelStyle: TextStyle(
                    fontSize: 13.0,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 30,
                ),
              ),
              TextField(
                controller: _phone,
                style: TextStyle(
                  fontSize: 13.0,
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  labelText: 'Enter Your Phone Number',
                  labelStyle: TextStyle(
                    fontSize: 13.0,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 30,
                ),
              ),
              TextField(
                controller: _address,
                style: TextStyle(
                  fontSize: 13.0,
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  labelText: 'Enter Your Address',
                  labelStyle: TextStyle(
                    fontSize: 13.0,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 30,
                ),
              ),
              TextField(
                controller: _password,
                style: TextStyle(
                  fontSize: 13.0,
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  labelText: 'Enter Your Password',
                  labelStyle: TextStyle(
                    fontSize: 13.0,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 30,
                ),
              ),
              TextField(
                controller: _status,
                style: TextStyle(
                  fontSize: 13.0,
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  labelText: 'Status',
                  labelStyle: TextStyle(
                    fontSize: 13.0,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 70,
                ),
              ),
              Container(
                width: changeButton ? 50 : 100,
                child: GestureDetector(
                  onTap: () async {
                    setState(() {
                      changeButton = true;
                    });

                    await Future.delayed(
                      Duration(seconds: 1),
                    );
                    VxNavigator.of(context).pop();
                    fetchsignup();
                    Fluttertoast.showToast(
                        msg: "Sign Up Successfull!!",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Clr.pcolor,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  },
                  child: AnimatedContainer(
                    duration: Duration(seconds: 1),
                    height: 50,
                    alignment: Alignment.center,
                    child: changeButton
                        ? Icon(
                            Icons.done,
                            color: Colors.white,
                          )
                        : Text(
                            'SIGN UP',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                    decoration: BoxDecoration(
                      color: Clr.pcolor,
                      //shape:
                      //  changeButton ? BoxShape.circle : BoxShape.rectangle,
                      borderRadius:
                          BorderRadius.circular(changeButton ? 60 : 20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
