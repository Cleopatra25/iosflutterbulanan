class ModelAlamat {
  bool status;
  List<Data> data;

  ModelAlamat({this.status, this.data});

  ModelAlamat.fromJson(Map<String, dynamic> json) {
    status = json['status'];
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
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
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
  Null updatedDate;
  String createdBy;
  Null updatedBy;
  String namaProvinsi;
  String namaCity;

  Data(
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
      this.updatedBy,
      this.namaProvinsi,
      this.namaCity});

  Data.fromJson(Map<String, dynamic> json) {
    idAddress = json['id_address'];
    idMember = json['id_member'];
    idProvince = json['id_province'];
    idCity = json['id_city'];
    address = json['address'];
    map = json['map'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    postalCode = json['postal_code'];
    phone = json['phone'];
    nameAcc = json['name_acc'];
    createdDate = json['created_date'];
    updatedDate = json['updated_date'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    namaProvinsi = json['nama_provinsi'];
    namaCity = json['nama_city'];
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
    data['nama_provinsi'] = this.namaProvinsi;
    data['nama_city'] = this.namaCity;
    return data;
  }
}
