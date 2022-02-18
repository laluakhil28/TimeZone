import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:watch_ui/constants.dart';

class First extends StatefulWidget {
  const First({Key key}) : super(key: key);

  @override
  _FirstState createState() => _FirstState();
}

class _FirstState extends State<First> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(1, 1, 1, 1),
      body: Container(
        child: Column(
          children: [
            Stack(
              children: [
                Positioned(
                  top: -230.0,
                  left: 0.0,
                  right: 0.0,
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        //fit: BoxFit.cover,
                        image: AssetImage(
                          'Assets/images/wlog.jpg',
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height,
                  padding: EdgeInsets.symmetric(vertical: 40.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Add a brand\n",
                              style: TextStyle(
                                height: 2.5,
                                fontSize: 28.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(
                              text: "to your look",
                              style: TextStyle(
                                fontSize: 28.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 130.0,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 50, right: 50),
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                elevation: 20,
                                onPrimary: Colors.white,
                                primary: Clr.pcolor,
                              ),
                              onPressed: () {
                                VxNavigator.of(context).push(
                                  Uri(path: "/login"),
                                );
                              },
                              child: Text(
                                'Get Started',
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
