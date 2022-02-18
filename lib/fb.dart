import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:velocity_x/velocity_x.dart';
import 'package:watch_ui/constants.dart';

class Fb extends StatefulWidget {
  const Fb({Key key}) : super(key: key);

  @override
  _FbState createState() => _FbState();
}

class _FbState extends State<Fb> {
  void fetchData() async {
    const url = Api.feedback;
    //json maping user entered details
    Map mapdata = {
      'user_name': _name.text,
      'msg': _fmsg.text,
      // 'email': _email.text,
    };
    //send  data using http post to our php code
    http.Response reponse = await http.post(Uri.parse(url), body: mapdata);
    //getting response from php code, here
    var data = jsonDecode(reponse.body);
    print("DATA: $data");
  }

  TextEditingController _name = TextEditingController();
  TextEditingController _fmsg = TextEditingController();
  // TextEditingController _email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(
                  'Assets/images/cr4.jpg',
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 30),
                  child: RichText(
                    textAlign: TextAlign.left,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Give Your\n",
                          style: TextStyle(
                            // height: 2.5,
                            fontSize: 35.0,
                            fontWeight: FontWeight.w600,
                            color: Color.fromRGBO(34, 34, 34, 1),
                            fontStyle: FontStyle.italic,
                            //color: Color.fromRGBO(34, 34, 34, 1),
                          ),
                        ),
                        TextSpan(
                          text: "   Feedback\n",
                          style: TextStyle(
                            // height: 2.5,
                            fontSize: 27.0,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.italic,
                            //color: Clr.pcolor,
                            color: Color.fromRGBO(34, 34, 34, 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: _name,
                  decoration: InputDecoration(
                    fillColor: Colors.grey[200],
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    prefixIcon: Icon(
                      Icons.person,
                      size: 30,
                      color: Clr.pcolor,
                    ),
                    labelText: "Enter Your Name",
                    labelStyle:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.all(20.0),
                //   child: TextField(
                //     controller: _email,
                //     decoration: InputDecoration(
                //       enabledBorder: OutlineInputBorder(gapPadding: 3),
                //       prefixIcon: Icon(
                //         Icons.email,
                //         size: 30,
                //         color: Colors.pink[200],
                //       ),
                //       labelText: " Enter Your Email",
                //       labelStyle:
                //           TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                //     ),
                //   ),
                // ),
                TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: _fmsg,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      gapPadding: 3,
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    prefixIcon: Icon(
                      Icons.message,
                      size: 30,
                      color: Clr.pcolor,
                    ),
                    labelText: " Enter the Message",
                    labelStyle:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(60.0),
                  child: ElevatedButton(
                    onPressed: () {
                      VxNavigator.of(context).pop();
                      fetchData();
                      Fluttertoast.showToast(
                          msg: "Thanks For Your Feedback!!",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.black,
                          textColor: Clr.pcolor,
                          fontSize: 16.0);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Clr.pcolor,
                      minimumSize: Size(60, 60),
                      padding: EdgeInsets.only(right: 70, left: 70),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      elevation: 5,
                    ),
                    child: Text(
                      'SUBMIT',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
