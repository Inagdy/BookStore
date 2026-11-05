import 'dart:convert';

CartResponse cartResponseFromJson(String str) =>
    CartResponse.fromJson(json.decode(str));

double _d(dynamic v) => double.tryParse(v.toString()) ?? 0.0;

class CartResponse {
  final CartData? data;
  final String message;
  final List<dynamic> error;
  final int status;

  CartResponse({
    required this.data,
    required this.message,
    required this.error,
    required this.status,
  });

  factory CartResponse.fromJson(Map<String, dynamic> json) => CartResponse(
        data: json['data'] != null ? CartData.fromJson(json['data']) : null,
        message: json['message'] ?? '',
        error: List<dynamic>.from(json['error'] ?? []),
        status: json['status'] ?? 0,
      );
}

class CartData {
  final int id;
  final User? user;
  final double total;
  final List<CartItem> cartItems;

  CartData({
    required this.id,
    this.user,
    required this.total,
    required this.cartItems,
  });

  factory CartData.fromJson(Map<String, dynamic> json) => CartData(
        id: json['id'] ?? 0,
        user: json['user'] != null ? User.fromJson(json['user']) : null,
        total: _d(json['total']),
        cartItems: json['cart_items'] != null
            ? List<CartItem>.from(
                (json['cart_items'] as List).map((x) => CartItem.fromJson(x)))
            : [],
      );
}

class User {
  final int userId;
  final String userName;

  User({required this.userId, required this.userName});

  factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json['user_id'] ?? 0,
        userName: json['user_name'] ?? '',
      );
}

class CartItem {
  final int itemId;
  final int productId;
  final String name;
  final String image;
  final double price;
  final int discount;
  final double priceAfterDiscount;
  final int stock;
  final int quantity;
  final double total;

  CartItem({
    required this.itemId,
    required this.productId,
    required this.name,
    required this.image,
    required this.price,
    required this.discount,
    required this.priceAfterDiscount,
    required this.stock,
    required this.quantity,
    required this.total,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        itemId: json['item_id'] ?? 0,
        productId: json['item_product_id'] ?? 0,
        name: json['item_product_name'] ?? '',
        image: json['item_product_image'] ?? '',
        price: _d(json['item_product_price']),
        discount: json['item_product_discount'] ?? 0,
        priceAfterDiscount: _d(json['item_product_price_after_discount']),
        stock: json['item_product_stock'] ?? 0,
        quantity: json['item_quantity'] ?? 1,
        total: _d(json['item_total']),
      );
}
