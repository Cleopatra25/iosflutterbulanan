class ModelDetailProduct {
  bool status;
  Data data;

  ModelDetailProduct({this.status, this.data});

  ModelDetailProduct.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  Product product;
  List<RelatedProduct> relatedProduct;

  Data({this.product, this.relatedProduct});

  Data.fromJson(Map<String, dynamic> json) {
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
    if (json['related_product'] != null) {
      relatedProduct = <RelatedProduct>[];
      json['related_product'].forEach((v) {
        relatedProduct.add(new RelatedProduct.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.product != null) {
      data['product'] = this.product.toJson();
    }
    if (this.relatedProduct != null) {
      data['related_product'] =
          this.relatedProduct.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Product {
  String priceFlashSale;
  String idProduct;
  String idProductCategory;
  String idWarehouse;
  String idFlashSale;
  String quantityFlashSale;
  String position;
  String quantityBuy;
  String idHighlight;
  String barcode;
  String unit;
  String description;
  String productName;
  String slug;
  String meta;
  String image;
  String stock;
  String pricePerUnit;
  String pricePromo;
  String priceGold;
  String discount;
  String views;
  String idTag;
  String expDate;
  String expDateBefore;
  String isPromo;
  String isFresh;
  String isRecomended;
  String isGetone;
  String isPublished;
  String isDaily;
  String qtyDaily;
  String qtyPromo;
  String idTebusMurah;
  String hargaTebusMurah;
  String category;

  Product(
      {this.priceFlashSale,
      this.idProduct,
      this.idProductCategory,
      this.idWarehouse,
      this.idFlashSale,
      this.quantityFlashSale,
      this.position,
      this.quantityBuy,
      this.idHighlight,
      this.barcode,
      this.unit,
      this.description,
      this.productName,
      this.slug,
      this.meta,
      this.image,
      this.stock,
      this.pricePerUnit,
      this.pricePromo,
      this.priceGold,
      this.discount,
      this.views,
      this.idTag,
      this.expDate,
      this.expDateBefore,
      this.isPromo,
      this.isFresh,
      this.isRecomended,
      this.isGetone,
      this.isPublished,
      this.isDaily,
      this.qtyDaily,
      this.qtyPromo,
      this.idTebusMurah,
      this.hargaTebusMurah,
      this.category});

  Product.fromJson(Map<String, dynamic> json) {
    priceFlashSale = json['price_flash_sale'] ?? '';
    idProduct = json['id_product'] ?? '';
    idProductCategory = json['id_product_category'] ?? '';
    idWarehouse = json['id_warehouse'] ?? '';
    idFlashSale = json['id_flash_sale'];
    quantityFlashSale = json['quantity_flash_sale'] ?? '';
    position = json['position'] ?? '';
    quantityBuy = json['quantity_buy'] ?? '';
    idHighlight = json['id_highlight'] ?? '';
    barcode = json['barcode'] ?? '';
    unit = json['unit'] ?? '';
    description = json['description'] ?? '';
    productName = json['product_name'] ?? '';
    slug = json['slug'] ?? '';
    meta = json['meta'] ?? '';
    image = json['image'] ?? '';
    stock = json['stock'] ?? '';
    pricePerUnit = json['price_per_unit'] ?? '';
    pricePromo = json['price_promo'] ?? '';
    priceGold = json['price_gold'] ?? '';
    discount = json['discount'] ?? '';
    views = json['views'] ?? '';
    idTag = json['id_tag'] ?? '';
    expDate = json['exp_date'] ?? '';
    expDateBefore = json['exp_date_before'] ?? '';
    isPromo = json['is_promo'] ?? '';
    isFresh = json['is_fresh'] ?? '';
    isRecomended = json['is_recomended'] ?? '';
    isGetone = json['is_getone'] ?? '';
    isPublished = json['is_published'] ?? '';
    isDaily = json['is_daily'] ?? '';
    qtyDaily = json['qty_daily'] ?? '';
    qtyPromo = json['qty_promo'] ?? '';
    idTebusMurah = json['id_tebus_murah'] ?? '';
    hargaTebusMurah = json['harga_tebus_murah'] ?? '';

    category = json['category'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['price_flash_sale'] = this.priceFlashSale;
    data['id_product'] = this.idProduct;
    data['id_product_category'] = this.idProductCategory;
    data['id_warehouse'] = this.idWarehouse;
    data['id_flash_sale'] = this.idFlashSale;
    data['quantity_flash_sale'] = this.quantityFlashSale;
    data['position'] = this.position;
    data['quantity_buy'] = this.quantityBuy;
    data['id_highlight'] = this.idHighlight;
    data['barcode'] = this.barcode;
    data['unit'] = this.unit;
    data['description'] = this.description;
    data['product_name'] = this.productName;
    data['slug'] = this.slug;
    data['meta'] = this.meta;
    data['image'] = this.image;
    data['stock'] = this.stock;
    data['price_per_unit'] = this.pricePerUnit;
    data['price_promo'] = this.pricePromo;
    data['price_gold'] = this.priceGold;
    data['discount'] = this.discount;
    data['views'] = this.views;
    data['id_tag'] = this.idTag;
    data['exp_date'] = this.expDate;
    data['exp_date_before'] = this.expDateBefore;
    data['is_promo'] = this.isPromo;
    data['is_fresh'] = this.isFresh;
    data['is_recomended'] = this.isRecomended;
    data['is_getone'] = this.isGetone;
    data['is_published'] = this.isPublished;
    data['is_daily'] = this.isDaily;
    data['qty_daily'] = this.qtyDaily;
    data['qty_promo'] = this.qtyPromo;
    data['id_tebus_murah'] = this.idTebusMurah;
    data['harga_tebus_murah'] = this.hargaTebusMurah;

    data['category'] = this.category;
    return data;
  }
}

class RelatedProduct {
  String priceFlashSale;
  String idProduct;
  String idProductCategory;
  String idWarehouse;
  String idFlashSale;
  String quantityFlashSale;
  String position;
  String quantityBuy;
  String idHighlight;
  String barcode;
  String description;
  String unit;
  String productName;
  String slug;
  String meta;
  String image;
  String stock;
  String pricePerUnit;
  String pricePromo;
  String priceGold;
  String discount;
  String views;
  String idTag;
  String expDate;
  String expDateBefore;
  String isPromo;
  String isFresh;
  String isRecomended;
  String isGetone;
  String isPublished;
  String isDaily;
  String qtyDaily;
  String qtyPromo;
  String idTebusMurah;
  String hargaTebusMurah;

  RelatedProduct(
      {this.priceFlashSale,
      this.idProduct,
      this.idProductCategory,
      this.idWarehouse,
      this.idFlashSale,
      this.quantityFlashSale,
      this.position,
      this.quantityBuy,
      this.idHighlight,
      this.barcode,
      this.description,
      this.unit,
      this.productName,
      this.slug,
      this.meta,
      this.image,
      this.stock,
      this.pricePerUnit,
      this.pricePromo,
      this.priceGold,
      this.discount,
      this.views,
      this.idTag,
      this.expDate,
      this.expDateBefore,
      this.isPromo,
      this.isFresh,
      this.isRecomended,
      this.isGetone,
      this.isPublished,
      this.isDaily,
      this.qtyDaily,
      this.qtyPromo,
      this.idTebusMurah,
      this.hargaTebusMurah});

  RelatedProduct.fromJson(Map<String, dynamic> json) {
    priceFlashSale = json['price_flash_sale'] ?? '';
    idProduct = json['id_product'] ?? '';
    idProductCategory = json['id_product_category'] ?? '';
    idWarehouse = json['id_warehouse'] ?? '';
    idFlashSale = json['id_flash_sale'] ?? '';
    quantityFlashSale = json['quantity_flash_sale'] ?? '';
    position = json['position'] ?? '';
    quantityBuy = json['quantity_buy'] ?? '';
    idHighlight = json['id_highlight'] ?? '';
    barcode = json['barcode'] ?? '';
    description = json['description'] ?? '';
    unit = json['unit'] ?? '';
    productName = json['product_name'] ?? '';
    slug = json['slug'] ?? '';
    meta = json['meta'] ?? '';
    image = json['image'] ?? '';
    stock = json['stock'] ?? '';
    pricePerUnit = json['price_per_unit'] ?? '';
    pricePromo = json['price_promo'] ?? '';
    priceGold = json['price_gold'] ?? '';
    discount = json['discount'] ?? '';
    views = json['views'] ?? '';
    idTag = json['id_tag'] ?? '';
    expDate = json['exp_date'] ?? '';
    expDateBefore = json['exp_date_before'] ?? '';
    isPromo = json['is_promo'] ?? '';
    isFresh = json['is_fresh'] ?? '';
    isRecomended = json['is_recomended'] ?? '';
    isGetone = json['is_getone'] ?? '';
    isPublished = json['is_published'] ?? '';
    isDaily = json['is_daily'] ?? '';
    qtyDaily = json['qty_daily'] ?? '';
    qtyPromo = json['qty_promo'] ?? '';
    idTebusMurah = json['id_tebus_murah'] ?? '';
    hargaTebusMurah = json['harga_tebus_murah'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['price_flash_sale'] = this.priceFlashSale;
    data['id_product'] = this.idProduct;
    data['id_product_category'] = this.idProductCategory;
    data['id_warehouse'] = this.idWarehouse;
    data['id_flash_sale'] = this.idFlashSale;
    data['quantity_flash_sale'] = this.quantityFlashSale;
    data['position'] = this.position;
    data['quantity_buy'] = this.quantityBuy;
    data['id_highlight'] = this.idHighlight;
    data['barcode'] = this.barcode;
    data['description'] = this.description;
    data['unit'] = this.unit;
    data['product_name'] = this.productName;
    data['slug'] = this.slug;
    data['meta'] = this.meta;
    data['image'] = this.image;
    data['stock'] = this.stock;
    data['price_per_unit'] = this.pricePerUnit;
    data['price_promo'] = this.pricePromo;
    data['price_gold'] = this.priceGold;
    data['discount'] = this.discount;
    data['views'] = this.views;
    data['id_tag'] = this.idTag;
    data['exp_date'] = this.expDate;
    data['exp_date_before'] = this.expDateBefore;
    data['is_promo'] = this.isPromo;
    data['is_fresh'] = this.isFresh;
    data['is_recomended'] = this.isRecomended;
    data['is_getone'] = this.isGetone;
    data['is_published'] = this.isPublished;
    data['is_daily'] = this.isDaily;
    data['qty_daily'] = this.qtyDaily;
    data['qty_promo'] = this.qtyPromo;
    data['id_tebus_murah'] = this.idTebusMurah;
    data['harga_tebus_murah'] = this.hargaTebusMurah;
    return data;
  }
}
