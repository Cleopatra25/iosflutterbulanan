class ModelCouponsingle {
  bool status;
  String message;
  int count;
  Data data;

  ModelCouponsingle({this.status, this.message, this.count, this.data});

  ModelCouponsingle.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    count = json['count'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['count'] = this.count;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  String idCoupon;
  String couponName;
  String couponDescription;
  String couponCode;
  String validFrom;
  String validTo;
  String couponAmount;
  Null persentasi;
  String minimunOrder;
  String maximalPrice;
  String image;
  String type;
  Null usesRestriction;
  String isPublished;
  String isHide;
  String isShop;
  String isActive;
  String qtyCoupoun;
  String nomialShop;
  String createdDate;
  Null updatedDate;
  String createdBy;
  Null updatedBy;

  Data(
      {this.idCoupon,
      this.couponName,
      this.couponDescription,
      this.couponCode,
      this.validFrom,
      this.validTo,
      this.couponAmount,
      this.persentasi,
      this.minimunOrder,
      this.maximalPrice,
      this.image,
      this.type,
      this.usesRestriction,
      this.isPublished,
      this.isHide,
      this.isShop,
      this.isActive,
      this.qtyCoupoun,
      this.nomialShop,
      this.createdDate,
      this.updatedDate,
      this.createdBy,
      this.updatedBy});

  Data.fromJson(Map<String, dynamic> json) {
    idCoupon = json['id_coupon'];
    couponName = json['coupon_name'];
    couponDescription = json['coupon_description'];
    couponCode = json['coupon_code'];
    validFrom = json['valid_from'];
    validTo = json['valid_to'];
    couponAmount = json['coupon_amount'];
    persentasi = json['persentasi'];
    minimunOrder = json['minimun_order'];
    maximalPrice = json['maximal_price'];
    image = json['image'];
    type = json['type'];
    usesRestriction = json['uses_restriction'];
    isPublished = json['is_published'];
    isHide = json['is_hide'];
    isShop = json['is_shop'];
    isActive = json['is_active'];
    qtyCoupoun = json['qty_coupoun'];
    nomialShop = json['nomial_shop'];
    createdDate = json['created_date'];
    updatedDate = json['updated_date'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_coupon'] = this.idCoupon;
    data['coupon_name'] = this.couponName;
    data['coupon_description'] = this.couponDescription;
    data['coupon_code'] = this.couponCode;
    data['valid_from'] = this.validFrom;
    data['valid_to'] = this.validTo;
    data['coupon_amount'] = this.couponAmount;
    data['persentasi'] = this.persentasi;
    data['minimun_order'] = this.minimunOrder;
    data['maximal_price'] = this.maximalPrice;
    data['image'] = this.image;
    data['type'] = this.type;
    data['uses_restriction'] = this.usesRestriction;
    data['is_published'] = this.isPublished;
    data['is_hide'] = this.isHide;
    data['is_shop'] = this.isShop;
    data['is_active'] = this.isActive;
    data['qty_coupoun'] = this.qtyCoupoun;
    data['nomial_shop'] = this.nomialShop;
    data['created_date'] = this.createdDate;
    data['updated_date'] = this.updatedDate;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    return data;
  }
}
