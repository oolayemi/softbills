class ProfileResponse {
  String? status;
  String? message;
  ProfileData? data;

  ProfileResponse({this.status, this.message, this.data});

  ProfileResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? ProfileData.fromJson(json['data']) : null;
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

class ProfileData {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? gender;
  String? phone;
  int? tier;
  String? imageUrl;
  String? transactionPin;
  String? dob;
  String? address;
  String? state;

  ProfileData({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.tier,
    this.imageUrl,
    this.transactionPin,
    this.dob,
    this.address,
    this.state,
    this.gender,
  });

  ProfileData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstname'];
    lastName = json['lastname'];
    email = json['email'];
    phone = json['phone'];
    tier = json['tier'];
    imageUrl = json['image_url'];
    transactionPin = json['transaction_pin'];
    dob = json['dob'];
    address = json['address'];
    state = json['state'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['firstname'] = firstName;
    data['lastname'] = lastName;
    data['email'] = email;
    data['phone'] = phone;
    data['tier'] = tier;
    data['image_url'] = imageUrl;
    data['transaction_pin'] = transactionPin;
    data['dob'] = dob;
    data['address'] = address;
    data['state'] = state;
    data['gender'] = gender;
    return data;
  }
}
