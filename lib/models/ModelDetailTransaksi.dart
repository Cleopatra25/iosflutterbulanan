class ModelDetailTransaksi {
  bool status;
  String message;
  int count;
  Data data;

  ModelDetailTransaksi({this.status, this.message, this.count, this.data});

  ModelDetailTransaksi.fromJson(Map<String, dynamic> json) {
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
  Transaction transaction;
  List<Product> product;

  Data({this.transaction, this.product});

  Data.fromJson(Map<String, dynamic> json) {
    transaction = json['transaction'] != null
        ? new Transaction.fromJson(json['transaction'])
        : null;
    if (json['product'] != null) {
      product = <Product>[];
      json['product'].forEach((v) {
        product.add(new Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.transaction != null) {
      data['transaction'] = this.transaction.toJson();
    }
    if (this.product != null) {
      data['product'] = this.product.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Transaction {
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
  Address address;

  Transaction(
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
      this.address});

  Transaction.fromJson(Map<String, dynamic> json) {
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
    note = json['note'] ?? 'Tidak Ada Catatan';
    deliveryPrice = json['delivery_price'] ?? '';
    couponCode = json['coupon_code'] ?? '-';
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
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
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
    if (this.address != null) {
      data['address'] = this.address.toJson();
    }
    return data;
  }
}

class Address {
  String idAddress;
  String idMember;
  String idProvince;
  String idCity;
  String address;
  String map;
  String latitude;
  String longitude;
  String postalCode;
  String phone;
  String nameAcc;
  String createdDate;
  String updatedDate;
  String createdBy;
  String updatedBy;

  Address(
      {this.idAddress,
      this.idMember,
      this.idProvince,
      this.idCity,
      this.address,
      this.map,
      this.latitude,
      this.longitude,
      this.postalCode,
      this.phone,
      this.nameAcc,
      this.createdDate,
      this.updatedDate,
      this.createdBy,
      this.updatedBy});

  Address.fromJson(Map<String, dynamic> json) {
    idAddress = json['id_address'] ?? '';
    idMember = json['id_member'] ?? '';
    idProvince = json['id_province'] ?? '';
    idCity = json['id_city'] ?? '';
    address = json['address'] ?? '';
    map = json['map'] ?? '';
    latitude = json['latitude'] ?? '';
    longitude = json['longitude'] ?? '';
    postalCode = json['postal_code'] ?? '';
    phone = json['phone'] ?? '';
    nameAcc = json['name_acc'] ?? '';
    createdDate = json['created_date'] ?? '';
    updatedDate = json['updated_date'] ?? '';
    createdBy = json['created_by'] ?? '';
    updatedBy = json['updated_by'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_address'] = this.idAddress;
    data['id_member'] = this.idMember;
    data['id_province'] = this.idProvince;
    data['id_city'] = this.idCity;
    data['address'] = this.address;
    data['map'] = this.map;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['postal_code'] = this.postalCode;
    data['phone'] = this.phone;
    data['name_acc'] = this.nameAcc;
    data['created_date'] = this.createdDate;
    data['updated_date'] = this.updatedDate;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    return data;
  }
}

class Product {
  String idTransactionDetail;
  String transactionCode;
  String idProduct;
  String productPrice;
  String quantity;
  String totalPrice;
  String pengembalian;
  String createdDate;
  String updatedDate;
  String createdBy;
  String updatedBy;
  String productName;
  String image;
  String emergency;

  Product(
      {this.idTransactionDetail,
      this.transactionCode,
      this.idProduct,
      this.productPrice,
      this.quantity,
      this.totalPrice,
      this.pengembalian,
      this.createdDate,
      this.updatedDate,
      this.createdBy,
      this.updatedBy,
      this.productName,
      this.image,
      this.emergency});

  Product.fromJson(Map<String, dynamic> json) {
    idTransactionDetail = json['id_transaction_detail'] ?? '';
    transactionCode = json['transaction_code'] ?? '';
    idProduct = json['id_product'] ?? '';
    productPrice = json['product_price'] ?? '';
    quantity = json['quantity'] ?? '';
    totalPrice = json['total_price'] ?? '';
    pengembalian = json['pengembalian'] ?? '';
    createdDate = json['created_date'] ?? '';
    updatedDate = json['updated_date'] ?? '';
    createdBy = json['created_by'] ?? '';
    updatedBy = json['updated_by'] ?? '';
    productName = json['product_name'] ?? '';
    image = json['image'] ?? '';
    emergency = json['emergency'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_transaction_detail'] = this.idTransactionDetail;
    data['transaction_code'] = this.transactionCode;
    data['id_product'] = this.idProduct;
    data['product_price'] = this.productPrice;
    data['quantity'] = this.quantity;
    data['total_price'] = this.totalPrice;
    data['pengembalian'] = this.pengembalian;
    data['created_date'] = this.createdDate;
    data['updated_date'] = this.updatedDate;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['product_name'] = this.productName;
    data['image'] = this.image;
    data['emergency'] = this.emergency;
    return data;
  }
}
