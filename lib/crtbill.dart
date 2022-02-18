import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:watch_ui/c.dart';
import 'package:watch_ui/constants.dart';
import 'package:watch_ui/p.dart';
import 'package:watch_ui/pay_j.dart';

class Crtbill extends StatefulWidget {
  final PaymentElement payment;
  final Cart cart;
  final TblProduct tblProducts;

  final total;
  final getGst;
  final ftotal;
  final name;

  Crtbill(
    this.payment,
    this.cart,
    this.tblProducts,
    this.total,
    this.getGst,
    this.ftotal,
    this.name,
  );
  @override
  _CrtbillState createState() => _CrtbillState();
}

class _CrtbillState extends State<Crtbill> {
  List data = [];
  List products = [];
  double total;
  double total1;
  double getGst;
  double ftotal;
  String name;

  void crtDisplay() async {
    var url = Uri.parse(Api.cartdisplay);
    final response = await http.post(url);

    if (response.statusCode == 200) {
      setState(
        () {
          data = cartFromJson(response.body);
          total = totalAmount(data);
          getGst = totalGst(data);
          ftotal = finalTotal(data);
        },
      );
    }
  }

  addStringidToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('order_id', Con.orderid);
  }

  fetchDatatoorder(oid, type, sts, amt, date, id, olist, qty) async {
    String apiurl = Api.ord_pay_ordetail;

    var response = await http.post(
      Uri.parse(apiurl),
      body: {
        'order_id': oid.toString(),
        'payment_mode': type.toString(),
        'status': sts.toString(),
        'amount': amt.toString(),
        'date': date.toString(),
        'user_id': id.toString(),
        "product_list": json.encode(data).toString(),
        'qty': qty.toString(),
        // 'date': DateFormat.now,
      },
    );
    print(Con.userid);
    print("********************" + response.body);

    if (response.statusCode == 200) {
      if (response.body == 'Registration Successful!') {
      } else {
        setState(
          () {},
        );
      }
    }
  }

  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    Con.userid = prefs.getString('id_user');
  }

  double totalAmount(List<Cart> cart) {
    var total = 0.0;

    for (var i = 0; i < cart.length; i++) {
      setState(
        () {
          total += int.parse(cart[i].cartPrice) * int.parse(cart[i].cartQty);
        },
      );
    }
    return total;
  }

  double totalGst(List<Cart> cart) {
    var getGst = 0.0;

    for (var i = 0; i < cart.length; i++) {
      setState(
        () {
          getGst = total * int.parse(cart[i].cartGst) / 100;
        },
      );
    }
    return getGst;
  }

  double finalTotal(List<Cart> cart) {
    var ftotal = 0.0;

    for (var i = 0; i < cart.length; i++) {
      setState(
        () {
          ftotal = getGst + total;
        },
      );
    }
    setState(
      () {
        Con.amount = ftotal.toString();
      },
    );

    return ftotal;
  }

  postingList() async {
    final uri = Api.ord_pay_ordetail;

    http.Response response = await http.post(
      Uri.parse(
        uri,
      ),
      body: {
        "product_list": json.encode(data),
      },
    );
    if (response.statusCode == 200) {
      print("**response received is**" + response.body);
    } else {
      Fluttertoast.showToast(
        msg: 'Error',
      );
    }
  }

  @override
  void initState() {
    Con.amount = "";
    Con.userid = "";
    Con.orderid = "";
    crtDisplay();
    getStringValuesSF();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Clr.pcolor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Center(
            child: Text(
              'My Cart',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(
                    'Assets/images/cr8.jpg',
                  ),
                ),
              ),
            ),
            Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      Cart cart = data[index];

                      return Card(
                        elevation: 5,
                        margin: EdgeInsets.all(5),
                        // shape: RoundedRectangleBorder(
                        //   borderRadius: BorderRadius.circular(20),
                        // ),
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 20,
                            backgroundColor: Clr.pcolor,
                            child: FittedBox(
                              child: Text(
                                cart.cartPrice,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          title: Text(
                            "Product Name : ${cart.cartName}",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          subtitle: Text(
                            "Total : \u{20B9} ${int.parse(cart.cartPrice) * int.parse(cart.cartQty)}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          trailing: Text(
                            "Quantity : ${cart.cartQty} x ",
                            //'$_counter',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                data != null
                    ? Container(
                        margin: EdgeInsets.all(10),
                        child: Card(
                          color: Colors.grey[100],
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Divider(
                                color: Colors.grey,
                                thickness: 2,
                                endIndent: 10,
                                indent: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text(
                                      'PRICE DETAILS',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                color: Colors.grey,
                                thickness: 2,
                                endIndent: 10,
                                indent: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text(
                                      "Price :  ",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          '\u{20B9} $total',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text(
                                      "GST :  ",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          '\u{20B9} $getGst',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                color: Colors.grey,
                                thickness: 2,
                                endIndent: 10,
                                indent: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text(
                                      'TOTAL :  ',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          '\u{20B9} ${Con.amount}',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                color: Colors.grey,
                                thickness: 2,
                                endIndent: 10,
                                indent: 10,
                              ),
                            ],
                          ),
                        ),
                      )
                    : Container(),
                Container(
                  width: double.infinity,
                  height: 50,
                  margin: EdgeInsets.only(left: 40, right: 40),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      primary: Clr.pcolor,
                    ),
                    onPressed: () {
                      fetchDatatoorder(Con.orderid, 'COD', '1', Con.amount, '',
                          Con.userid, data, data);
                      Fluttertoast.showToast(
                          msg: "Payment Done!!",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.black,
                          textColor: Clr.pcolor,
                          fontSize: 16.0);
                      // postingList();
                    },
                    child: Text(
                      'PAY',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
