import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:watch_ui/constants.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

class MainAppBar extends StatefulWidget {
  const MainAppBar({Key key}) : super(key: key);

  @override
  _MainAppBarState createState() => _MainAppBarState();
}

class _MainAppBarState extends State<MainAppBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: SvgPicture.asset(
            "Assets/svg/menu.svg",
            width: 15.0,
            height: 15.0,
            color: Clr.pcolor,
          ),
          onPressed: () {},
        ),
        // Text(
        //   'TIME ZONE',
        //   style: TextStyle(
        //     color: Colors.black,
        //     fontSize: 20.0,
        //     fontWeight: FontWeight.bold,
        //   ),
        // ),
        IconButton(
          icon: SvgPicture.asset(
            "Assets/svg/hamburger.svg",
            width: 18.0,
            height: 18.0,
          ),
          onPressed: () {
            VxNavigator.of(context).push(
              Uri(path: "/cart"),
            );
          },
        )
      ],
    );
  }
}
