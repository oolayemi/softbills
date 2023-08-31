class ProfileResponse {
  bool? success;
  String? status;
  String? message;
  ProfileData? data;

  ProfileResponse({this.success, this.status, this.message, this.data});

  ProfileResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? ProfileData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class ProfileData {
  String? id;
  String? firstname;
  String? lastname;
  String? email;
  String? gender;
  String? phone;
  String? transactionPin;
  String? imageUrl;
  int? tier;
  String? deviceId;
  String? emailVerifiedAt;
  String? phoneVerifiedAt;
  String? createdAt;
  String? updatedAt;

  ProfileData(
      {this.id,
        this.firstname,
        this.lastname,
        this.email,
        this.gender,
        this.phone,
        this.transactionPin,
        this.imageUrl,
        this.tier,
        this.deviceId,
        this.emailVerifiedAt,
        this.phoneVerifiedAt,
        this.createdAt,
        this.updatedAt});

  ProfileData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    email = json['email'];
    gender = json['gender'];
    phone = json['phone'];
    transactionPin = json['transaction_pin'];
    imageUrl = json['image_url'];
    tier = json['tier'];
    deviceId = json['device_id'];
    emailVerifiedAt = json['email_verified_at'];
    phoneVerifiedAt = json['phone_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['email'] = email;
    data['gender'] = gender;
    data['phone'] = phone;
    data['transaction_pin'] = transactionPin;
    data['image_url'] = imageUrl;
    data['tier'] = tier;
    data['device_id'] = deviceId;
    data['email_verified_at'] = emailVerifiedAt;
    data['phone_verified_at'] = phoneVerifiedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
