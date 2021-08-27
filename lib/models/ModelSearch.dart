class ModelSearch {
  bool status;
  int count;
  List<Data> data;

  ModelSearch({this.status, this.count, this.data});

  ModelSearch.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    count = json['count'] ?? 0;
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['count'] = this.count;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String idProduct;
  String idProductCategory;
  String idWarehouse;
  String idFlashSale;
  String pirceFlashSale;
  String quantityFlashSale;
  String position;
  String quantityBuy;
  String idHighlight;
  String barcode;
  String productName;
  String slug;
  String meta;
  String description;
  String image;
  String stock;
  String unit;
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
  String limit;
  String qtyPromo;
  String idTebusMurah;
  String hargaTebusMurah;
  String createdDate;
  String updatedDate;
  String createdBy;
  String updatedBy;
  int percent;
  int quantity;

  Data(
      {this.idProduct,
      this.idProductCategory,
      this.idWarehouse,
      this.idFlashSale,
      this.pirceFlashSale,
      this.quantityFlashSale,
      this.position,
      this.quantityBuy,
      this.idHighlight,
      this.barcode,
      this.productName,
      this.slug,
      this.meta,
      this.description,
      this.image,
      this.stock,
      this.unit,
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
      this.limit,
      this.qtyPromo,
      this.idTebusMurah,
      this.hargaTebusMurah,
      this.createdDate,
      this.updatedDate,
      this.createdBy,
      this.updatedBy,
      this.percent,
      this.quantity});

  Data.fromJson(Map<String, dynamic> json) {
    idProduct = json['id_product'] ?? '';
    idProductCategory = json['id_product_category'] ?? '';
    idWarehouse = json['id_warehouse'] ?? '';
    idFlashSale = json['id_flash_sale'] ?? '';
    pirceFlashSale = json['pirce_flash_sale'] ?? '';
    quantityFlashSale = json['quantity_flash_sale'] ?? '';
    position = json['position'] ?? '';
    quantityBuy = json['quantity_buy'] ?? '';
    idHighlight = json['id_highlight'] ?? '';
    barcode = json['barcode'] ?? '';
    productName = json['product_name'] ?? '';
    slug = json['slug'] ?? '';
    meta = json['meta'] ?? '';
    description = json['description'] ?? '';
    image = json['image'] ?? '';
    stock = json['stock'] ?? '';
    unit = json['unit'] ?? '';
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
    limit = json['limit'] ?? '';
    qtyPromo = json['qty_promo'] ?? '';
    idTebusMurah = json['id_tebus_murah'] ?? '';
    hargaTebusMurah = json['harga_tebus_murah'] ?? '';
    createdDate = json['created_date'] ?? '';
    updatedDate = json['updated_date'] ?? '';
    createdBy = json['created_by'] ?? '';
    updatedBy = json['updated_by'] ?? '';

    print('anying ${json['quantity']}');
    quantity = int.parse(json['quantity'].toString()) != null
        ? int.parse(json['quantity'].toString())
        : 0;

    percent = json['percent'] != null ? json['percent'] : 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_product'] = this.idProduct;
    data['id_product_category'] = this.idProductCategory;
    data['id_warehouse'] = this.idWarehouse;
    data['id_flash_sale'] = this.idFlashSale;
    data['pirce_flash_sale'] = this.pirceFlashSale;
    data['quantity_flash_sale'] = this.quantityFlashSale;
    data['position'] = this.position;
    data['quantity_buy'] = this.quantityBuy;
    data['id_highlight'] = this.idHighlight;
    data['barcode'] = this.barcode;
    data['product_name'] = this.productName;
    data['slug'] = this.slug;
    data['meta'] = this.meta;
    data['description'] = this.description;
    data['image'] = this.image;
    data['stock'] = this.stock;
    data['unit'] = this.unit;
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
    data['limit'] = this.limit;
    data['qty_promo'] = this.qtyPromo;
    data['id_tebus_murah'] = this.idTebusMurah;
    data['harga_tebus_murah'] = this.hargaTebusMurah;
    data['created_date'] = this.createdDate;
    data['updated_date'] = this.updatedDate;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['percent'] = this.percent;
    data['quantity'] = this.quantity;
    return data;
  }
}
