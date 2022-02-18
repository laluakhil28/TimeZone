import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mailto/mailto.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:watch_ui/constants.dart';
import 'package:watch_ui/p.dart';
import 'package:http/http.dart' as http;
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

class Home extends StatefulWidget {
  final TblProduct tblProducts;
  final imageUrl = (Api.image);

  Home(
    this.tblProducts,
  );

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<TblProduct> data = [];

  String _phone = '+91-9607418866';

  void fetchProduct() async {
    var url = Uri.parse(Api.productdata);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      setState(
        () {
          data = productFromJson(response.body).tblProducts;
        },
      );
    }
  }

  Future<void> _call(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  launchWhatsApp() async {
    final link1 = WhatsAppUnilink(
      phoneNumber: '+91-9607418866',
      text: "Hi!! *Team Pisyst India*, we have an enquiry for you",
    );
    await launch('$link1');
  }

  _launch1() async {
    const url = 'https://pi-sy.com/';
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: true, forceWebView: true);
    } else {
      throw 'Could not launch $url';
    }
  }

  launchMailto() async {
    final mailtoLink = Mailto(
      to: [' @gmail.com'],
      cc: ['saifsayyed@gmail.com'],
      subject: 'Demo',
      body: 'Watch',
    );
    // Convert the Mailto instance into a string.
    // Use either Dart's string interpolation
    // or the toString() method.
    await launch('$mailtoLink');
  }

  @override
  void initState() {
    super.initState();
    fetchProduct();
  }

  Widget build(BuildContext context) {
    return Scaffold(
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

      drawer: Drawer(
        elevation: 10,
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Clr.pcolor,
              ),
              currentAccountPicture: Image.asset(
                'Assets/images/u2.png',
                fit: BoxFit.fill,
              ),
              // currentAccountPictureSize: Size(80, 80),
              accountName: Text(
                Con.name,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              accountEmail: Text(
                '',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _call('tel:$_phone');
                });
              },
              child: ListTile(
                leading: Icon(
                  Icons.phone_outlined,
                  size: 25,
                  color: Colors.black,
                ),
                title: Text(
                  'Call',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 25,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 15),
            GestureDetector(
              onTap: () {
                setState(() {
                  launchWhatsApp();
                });
              },
              child: ListTile(
                leading: Icon(
                  Icons.message_outlined,
                  size: 25,
                  color: Colors.black,
                ),
                title: Text(
                  'Message',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 25,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 15),
            GestureDetector(
              onTap: () {
                setState(() {
                  launchMailto();
                });
              },
              child: ListTile(
                leading: Icon(
                  Icons.mail_outline,
                  size: 25,
                  color: Colors.black,
                ),
                title: Text(
                  'G-mail',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 25,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 15),
            GestureDetector(
              onTap: () {
                VxNavigator.of(context).push(
                  Uri(path: "/fb"),
                );
              },
              child: ListTile(
                leading: Icon(
                  Icons.feedback_outlined,
                  size: 25,
                  color: Colors.black,
                ),
                title: Text(
                  'Feedback',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 25,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 15),
            GestureDetector(
              onTap: () {
                setState(() {
                  _launch1();
                });
              },
              child: ListTile(
                leading: Icon(
                  Icons.info_outline,
                  size: 25,
                  color: Colors.black,
                ),
                title: Text(
                  'About US',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 25,
                  color: Colors.black,
                ),
              ),
            ),
            Divider(
              height: 1,
              thickness: 1,
            ),
            SizedBox(height: 15),
            GestureDetector(
              onTap: () {
                VxNavigator.of(context).push(
                  Uri(path: "/login"),
                );
              },
              child: ListTile(
                leading: Icon(
                  Icons.logout_outlined,
                  size: 25,
                  color: Colors.black,
                ),
                title: Text(
                  'Logout',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 25,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),

      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.27,
            child: Row(
              children: [
                Expanded(
                  child: Container(),
                ),
                Expanded(
                  child: Container(
                    color: Clr.pcolor,
                  ),
                ),
              ],
            ),
          ),
          SafeArea(
            child: ListView(
              children: [
                //MainAppBar(),
                SizedBox(
                  height: 40,
                ),
                Container(
                  margin: EdgeInsets.only(left: 30),
                  child: RichText(
                    textAlign: TextAlign.left,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Time Zone\n",
                          style: TextStyle(
                            // height: 2.5,
                            fontSize: 35.0,
                            fontWeight: FontWeight.w600,
                            color: Clr.pcolor,
                            fontStyle: FontStyle.italic,
                            //color: Color.fromRGBO(34, 34, 34, 1),
                          ),
                        ),
                        TextSpan(
                          text: "   The World\n",
                          style: TextStyle(
                            // height: 2.5,
                            fontSize: 27.0,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.italic,
                            //color: Clr.pcolor,
                            color: Color.fromRGBO(34, 34, 34, 1),
                          ),
                        ),
                        TextSpan(
                          text: "    of Luxury",
                          style: TextStyle(
                            fontSize: 27.0,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.italic,
                            //color: Clr.pcolor,
                            color: Color.fromRGBO(34, 34, 34, 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 50.0,
                ),
                StaggeredGridView.countBuilder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 4,
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    TblProduct pro = data[index];
                    return GestureDetector(
                      onTap: () {
                        VxNavigator.of(context).push(
                          Uri(path: '/details'),
                          params: pro,
                        );
                      },
                      child: Card(
                        elevation: 5.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            8.0,
                          ),
                        ),
                        child: Container(
                          margin: EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Expanded(
                                child: CachedNetworkImage(
                                  imageUrl: this.widget.imageUrl + pro.image,
                                ),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                pro.brand,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 3.0,
                              ),
                              Text(
                                pro.category,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  staggeredTileBuilder: (int index) =>
                      new StaggeredTile.count(2, index.isEven ? 3 : 2),
                  mainAxisSpacing: 2.0,
                  crossAxisSpacing: 2.0,
                ),
              ],
            ),
          ),
        ],
      ),

      // GridView.builder(
      //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //     crossAxisCount: 2,
      //   ),
      //   itemCount: data.length,
      //   itemBuilder: (context, index) {
      //     TblProduct p = data[index];
      //     return Padding(
      //       padding: EdgeInsets.all(5.0),
      //       child: Column(
      //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //         children: <Widget>[
      //           GestureDetector(
      //             onTap: () {
      //               VxNavigator.of(context).push(
      //                 Uri(path: '/details'),
      //                 params: p,
      //               );
      //             },
      //             child: Container(
      //               height: 120.0,
      //               width: 120.0,
      //               child: CachedNetworkImage(
      //                   imageUrl: this.widget.imageUrl + p.image),
      //             ),
      //           ),
      //           Text(
      //             p.brand,
      //             style: TextStyle(
      //                 fontSize: 16.0,
      //                 fontWeight: FontWeight.bold,
      //                 color: Colors.black87),
      //           ),
      //           Text(
      //             p.category,
      //             style: TextStyle(
      //                 fontSize: 16.0,
      //                 fontWeight: FontWeight.bold,
      //                 color: Colors.black87),
      //           ),
      //         ],
      //       ),
      //     );
      //   },
      // ),
    );
  }
}
