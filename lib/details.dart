import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:watch_ui/constants.dart';
import 'package:watch_ui/main_appbar.dart';
import 'package:watch_ui/p.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:http/http.dart' as http;

class Details extends StatefulWidget {
  final TblProduct tblProducts;
  final imageUrl = (Api.image);

  Details(
    this.tblProducts,
  );

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  String name, qty, price, id, gst;
  int cartItemCount = 1;
  @override
  void initState() {
    name = "";
    qty = "";
    price = "";
    id = "";
    gst = "";
    //Con.pname = widget.product.pName;
    super.initState();
  }

  fetchDataCart() async {
    String apiurl = Api.cartinsertdata;

    print('insert');

    var response = await http.post(
      Uri.parse(apiurl),
      body: {
        'cart_name': this.widget.tblProducts.productName,
        'cart_qty': cartItemCount.toString(),
        'cart_price': widget.tblProducts.price,
        'cart_gst': this.widget.tblProducts.gst,
      },
    );
    print("********************" + response.body);
    if (response.statusCode == 200) {
      if (response.body == 'Registration Successful!') {
        Fluttertoast.showToast(
            msg: "Item Added to Cart!!",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Clr.pcolor,
            fontSize: 16.0);
      } else {
        setState(
          () {},
        );
      }
    }
  }

  void fetchDataUpdateCrt(qty, name) async {
    var apiurl = Uri.parse(Api.cartupdate);

    var response = await http.post(
      (apiurl),
      body: {
        'cart_qty': cartItemCount.toString(),
        'cart_name': this.widget.tblProducts.model,
      },
    );
    print("+++++++++++++++" + response.body);
    if (response.statusCode == 200) {
      setState(() {});
    }
  }

  void dltCrtItms(name) async {
    var apiurl = Uri.parse(Api.cartdeleteitem);
    print(name);

    var response = await http.post(
      (apiurl),
      body: {
        'cart_name': this.widget.tblProducts.productName,
      },
    );
    print("-------------" + response.body);
    setState(() {});
  }

  Future<String> fetchChckCrt(pname) async {
    var apiurl = Uri.parse(Api.cartcheck);
    print(
      'checking' + pname.toString(),
    );

    var response = await http.post(
      (apiurl),
      body: {
        'cart_name': pname.toString(),
      },
    );
    print("response is " + response.body.toString());
    return response.body.toString();
  }

  @override
  Widget build(BuildContext context) {
    // fetchChckCrt(this.widget.tblProducts.productName)
    //     .then((value) => {cartItemCount.value.toString()});
    return Scaffold(
      backgroundColor: Color.fromRGBO(245, 245, 245, 1),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Clr.pcolor,
        title: Text(
          'TIME ZONE',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: IconButton(
              onPressed: () {
                VxNavigator.of(context).push(
                  Uri(path: "/cart"),
                );
              },
              icon: Icon(
                Icons.shopping_bag_rounded,
                color: Colors.black,
              ),
            ),
          ),
        ],
        // leading: IconButton(
        //   onPressed: () {},
        //   icon: Icon(Icons.watch_rounded),
        // ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(),
                        ),
                        Expanded(
                          child: Container(
                            color: Clr.pcolor,
                          ),
                        )
                      ],
                    ),
                  ),
                  SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        //MainAppBar(),
                        SizedBox(
                          height: 30.0,
                        ),
                        Center(
                          child: Container(
                            padding: EdgeInsets.all(24.0),
                            height: MediaQuery.of(context).size.height * 0.38,
                            width: MediaQuery.of(context).size.width * 0.85,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16.0),
                              border: Border.all(
                                color: Colors.grey[300],
                              ),
                            ),
                            child: FadeInImage.memoryNetwork(
                              placeholder: kTransparentImage,
                              image: this.widget.imageUrl +
                                  this.widget.tblProducts.image,
                              // imageUrl: this.widget.imageUrl +
                              //     this.widget.tblProducts.image,
                              height: 200.0,
                              width: 200.0,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                textAlign: TextAlign.left,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: this.widget.tblProducts.brand,
                                      style: TextStyle(
                                        height: 2.5,
                                        fontSize: 28.0,
                                        fontWeight: FontWeight.w600,
                                        color: Color.fromRGBO(34, 34, 34, 1),
                                      ),
                                    ),
                                    TextSpan(
                                      text: " " +
                                          this.widget.tblProducts.productName +
                                          " - " +
                                          this.widget.tblProducts.model,
                                      style: TextStyle(
                                        fontSize: 28.0,
                                        color: Color.fromRGBO(34, 34, 34, 1),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                this.widget.tblProducts.category,
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.grey,
                                ),
                              ),
                              Container(
                                height: 90.0,
                                child: Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(right: 15.0),
                                      height: 60.0,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        border: Border.all(
                                          color:
                                              Color.fromRGBO(230, 230, 230, 1),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              setState(
                                                () {
                                                  cartItemCount += 1;
                                                },
                                              );
                                              fetchDataUpdateCrt(qty, name);
                                              Fluttertoast.showToast(
                                                  msg: "Item Updated!!",
                                                  toastLength:
                                                      Toast.LENGTH_LONG,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.black,
                                                  textColor: Clr.pcolor,
                                                  fontSize: 16.0);
                                            },
                                            child: Container(
                                              alignment: Alignment.center,
                                              height: 100.0,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 16.0,
                                              ),
                                              child: Text(
                                                "+",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 24.0,
                                                  color: Color.fromRGBO(
                                                      34, 34, 34, 1),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 16.0,
                                            ),
                                            child: Text(
                                              "${this.cartItemCount}",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 24.0,
                                                color: Color.fromRGBO(
                                                    34, 34, 34, 1),
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(
                                                () {
                                                  cartItemCount =
                                                      cartItemCount > 2
                                                          ? cartItemCount - 1
                                                          : 0;
                                                },
                                              );
                                              if (cartItemCount < 1) {
                                                dltCrtItms(name);
                                                setState(() {});
                                                Fluttertoast.showToast(
                                                    msg: "Item Removed!!",
                                                    toastLength:
                                                        Toast.LENGTH_LONG,
                                                    gravity:
                                                        ToastGravity.BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor:
                                                        Colors.black,
                                                    textColor: Clr.pcolor,
                                                    fontSize: 16.0);
                                              }
                                              fetchDataUpdateCrt(qty, name);

                                              Fluttertoast.showToast(
                                                  msg: "Item Updated!!",
                                                  toastLength:
                                                      Toast.LENGTH_LONG,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.black,
                                                  textColor: Clr.pcolor,
                                                  fontSize: 16.0);
                                            },
                                            child: Container(
                                              alignment: Alignment.center,
                                              height: 100.0,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 16.0,
                                              ),
                                              child: Text(
                                                "-",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 24.0,
                                                  color: Color.fromRGBO(
                                                      34, 34, 34, 1),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    cartItemCount >= 1
                                        ? Text(
                                            "\u{20B9}${(int.parse(this.widget.tblProducts.price) * this.cartItemCount)}",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 24.0,
                                              color:
                                                  Color.fromRGBO(34, 34, 34, 1),
                                            ),
                                          )
                                        : Container(),
                                  ],
                                ),
                              ),
                              Text(
                                this.widget.tblProducts.description,
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.grey,
                                  height: 1.40,
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {},
                                    child: Container(
                                      margin: EdgeInsets.only(right: 15.0),
                                      width: 60.0,
                                      height: 60.0,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        border: Border.all(
                                          color:
                                              Color.fromRGBO(230, 230, 230, 1),
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
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          border: Border.all(
                                            color: Color.fromRGBO(
                                                230, 230, 230, 1),
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
                                              fetchDataCart();
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
