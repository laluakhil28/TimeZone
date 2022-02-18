import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:watch_ui/c.dart';
import 'package:watch_ui/constants.dart';

class CartScreen extends StatefulWidget {
  final Cart c;
  CartScreen(
    this.c,
  );

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List data = [];
  void crtDisplay() async {
    var url = Uri.parse(Api.cartdisplay);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      setState(
        () {
          data = cartFromJson(response.body);
        },
      );
    }
  }

  void deleteCrt(id) async {
    var apiurl = Uri.parse(Api.cartdelete);

    var response = await http.post((apiurl), body: {
      'cart_id': id,
    });

    if (response.statusCode == 200) {
      setState(() {});
    }
  }

  @override
  void initState() {
    crtDisplay();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(162, 163, 164, 1),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Clr.pcolor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        title: Center(
          child: Text(
            'Cart',
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
                    return Dismissible(
                      key: ValueKey(cart.cartId),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        color: Colors.grey[300],
                      ),
                      onDismissed: (direction) {
                        Provider.of<Cart>(context, listen: false)
                            .removeItem(cart.cartName);
                        Fluttertoast.showToast(
                            msg: "Item Removed!!",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.black,
                            textColor: Clr.pcolor,
                            fontSize: 16.0);

                        deleteCrt(cart.cartId);
                      },
                      child: Card(
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
                      ),
                    );
                  },
                ),
              ),
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
                    VxNavigator.of(context).push(
                      Uri(path: "/crtbill"),
                    );
                    crtDisplay();
                  },
                  child: Text(
                    'Proceed To Buy',
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
    );
  }
}
