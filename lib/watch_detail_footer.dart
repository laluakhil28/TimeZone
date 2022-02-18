import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:watch_ui/constants.dart';
import 'package:http/http.dart' as http;
import 'package:watch_ui/p.dart';

class WatchDetailFooter extends StatelessWidget {
  final TblProduct tblProducts;
  WatchDetailFooter(
    this.tblProducts,
  );

  // void fetchDataCart(pname, count, price, gst) async {
  //   String apiurl = "http://192.168.1.4/Watch/cart_insert.php";

  //   print('insert');

  //   var response = await http.post(
  //     Uri.parse(apiurl),
  //     body: {
  //       'cart_name': pname.toString(),
  //       'cart_qty': count.toString(),
  //       'cart_price': price.toString(),
  //       'cart_gst': gst.toString(),
  //     },
  //   );
  //   print("********************" + response.body);
  //   if (response.statusCode == 200) {
  //     if (response.body == 'Registration Successful!') {
  //       Fluttertoast.showToast(
  //           msg: "Item Added!!",
  //           toastLength: Toast.LENGTH_LONG,
  //           gravity: ToastGravity.BOTTOM,
  //           timeInSecForIosWeb: 1,
  //           backgroundColor: Colors.greenAccent,
  //           textColor: Colors.black,
  //           fontSize: 16.0);
  //     } else {
  //       setState(
  //         () {},
  //       );
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {},
          child: Container(
            margin: EdgeInsets.only(right: 15.0),
            width: 60.0,
            height: 60.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: Color.fromRGBO(230, 230, 230, 1),
              ),
            ),
            child: Icon(
              FlutterIcons.ios_heart_empty_ion,
            ),
          ),
        ),
        Expanded(
          child: InkWell(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.only(right: 15.0),
              height: 60.0,
              padding: EdgeInsets.symmetric(
                horizontal: 32.0,
              ),
              decoration: BoxDecoration(
                color: Clr.pcolor,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  color: Color.fromRGBO(230, 230, 230, 1),
                ),
              ),
              child: Center(
                child: GestureDetector(
                  child: Text(
                    "Add to Cart",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 20.0,
                    ),
                  ),
                  onTap: () {
                    // fetchDataCart(tblProducts.productName, tblProducts.qty,
                    //     tblProducts.price, tblProducts.gst);
                  },
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
