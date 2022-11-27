library products;

import 'package:lazuli/src/products/models.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductService {
  final client = Supabase.instance.client;

  Future create(Product product) async {
    await client.from('products').insert(product.toJson());
  }

  Future<List<Product>> searchAll() async {
    final response = await client.from('products').select();
    final products = response as List;

    return products.map((product) => Product.fromJson(product)).toList();
  }

  Future<Product> find(String id) async {
    final data = await client.from('products').select().eq('id', id);

    final product = Product.fromJson(data.first);
    return product;
  }

  Future update(Product product) async {
    await client.from('products').update(product.toJson()).eq('id', product.id);
  }
}
