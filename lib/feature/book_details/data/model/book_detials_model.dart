class BookDetialsModel {
  Data? data;
  String? message;
  List<dynamic>? error;
  int? status;

  BookDetialsModel({this.data, this.message, this.error, this.status});

  BookDetialsModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
    if (json['error'] != null) {
      error = List<dynamic>.from(json['error']);
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    if (this.error != null) {
      data['error'] = this.error;
    }
    data['status'] = this.status;
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? description;
  int? stock;
  int? bestSeller;
  String? price;
  int? discount;
  double? priceAfterDiscount;
  String? image;
  String? category;

  Data(
      {this.id,
      this.name,
      this.description,
      this.stock,
      this.bestSeller,
      this.price,
      this.discount,
      this.priceAfterDiscount,
      this.image,
      this.category});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    stock = json['stock'];
    bestSeller = json['best_seller'];
    price = json['price'];
    discount = json['discount'];
    priceAfterDiscount = json['price_after_discount'];
    image = json['image'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['stock'] = this.stock;
    data['best_seller'] = this.bestSeller;
    data['price'] = this.price;
    data['discount'] = this.discount;
    data['price_after_discount'] = this.priceAfterDiscount;
    data['image'] = this.image;
    data['category'] = this.category;
    return data;
  }
}