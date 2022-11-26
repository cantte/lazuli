library orders;

import 'package:lazuli/src/products/models.dart';

class Order {
  late int id;

  final String customerName;
  final String customerAddress;
  final String customerPhone;

  final List<OrderItem> items;

  Order({
    required this.customerName,
    required this.customerAddress,
    required this.customerPhone,
    required this.items,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      customerName: json['customer_name'],
      customerAddress: json['customer_address'],
      customerPhone: json['customer_phone'],
      items: (json['items'] as List<dynamic>)
          .map((e) => OrderItem.fromJson(e))
          .toList(),
    );
  }

  factory Order.fromForm(Map<String, dynamic> map) {
    return Order(
      customerName: map['customer_name'],
      customerAddress: map['customer_address'],
      customerPhone: map['customer_phone'],
      items: (map['items'] as List<dynamic>)
          .map((e) => OrderItem.fromForm(e))
          .toList(),
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
