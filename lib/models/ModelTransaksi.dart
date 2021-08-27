class ModelTransaksi {
  bool status;
  String message;
  int count;
  List<Data> data;

  ModelTransaksi({this.status, this.message, this.count, this.data});

  ModelTransaksi.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    count = json['count'];
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
    data['message'] = this.message;
    data['count'] = this.count;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String idTransaction;
  String transactionCode;
  String transactionType;
  String idMember;
  String paymentGateway;
  String paymentMethod;
  String paymentChannel;
  String paymentStatus;
  String paymentDate;
  String idCountry;
  String idAddress;
  String idCity;
  String idDriver;
  String statusDriver;
  String note;
  String deliveryPrice;
  String couponCode;
  String paymentProof;
  String deliveryMethod;
  String totalNominal;
  String grandTotal;
  String grandTotalUnique;
  String status;
  String emergency;
  String jadwal;
  String statusPrint;
  String idSuratJalan;
  String totalUangDiterima;
  String createdDate;
  String updatedDate;
  List<Products> products;

  Data(
      {this.idTransaction,
      this.transactionCode,
      this.transactionType,
      this.idMember,
      this.paymentGateway,
      this.paymentMethod,
      this.paymentChannel,
      this.paymentStatus,
      this.paymentDate,
      this.idCountry,
      this.idAddress,
      this.idCity,
      this.idDriver,
      this.statusDriver,
      this.note,
      this.deliveryPrice,
      this.couponCode,
      this.paymentProof,
      this.deliveryMethod,
      this.totalNominal,
      this.grandTotal,
      this.grandTotalUnique,
      this.status,
      this.emergency,
      this.jadwal,
      this.statusPrint,
      this.idSuratJalan,
      this.totalUangDiterima,
      this.createdDate,
      this.updatedDate,
      this.products});

  Data.fromJson(Map<String, dynamic> json) {
    idTransaction = json['id_transaction'] ?? '';
    transactionCode = json['transaction_code'] ?? '';
    transactionType = json['transaction_type'] ?? '';
    idMember = json['id_member'] ?? '';
    paymentGateway = json['payment_gateway'] ?? '';
    paymentMethod = json['payment_method'] ?? '';
    paymentChannel = json['payment_channel'] ?? '';
    paymentStatus = json['payment_status'] ?? '';
    paymentDate = json['payment_date'] ?? '';
    idCountry = json['id_country'] ?? '';
    idAddress = json['id_address'] ?? '';
    idCity = json['id_city'] ?? '';
    idDriver = json['id_driver'] ?? '';
    statusDriver = json['status_driver'] ?? '';
    note = json['note'] ?? '';
    deliveryPrice = json['delivery_price'] ?? '';
    couponCode = json['coupon_code'] ?? '';
    paymentProof = json['payment_proof'] ?? '';
    deliveryMethod = json['delivery_method'] ?? '';
    totalNominal = json['total_nominal'] ?? '';
    grandTotal = json['grand_total'] ?? '';
    grandTotalUnique = json['grand_total_unique'] ?? '';
    status = json['status'] ?? '';
    emergency = json['emergency'] ?? '';
    jadwal = json['jadwal'] ?? '';
    statusPrint = json['status_print'] ?? '';
    idSuratJalan = json['id_surat_jalan'] ?? '';
    totalUangDiterima = json['total_uang_diterima'] ?? '';
    createdDate = json['created_date'] ?? '';
    updatedDate = json['updated_date'] ?? '';
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_transaction'] = this.idTransaction;
    data['transaction_code'] = this.transactionCode;
    data['transaction_type'] = this.transactionType;
    data['id_member'] = this.idMember;
    data['payment_gateway'] = this.paymentGateway;
    data['payment_method'] = this.paymentMethod;
    data['payment_channel'] = this.paymentChannel;
    data['payment_status'] = this.paymentStatus;
    data['payment_date'] = this.paymentDate;
    data['id_country'] = this.idCountry;
    data['id_address'] = this.idAddress;
    data['id_city'] = this.idCity;
    data['id_driver'] = this.idDriver;
    data['status_driver'] = this.statusDriver;
    data['note'] = this.note;
    data['delivery_price'] = this.deliveryPrice;
    data['coupon_code'] = this.couponCode;
    data['payment_proof'] = this.paymentProof;
    data['delivery_method'] = this.deliveryMethod;
    data['total_nominal'] = this.totalNominal;
    data['grand_total'] = this.grandTotal;
    data['grand_total_unique'] = this.grandTotalUnique;
    data['status'] = this.status;
    data['emergency'] = this.emergency;
    data['jadwal'] = this.jadwal;
    data['status_print'] = this.statusPrint;
    data['id_surat_jalan'] = this.idSuratJalan;
    data['total_uang_diterima'] = this.totalUangDiterima;
    data['created_date'] = this.createdDate;
    data['updated_date'] = this.updatedDate;
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  String idProduct;
  String productName;
  String image;

  Products({this.idProduct, this.productName, this.image});

  Products.fromJson(Map<String, dynamic> json) {
    idProduct = json['id_product'];
    productName = json['product_name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_product'] = this.idProduct;
    data['product_name'] = this.productName;
    data['image'] = this.image;
    return data;
  }
}
