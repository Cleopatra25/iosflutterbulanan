class ModelCategoryMainProduct {
  bool status;
  List<Data> data;
  int totalCount;

  ModelCategoryMainProduct({this.status, this.data, this.totalCount});

  ModelCategoryMainProduct.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    totalCount = json['total_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['total_count'] = this.totalCount;
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
    idProduct = json['id_product'].toString() ?? '';
    idProductCategory = json['id_product_category'].toString() ?? '';
    idWarehouse = json['id_warehouse'].toString() ?? '';
    idFlashSale = json['id_flash_sale'].toString() ?? '';
    pirceFlashSale = json['pirce_flash_sale'].toString() ?? '';
    quantityFlashSale = json['quantity_flash_sale'].toString() ?? '';
    position = json['position'].toString() ?? '';
    quantityBuy = json['quantity_buy'].toString() ?? '';
    idHighlight = json['id_highlight'].toString() ?? '';
    barcode = json['barcode'].toString() ?? '';
    productName = json['product_name'].toString() ?? '';
    slug = json['slug'].toString() ?? '';
    meta = json['meta'].toString() ?? '';
    description = json['description'].toString() ?? '';
    image = json['image'].toString() ?? '';
    stock = json['stock'].toString() ?? '';
    unit = json['unit'].toString() ?? '';
    pricePerUnit = json['price_per_unit'].toString() ?? '';
    pricePromo = json['price_promo'].toString() ?? '';
    priceGold = json['price_gold'].toString() ?? '';
    discount = json['discount'].toString() ?? '';
    views = json['views'].toString() ?? '';
    idTag = json['id_tag'].toString() ?? '';
    expDate = json['exp_date'].toString() ?? '';
    expDateBefore = json['exp_date_before'].toString() ?? '';
    isPromo = json['is_promo'].toString() ?? '';
    isFresh = json['is_fresh'].toString() ?? '';
    isRecomended = json['is_recomended'].toString() ?? '';
    isGetone = json['is_getone'].toString() ?? '';
    isPublished = json['is_published'].toString() ?? '';
    isDaily = json['is_daily'].toString() ?? '';
    qtyDaily = json['qty_daily'].toString() ?? '';
    limit = json['limit'].toString() ?? '';
    qtyPromo = json['qty_promo'].toString() ?? '';
    idTebusMurah = json['id_tebus_murah'].toString() ?? '';
    hargaTebusMurah = json['harga_tebus_murah'].toString() ?? '';
    createdDate = json['created_date'].toString() ?? '';
    updatedDate = json['updated_date'].toString() ?? '';
    createdBy = json['created_by'].toString() ?? '';
    updatedBy = json['updated_by'].toString() ?? '';
    percent = json['percent'] ?? 0;
    quantity = int.parse(json['quantity'].toString());
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
