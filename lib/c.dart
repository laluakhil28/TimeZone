// To parse this JSON data, do
//
//     final cart = cartFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/foundation.dart';

List<Cart> cartFromJson(String str) =>
    List<Cart>.from(json.decode(str).map((x) => Cart.fromJson(x)));

String cartToJson(List<Cart> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Cart with ChangeNotifier {
  Cart({
    this.cartId,
    this.cartName,
    this.cartQty,
    this.cartPrice,
    this.cartGst,
  });

  String cartId;
  String cartName;
  String cartQty;
  String cartPrice;
  String cartGst;

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        cartId: json["cart_id"],
        cartName: json["cart_name"],
        cartQty: json["cart_qty"],
        cartPrice: json["cart_price"],
        cartGst: json["cart_gst"],
      );

  Map<String, dynamic> toJson() => {
        "cart_id": cartId,
        "cart_name": cartName,
        "cart_qty": cartQty,
        "cart_price": cartPrice,
        "cart_gst": cartGst,
      };
  void removeItem(String cartId) {
    _items.remove(cartId);
  }
}

Map<String, Cart> _items = {};

Map<String, Cart> get items {
  return {..._items};
}

int get itemCount {
  return _items.length;
}

void addItem(String pdtid, String name, double price) {
  if (_items.containsKey(pdtid)) {
    _items.update(
        pdtid,
        (existingaCart) => Cart(
            cartId: existingaCart.cartId,
            cartName: existingaCart.cartName,
            cartQty: existingaCart.cartQty + 1.toString(),
            cartPrice: existingaCart.cartPrice));
  } else {
    _items.putIfAbsent(
        pdtid,
        () => Cart(
              cartName: name,
              cartId: DateTime.now().toString(),
              cartQty: 1.toString(),
              cartPrice: price.toString(),
            ));
  }
  // notifyListeners();
}

// void removeItem(String id) {
//   _items.remove(id);
//   // notifyListeners();
// }

void removeSingleItem(String id) {
  if (!_items.containsKey(id)) {
    return;
  }
  if (int.parse(_items[id].cartQty) < 1) {
    _items.update(
        id,
        (existingaCart) => Cart(
            cartId: DateTime.now().toString(),
            cartName: existingaCart.cartName,
            cartQty: (int.parse(existingaCart.cartQty) - 1).toString(),
            cartPrice: existingaCart.cartPrice));
  }
  //notifyListeners();
}

double get totalAmount {
  var total = 0.0;
  _items.forEach(
    (key, addCart) {
      total += int.parse(addCart.cartPrice) * int.parse(addCart.cartQty);
    },
  );
  return total;
}

void clear() {
  _items = {};
  //notifyListeners();
}
