class ModelCategoryMain {
  bool status;
  List<Data> data;
  int totalCount;

  ModelCategoryMain({this.status, this.data, this.totalCount});

  ModelCategoryMain.fromJson(Map<String, dynamic> json) {
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
  String idProductCategory;
  String idCategoryParent;
  String idCity;
  String categoryName;
  String slug;
  String description;
  String sequenceNumber;
  String image;
  String icon;
  String discFrom;
  String isPublished;
  String createdDate;
  String updatedDate;
  String createdBy;
  String updatedBy;
  String namaCategory;

  Data(
      {this.idProductCategory,
      this.idCategoryParent,
      this.idCity,
      this.categoryName,
      this.slug,
      this.description,
      this.sequenceNumber,
      this.image,
      this.icon,
      this.discFrom,
      this.isPublished,
      this.createdDate,
      this.updatedDate,
      this.createdBy,
      this.updatedBy,
      this.namaCategory});

  Data.fromJson(Map<String, dynamic> json) {
    idProductCategory = json['id_product_category'];
    idCategoryParent = json['id_category_parent'];
    idCity = json['id_city'];
    categoryName = json['category_name'];
    slug = json['slug'];
    description = json['description'];
    sequenceNumber = json['sequence_number'];
    image = json['image'];
    icon = json['icon'];
    discFrom = json['disc_from'];
    isPublished = json['is_published'];
    createdDate = json['created_date'];
    updatedDate = json['updated_date'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    namaCategory = json['nama_category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_product_category'] = this.idProductCategory;
    data['id_category_parent'] = this.idCategoryParent;
    data['id_city'] = this.idCity;
    data['category_name'] = this.categoryName;
    data['slug'] = this.slug;
    data['description'] = this.description;
    data['sequence_number'] = this.sequenceNumber;
    data['image'] = this.image;
    data['icon'] = this.icon;
    data['disc_from'] = this.discFrom;
    data['is_published'] = this.isPublished;
    data['created_date'] = this.createdDate;
    data['updated_date'] = this.updatedDate;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['nama_category'] = this.namaCategory;
    return data;
  }
}
