// To parse this JSON data, do
//
//     final payment = paymentFromJson(jsonString);

import 'dart:convert';

Payment paymentFromJson(String str) => Payment.fromJson(json.decode(str));

String paymentToJson(Payment data) => json.encode(data.toJson());

class Payment {
  Payment({
    this.payment,
  });

  List<PaymentElement> payment;

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        payment: List<PaymentElement>.from(
            json["payment"].map((x) => PaymentElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "payment": List<dynamic>.from(payment.map((x) => x.toJson())),
      };
}

class PaymentElement {
  PaymentElement({
    this.paymentId,
    this.orderId,
    this.userId,
    this.paymentMode,
    this.amount,
    this.date,
    this.status,
  });

  String paymentId;
  String orderId;
  String userId;
  String paymentMode;
  String amount;
  String date;
  String status;

  factory PaymentElement.fromJson(Map<String, dynamic> json) => PaymentElement(
        paymentId: json["payment_id"],
        orderId: json["order_id"],
        userId: json["user_id"],
        paymentMode: json["payment_mode"],
        amount: json["amount"],
        date: json["date"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "payment_id": paymentId,
        "order_id": orderId,
        "user_id": userId,
        "payment_mode": paymentMode,
        "amount": amount,
        "date": date,
        "status": status,
      };
}
