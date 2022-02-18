// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  Product({
    this.tblProducts,
  });

  List<TblProduct> tblProducts;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        tblProducts: List<TblProduct>.from(
            json["tbl_products"].map((x) => TblProduct.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "tbl_products": List<dynamic>.from(tblProducts.map((x) => x.toJson())),
      };
}

class TblProduct with ChangeNotifier {
  TblProduct({
    this.idProduct,
    this.productName,
    this.brand,
    this.description,
    this.category,
    this.model,
    this.image,
    this.price,
    this.gst,
    this.qty,
    this.status,
  });

  String idProduct;
  String productName;
  String brand;
  String description;
  String category;
  String model;
  String image;
  String price;
  String gst;
  String qty;
  String status;

  factory TblProduct.fromJson(Map<String, dynamic> json) => TblProduct(
        idProduct: json["id_product"],
        productName: json["product_name"],
        brand: json["brand"],
        description: json["description"],
        category: json["category"],
        model: json["model"],
        image: json["image"],
        price: json["price"],
        gst: json["gst"],
        qty: json["qty"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id_product": idProduct,
        "product_name": productName,
        "brand": brand,
        "description": description,
        "category": category,
        "model": model,
        "image": image,
        "price": price,
        "gst": gst,
        "qty": qty,
        "status": status,
      };
}

enum Category { MEN_S_WATCH, WOMEN_S_WATCH, WOMEN_WATCH, WOMENS_WATCH }

final categoryValues = EnumValues({
  "Men's Watch": Category.MEN_S_WATCH,
  "Womens' Watch": Category.WOMENS_WATCH,
  "Women's Watch": Category.WOMEN_S_WATCH,
  "Women' Watch": Category.WOMEN_WATCH
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
