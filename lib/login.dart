import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;
import 'package:watch_ui/constants.dart';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool changeButton = false;
  String name, password, id;
  var _name = TextEditingController();
  var _password = TextEditingController();

  @override
  void initState() {
    password = "";
    Con.name = "";
    Con.userid = "";
    super.initState();
  }

  Widget build(BuildContext context) {
    addStringToSF() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('user_name', Con.name);
    }

    addStringidToSF() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('id_user', Con.userid);
    }

    fetchlogin(nam, pass) async {
      String apiurl = Api.login;
      print(nam);

      var response = await http.post(
        Uri.parse(apiurl),
        body: {
          'user_name': nam.toString(),
          'password': pass.toString(),
        },
      );
      print("response is " + response.body.toString());

      if (response.statusCode == 200) {
        // print(response.body);

        if (response.body != 'failed') {
          setState(
            () {
              Con.userid = response.body.toString();
              addStringToSF();
              addStringidToSF();
            },
          );
          print("************" + Con.userid);
          VxNavigator.of(context).push(
            Uri(path: "/home"),
          );
          changeButton = false;
        } else {
          setState(
            () {
              Fluttertoast.showToast(
                  msg: "Invalid Credential!!",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Clr.pcolor,
                  textColor: Colors.white,
                  fontSize: 16.0);
              changeButton = false;
            },
          );
        }
      }
      return response.body.toString();
    }

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          margin: EdgeInsets.all(20),
          child: ListView(
            children: [
              Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Welcome To\n",
                        style: TextStyle(
                          height: 2.5,
                          fontSize: 30.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      TextSpan(
                        text: "Time Zone",
                        style: TextStyle(
                          fontSize: 30.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  'Assets/images/wlog.jpg',
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 60,
                ),
              ),
              TextField(
                controller: _name,
                style: TextStyle(
                  fontSize: 13.0,
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  labelText: ' Enter Your User Name',
                  labelStyle: TextStyle(
                    fontSize: 13.0,
                    color: Colors.white,
                  ),
                ),
                onChanged: (value) {
                  //set username  text on change
                  Con.name = value;
                },
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
                  fillColor: Colors.white,
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
                onChanged: (value) {
                  //set username  text on change
                  password = value;
                },
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 120,
                ),
              ),
              Container(
                width: changeButton ? 100 : 50,
                child: GestureDetector(
                  onTap: () async {
                    setState(() {
                      changeButton = true;
                    });

                    await Future.delayed(
                      Duration(seconds: 1),
                    );
                    fetchlogin(Con.name, password);
                  },
                  child: AnimatedContainer(
                    duration: Duration(seconds: 1),
                    height: 50,
                    width: 50,
                    alignment: Alignment.center,
                    child: changeButton
                        ? Icon(
                            Icons.done,
                            color: Colors.white,
                          )
                        : Text(
                            'LOGIN',
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
                          BorderRadius.circular(changeButton ? 100 : 20),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 30,
                ),
              ),
              Container(
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Clr.pcolor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  child: Text(
                    'SIGN UP',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  onPressed: () {
                    VxNavigator.of(context).push(
                      Uri(path: "/signup"),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
