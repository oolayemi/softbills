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
  String? bankName;
  String? cbnCode;

  Bank({this.bankName, this.cbnCode});

  Bank.fromJson(Map<String, dynamic> json) {
    bankName = json['bank_name'];
    cbnCode = json['cbn_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bank_name'] = bankName;
    data['cbn_code'] = cbnCode;
    return data;
  }
}