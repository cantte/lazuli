class Product {
  final String id;
  final String name;
  final String description;

  final double price;
  final int quantity;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.quantity,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'].toDouble(),
      quantity: json['quantity'],
    );
  }

  factory Product.fromForm(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      price: double.parse(map['price']),
      quantity: int.parse(map['quantity']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'quantity': quantity,
    };
  }

  Map<String, dynamic> toForm() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price.toString(),
      'quantity': quantity.toString(),
    };
  }
}
