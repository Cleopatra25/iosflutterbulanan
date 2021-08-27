class ModelCart {
  bool status;
  String message;
  Data data;

  ModelCart({this.status, this.message, this.data});

  ModelCart.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  int totalPrice;
  int totalDiscount;
  int deliveryPrice;
  int totalProduct;
  String isSayur;
  List<Product> product;

  Data(
      {this.totalPrice,
      this.totalDiscount,
      this.deliveryPrice,
      this.totalProduct,
      this.isSayur,
      this.product});

  Data.fromJson(Map<String, dynamic> json) {
    totalPrice = json['total_price'] ?? 0;
    totalDiscount = json['total_discount'] ?? 0;
    deliveryPrice = json['delivery_price'] ?? 0;
    totalProduct = json['total_product'] ?? 0;
    isSayur = json['is_sayur'];
    if (json['product'] != null) {
      product = <Product>[];
      json['product'].forEach((v) {
        product.add(new Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_price'] = this.totalPrice;
    data['total_discount'] = this.totalDiscount;
    data['delivery_price'] = this.deliveryPrice;
    data['total_product'] = this.totalProduct;
    data['is_sayur'] = this.isSayur;
    if (this.product != null) {
      data['product'] = this.product.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Product {
  String idCartDetail;
  String idCart;
  String idProduct;
  String productPrice;
  String productDiscount;
  String productPromo;
  String quantity;
  String totalPrice;
  String totalDiscount;
  String createdDate;
  Null updatedDate;
  String stockProduct;
  String satuan;
  String idFlashSale;
  String productPhoto;
  String promo;
  String productName;
  String promoPrice;

  Product(
      {this.idCartDetail,
      this.idCart,
      this.idProduct,
      this.productPrice,
      this.productDiscount,
      this.productPromo,
      this.quantity,
      this.totalPrice,
      this.totalDiscount,
      this.createdDate,
      this.updatedDate,
      this.stockProduct,
      this.satuan,
      this.idFlashSale,
      this.productPhoto,
      this.promo,
      this.productName,
      this.promoPrice});

  Product.fromJson(Map<String, dynamic> json) {
    idCartDetail = json['id_cart_detail'];
    idCart = json['id_cart'];
    idProduct = json['id_product'];
    productPrice = json['product_price'];
    productDiscount = json['product_discount'];
    productPromo = json['product_promo'];
    quantity = json['quantity'];
    totalPrice = json['total_price'];
    totalDiscount = json['total_discount'];
    createdDate = json['created_date'];
    updatedDate = json['updated_date'];
    stockProduct = json['stock_product'];
    satuan = json['satuan'];
    idFlashSale = json['id_flash_sale'];
    productPhoto = json['product_photo'];
    promo = json['promo'];
    productName = json['product_name'];
    promoPrice = json['promo_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_cart_detail'] = this.idCartDetail;
    data['id_cart'] = this.idCart;
    data['id_product'] = this.idProduct;
    data['product_price'] = this.productPrice;
    data['product_discount'] = this.productDiscount;
    data['product_promo'] = this.productPromo;
    data['quantity'] = this.quantity;
    data['total_price'] = this.totalPrice;
    data['total_discount'] = this.totalDiscount;
    data['created_date'] = this.createdDate;
    data['updated_date'] = this.updatedDate;
    data['stock_product'] = this.stockProduct;
    data['satuan'] = this.satuan;
    data['id_flash_sale'] = this.idFlashSale;
    data['product_photo'] = this.productPhoto;
    data['promo'] = this.promo;
    data['product_name'] = this.productName;
    data['promo_price'] = this.promoPrice;
    return data;
  }
}
