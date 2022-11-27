library orders;

import 'package:lazuli/src/products/models.dart';

class Order {
  late int id;

  final String customerName;
  final String customerAddress;
  final String customerPhone;

  late List<OrderItem> items;

  Order({
    required this.customerName,
    required this.customerAddress,
    required this.customerPhone,
  }) {
    items = [];
    id = 0;
  }

  Order.withId({
    required this.id,
    required this.customerName,
    required this.customerAddress,
    required this.customerPhone,
  }) {
    items = [];
  }

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order.withId(
      id: json['id'],
      customerName: json['customer_name'],
      customerAddress: json['customer_address'],
      customerPhone: json['customer_phone'],
    );
  }

  factory Order.fromForm(Map<String, dynamic> map) {
    return Order(
      customerName: map['customer_name'],
      customerAddress: map['customer_address'],
      customerPhone: map['customer_phone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'customer_name': customerName,
      'customer_address': customerAddress,
      'customer_phone': customerPhone,
    };
  }
}

class OrderItem {
  final String productId;
  final int quantity;

  late Product product;
  late int orderId;

  OrderItem({
    required this.productId,
    required this.quantity,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      productId: json['product_id'],
      quantity: json['quantity'].toInt(),
    );
  }

  factory OrderItem.fromForm(Map<String, dynamic> map) {
    return OrderItem(
      productId: map['product_id'],
      quantity: int.parse(map['quantity']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'order_id': orderId,
      'quantity': quantity.toString(),
    };
  }

  Map<String, dynamic> toForm() {
    return {
      'product_id': productId,
      'quantity': quantity.toString(),
    };
  }

  double get total => product.price * quantity;
}
