class WalletResponse {
  bool? success;
  String? status;
  String? message;
  WalletData? data;

  WalletResponse({this.success, this.status, this.message, this.data});

  WalletResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? WalletData.fromJson(json['data']) : null;
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

class WalletData {
  String? id;
  String? userId;
  String? number;
  String? currency;
  String? balance;
  String? createdAt;
  String? updatedAt;
  VirtualAccount? virtualAccount;

  WalletData(
      {this.id,
        this.userId,
        this.number,
        this.currency,
        this.balance,
        this.createdAt,
        this.updatedAt,
        this.virtualAccount});

  WalletData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    number = json['number'];
    currency = json['currency'];
    balance = json['balance'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    virtualAccount = json['virtual_account'] != null
        ? VirtualAccount.fromJson(json['virtual_account'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['number'] = number;
    data['currency'] = currency;
    data['balance'] = balance;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (virtualAccount != null) {
      data['virtual_account'] = virtualAccount!.toJson();
    }
    return data;
  }
}

class VirtualAccount {
  String? id;
  String? userId;
  String? walletId;
  String? accountReference;
  String? accountName;
  String? accountNumber;
  String? bankName;
  String? createdAt;
  String? updatedAt;

  VirtualAccount(
      {this.id,
        this.userId,
        this.walletId,
        this.accountReference,
        this.accountName,
        this.accountNumber,
        this.bankName,
        this.createdAt,
        this.updatedAt});

  VirtualAccount.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    walletId = json['wallet_id'];
    accountReference = json['account_reference'];
    accountName = json['account_name'];
    accountNumber = json['account_number'];
    bankName = json['bank_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['wallet_id'] = walletId;
    data['account_reference'] = accountReference;
    data['account_name'] = accountName;
    data['account_number'] = accountNumber;
    data['bank_name'] = bankName;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
