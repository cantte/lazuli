library orders;

import 'package:lazuli/src/orders/models.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OrderService {
  final client = Supabase.instance.client;

  Future create(Order order) async {
    var result =
        await client.from('orders').insert(order.toJson()).select().single();

    var createdOrder = Order.fromJson(result);

    for (var element in order.items) {
      element.orderId = createdOrder.id;
    }

    await client
        .from('order_items')
        .insert(order.items.map((e) => e.toJson()).toList());
  }
}
