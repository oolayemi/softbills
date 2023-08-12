class DataBeneficiaryResponse {
  String? status;
  String? message;
  List<DataBeneficiary>? data;

  DataBeneficiaryResponse({this.status, this.message, this.data});

  DataBeneficiaryResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <DataBeneficiary>[];
      json['data'].forEach((v) {
        data!.add(DataBeneficiary.fromJson(v));
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

class DataBeneficiary {
  int? id;
  String? nickname;
  String? operator;
  String? phoneNumber;

  DataBeneficiary({this.id, this.nickname, this.operator, this.phoneNumber});

  DataBeneficiary.fromJson(Map<String, dynamic> json) {
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
