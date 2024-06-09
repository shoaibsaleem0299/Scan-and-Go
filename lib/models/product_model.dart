class ProductModel {
  String? status;
  int? code;
  String? message;
  Data? data;

  ProductModel({this.status, this.code, this.message, this.data});

  ProductModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
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
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  String? featureImage;

  Data(
      {this.id,
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
      this.featureImage});

  Data.fromJson(Map<String, dynamic> json) {
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
    featureImage = json['feature_image'];
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
    data['feature_image'] = featureImage;
    return data;
  }
}
