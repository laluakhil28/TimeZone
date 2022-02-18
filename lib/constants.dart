import 'package:flutter/painting.dart';

class Con {
  static String proname = "";
  static String name = "";
  static String amount = "";
  static String orderid = "";
  static String userid = "";
  static String oname = "";
  static String total = "";
}

class Clr {
  static const Color pcolor = Color.fromRGBO(224, 177, 121, 1);
}

class Api {
  static const baseurl = "http://192.168.43.49/Watch/";
  static const login = baseurl + "login.php";
  static const signup = baseurl + "user.php";
  static const feedback = baseurl + "feedback.php";
  static const productdata = baseurl + "product.php";
  static const cartdisplay = baseurl + "cart_display.php";
  static const cartinsertdata = baseurl + "cart_insert.php";
  static const cartupdate = baseurl + "cart_update.php";
  static const cartdeleteitem = baseurl + "cart_itemdelete.php";
  static const cartdelete = baseurl + "cart_delete.php";
  static const cartcheck = baseurl + "cart_check.php";
  static const ord_pay_ordetail = baseurl + "pay_ord_ordlst.php";
  static const image = baseurl;
}
