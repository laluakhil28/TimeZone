import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:watch_ui/c.dart';
import 'package:watch_ui/cart.dart';
import 'package:watch_ui/crtbill.dart';
import 'package:watch_ui/details.dart';
import 'package:watch_ui/fb.dart';
import 'package:watch_ui/first.dart';
import 'package:watch_ui/home.dart';
import 'package:watch_ui/login.dart';
import 'package:watch_ui/main_appbar.dart';
import 'package:watch_ui/p.dart';
import 'package:watch_ui/signup.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: TblProduct(),
        ),
        ChangeNotifierProvider.value(
          value: TblProduct(
            image: '',
            productName: '',
            price: '',
          ),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
      ],
      child: MaterialApp.router(
        routeInformationParser: VxInformationParser(),
        routerDelegate: VxNavigator(
          routes: {
            "/": (uri, param) => MaterialPage(
                  child: First(),
                ),
            "/login": (uri, param) => MaterialPage(
                  child: Login(),
                ),
            "/signup": (uri, param) => MaterialPage(
                  child: Signup(),
                ),
            "/home": (uri, param) => MaterialPage(
                  child: Home(param),
                ),
            "/details": (uri, param) => MaterialPage(
                  child: Details(param),
                ),
            "/cart": (uri, param) => MaterialPage(
                  child: CartScreen(param),
                ),
            "/crtbill": (uri, param) => MaterialPage(
                  child: Crtbill(
                    param,
                    param,
                    param,
                    param,
                    param,
                    param,
                    param,
                  ),
                ),
            "/fb": (uri, param) => MaterialPage(
                  child: Fb(),
                ),
          },
        ),
      ),
    );
  }
}
