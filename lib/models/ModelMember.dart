class ModelMember {
  bool status;
  Data data;

  ModelMember({this.status, this.data});

  ModelMember.fromJson(Map<String, dynamic> json) {
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
  String idMember;
  String profilePic;
  String fullName;
  String phone;
  String email;
  String gender;
  String birthDate;
  String verifiedPhone;
  String verifiedEmail;
  String badge;
  String createdDate;

  Data(
      {this.idMember,
      this.profilePic,
      this.fullName,
      this.phone,
      this.email,
      this.gender,
      this.birthDate,
      this.verifiedPhone,
      this.verifiedEmail,
      this.badge,
      this.createdDate});

  Data.fromJson(Map<String, dynamic> json) {
    idMember = json['id_member'] ?? '';
    profilePic = json['profile_pic'] ?? '';
    fullName = json['full_name'] ?? '';
    phone = json['phone'] ?? '';
    email = json['email'] ?? '';
    gender = json['gender'] ?? '';
    birthDate = json['birth_date'] ?? '';
    verifiedPhone = json['verified_phone'] ?? '';
    verifiedEmail = json['verified_email'] ?? '';
    badge = json['badge'] ?? '';
    createdDate = json['created_date'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_member'] = this.idMember;
    data['profile_pic'] = this.profilePic;
    data['full_name'] = this.fullName;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['birth_date'] = this.birthDate;
    data['verified_phone'] = this.verifiedPhone;
    data['verified_email'] = this.verifiedEmail;
    data['badge'] = this.badge;
    data['created_date'] = this.createdDate;
    return data;
  }
}
