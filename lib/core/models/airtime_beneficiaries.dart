class AirtimeBeneficiaryResponse {
  String? status;
  String? message;
  List<AirtimeBeneficiary>? data;

  AirtimeBeneficiaryResponse({this.status, this.message, this.data});

  AirtimeBeneficiaryResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <AirtimeBeneficiary>[];
      json['data'].forEach((v) {
        data!.add(AirtimeBeneficiary.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AirtimeBeneficiary {
  int? id;
  String? nickname;
  String? operator;
  String? phoneNumber;

  AirtimeBeneficiary({this.id, this.nickname, this.operator, this.phoneNumber});

  AirtimeBeneficiary.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nickname = json['nickname'];
    operator = json['operator'];
    phoneNumber = json['phone_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nickname'] = nickname;
    data['operator'] = operator;
    data['phone_number'] = phoneNumber;
    return data;
  }
}
