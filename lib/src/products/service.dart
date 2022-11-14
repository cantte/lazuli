library products;

import 'package:lazuli/src/products/models.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductService {
  final client = Supabase.instance.client;

  Future<void> create(Product product) async {
    await client.from('products').insert(product);
  }
}
