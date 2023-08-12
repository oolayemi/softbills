class WalletResponse {
  String? status;
  String? message;
  List<Wallet>? data;

  WalletResponse({this.status, this.message, this.data});

  WalletResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Wallet>[];
      json['data'].forEach((v) {
        data!.add(Wallet.fromJson(v));
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

class Wallet {
  int? id;
  String? uuid;
  int? userId;
  String? number;
  String? balance;
  String? walletType;
  String? requestId;
  String? context;
  String? createdTimestamp;
  String? label;
  String? createdAt;
  String? updatedAt;
  VirtualAccount? virtualAccount;

  Wallet(
      {this.id,
        this.uuid,
        this.userId,
        this.number,
        this.balance,
        this.walletType,
        this.requestId,
        this.context,
        this.createdTimestamp,
        this.label,
        this.createdAt,
        this.updatedAt,
        this.virtualAccount});

  Wallet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    userId = json['user_id'];
    number = json['number'];
    balance = json['balance'].toString();
    walletType = json['type'];
    requestId = json['request_id'];
    context = json['context'];
    createdTimestamp = json['created_timestamp'];
    label = json['label'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    virtualAccount = json['virtual_account'] != null
        ? VirtualAccount.fromJson(json['virtual_account'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['uuid'] = uuid;
    data['user_id'] = userId;
    data['number'] = number;
    data['balance'] = balance;
    data['wallet_type'] = walletType;
    data['request_id'] = requestId;
    data['context'] = context;
    data['created_timestamp'] = createdTimestamp;
    data['label'] = label;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (virtualAccount != null) {
      data['virtual_account'] = virtualAccount!.toJson();
    }
    return data;
  }
}

class VirtualAccount {
  int? id;
  int? userId;
  int? walletId;
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
