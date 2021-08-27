class ModelPostRegister {
  bool status;
  String message;
  Data data;

  ModelPostRegister({this.status, this.message, this.data});

  ModelPostRegister.fromJson(Map<String, dynamic> json) {
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
  int idMember;
  String fullName;
  String profilePic;
  String email;
  String phone;
  String badge;
  String token;

  Data(
      {this.idMember,
      this.fullName,
      this.profilePic,
      this.email,
      this.phone,
      this.badge,
      this.token});

  Data.fromJson(Map<String, dynamic> json) {
    idMember = json['id_member'];
    fullName = json['full_name'];
    profilePic = json['profile_pic'];
    email = json['email'];
    phone = json['phone'];
    badge = json['badge'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_member'] = this.idMember;
    data['full_name'] = this.fullName;
    data['profile_pic'] = this.profilePic;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['badge'] = this.badge;
    data['token'] = this.token;
    return data;
  }
}
