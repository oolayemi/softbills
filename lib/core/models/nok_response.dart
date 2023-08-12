class NokResponse {
  String? status;
  String? message;
  NokData? data;

  NokResponse({this.status, this.message, this.data});

  NokResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? NokData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class NokData {
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? relationship;
  String? address;

  NokData({
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.relationship,
    this.address,
  });

  NokData.fromJson(Map<String, dynamic> json) {
    firstName = json['firstname'];
    lastName = json['lastname'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    relationship = json['relationship'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstname'] = firstName;
    data['lastname'] = lastName;
    data['email'] = email;
    data['phone'] = phone;
    data['address'] = address;
    data['relationship'] = relationship;
    return data;
  }
}
