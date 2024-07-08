class BankListResponse {
  bool? success;
  String? status;
  String? message;
  List<Bank>? data;

  BankListResponse({this.success, this.status, this.message, this.data});

  BankListResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Bank>[];
      json['data'].forEach((v) {
        data!.add(Bank.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Bank {
  String? name;
  String? code;
  String? nipBankCode;

  Bank(
      {this.name,
        this.code,
        this.nipBankCode});

  Bank.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    code = json['code'];
    nipBankCode = json['nipBankCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['code'] = code;
    data['nipBankCode'] = nipBankCode;
    return data;
  }
}