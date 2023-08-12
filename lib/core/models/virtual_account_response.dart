class VirtualAccountResponse {
  String? status;
  String? message;
  List<VirtualAccountData>? data;

  VirtualAccountResponse({this.status, this.message, this.data});

  VirtualAccountResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <VirtualAccountData>[];
      json['data'].forEach((v) {
        data!.add(VirtualAccountData.fromJson(v));
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

class VirtualAccountData {
  int? id;
  int? userId;
  String? accountReference;
  String? accountName;
  String? accountNumber;
  String? bankName;
  String? walletType;
  String? createdAt;
  String? updatedAt;

  VirtualAccountData(
      {this.id,
        this.userId,
        this.accountReference,
        this.accountName,
        this.accountNumber,
        this.bankName,
        this.walletType,
        this.createdAt,
        this.updatedAt});

  VirtualAccountData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    accountReference = json['account_reference'];
    accountName = json['account_name'];
    accountNumber = json['account_number'];
    bankName = json['bank_name'];
    walletType = json['wallet_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['account_reference'] = accountReference;
    data['account_name'] = accountName;
    data['account_number'] = accountNumber;
    data['bank_name'] = bankName;
    data['wallet_type'] = walletType;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
