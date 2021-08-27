class ModelCheckout {
  bool status;
  String message;
  int invoice;

  ModelCheckout({this.status, this.message, this.invoice});

  ModelCheckout.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    invoice = json['invoice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['invoice'] = this.invoice;
    return data;
  }
}
