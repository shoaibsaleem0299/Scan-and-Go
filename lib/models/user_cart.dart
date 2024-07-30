import 'package:frontend/constants/app_urls.dart';

class UserCart {
  String? status;
  int? code;
  String? message;
  Data? data;

  UserCart({this.status, this.code, this.message, this.data});

  UserCart.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;

    // Check and convert totalAmount and grandTotal to double if needed
    if (data != null) {
      data!.totalAmount = json['data']['totalAmount']?.toDouble();
      data!.grandTotal = json['data']['grandTotal']?.toDouble();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['code'] = code;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  int? userId;
  double? totalAmount;
  int? discount;
  int? tax;
  double? grandTotal;
  String? createdAt;
  dynamic deletedAt;
  String? updatedAt;
  List<Products>? products;

  Data({
    this.id,
    this.userId,
    this.totalAmount,
    this.discount,
    this.tax,
    this.grandTotal,
    this.createdAt,
    this.deletedAt,
    this.updatedAt,
    this.products,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    totalAmount = json['total_amount']?.toDouble(); // Convert to double
    discount = json['discount'];
    tax = json['tax'];
    grandTotal = json['grand_total']?.toDouble(); // Convert to double
    createdAt = json['created_at'];
    deletedAt = json['deleted_at'];
    updatedAt = json['updated_at'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['total_amount'] = totalAmount;
    data['discount'] = discount;
    data['tax'] = tax;
    data['grand_total'] = grandTotal;
    data['created_at'] = createdAt;
    data['deleted_at'] = deletedAt;
    data['updated_at'] = updatedAt;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  int? id;
  String? sku;
  String? barcode;
  String? name;
  String? description;
  String? salePrice;
  String? purchasePrice;
  String? offerPrice;
  int? stockQuantity;
  int? inOffer;
  int? active;
  dynamic deletedAt;
  String? createdAt;
  String? updatedAt;
  Pivot? pivot;
  dynamic featureImage;

  Products({
    this.id,
    this.sku,
    this.barcode,
    this.name,
    this.description,
    this.salePrice,
    this.purchasePrice,
    this.offerPrice,
    this.stockQuantity,
    this.inOffer,
    this.active,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.pivot,
    this.featureImage,
  });

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sku = json['sku'];
    barcode = json['barcode'];
    name = json['name'];
    description = json['description'];
    salePrice = json['sale_price'];
    purchasePrice = json['purchase_price'];
    offerPrice = json['offer_price'];
    stockQuantity = json['stock_quantity'];
    inOffer = json['in_offer'];
    active = json['active'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pivot = json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null;

    // Add base URL to featureImage if it's a Map
    if (json['feature_image'] != null &&
        json['feature_image'] is Map<String, dynamic>) {
      var image = json['feature_image'];
      featureImage = {
        'id': image['id'],
        'path': "${AppURL.BaseURL}/storage/${image['path']}",
        'type': image['type'],
        'imageable_type': image['imageable_type'],
        'imageable_id': image['imageable_id'],
        'deleted_at': image['deleted_at'],
        'created_at': image['created_at'],
        'updated_at': image['updated_at'],
      };
    } else {
      featureImage = json['feature_image'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['sku'] = sku;
    data['barcode'] = barcode;
    data['name'] = name;
    data['description'] = description;
    data['sale_price'] = salePrice;
    data['purchase_price'] = purchasePrice;
    data['offer_price'] = offerPrice;
    data['stock_quantity'] = stockQuantity;
    data['in_offer'] = inOffer;
    data['active'] = active;
    data['deleted_at'] = deletedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (pivot != null) {
      data['pivot'] = pivot!.toJson();
    }
    // Ensure feature_image is correctly serialized
    if (featureImage != null && featureImage is Map<String, dynamic>) {
      var image = featureImage as Map<String, dynamic>;
      data['feature_image'] = {
        'id': image['id'],
        'path': image['path'].replaceFirst("${AppURL.BaseURL}/storage/", ""),
        'type': image['type'],
        'imageable_type': image['imageable_type'],
        'imageable_id': image['imageable_id'],
        'deleted_at': image['deleted_at'],
        'created_at': image['created_at'],
        'updated_at': image['updated_at'],
      };
    } else {
      data['feature_image'] = featureImage;
    }
    return data;
  }
}

class Pivot {
  int? cartId;
  int? productId;
  int? quantity;

  Pivot({
    this.cartId,
    this.productId,
    this.quantity,
  });

  Pivot.fromJson(Map<String, dynamic> json) {
    cartId = json['cart_id'];
    productId = json['product_id'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cart_id'] = cartId;
    data['product_id'] = productId;
    data['quantity'] = quantity;
    return data;
  }
}
