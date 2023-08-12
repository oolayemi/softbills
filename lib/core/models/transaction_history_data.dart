class TransactionHistoryResponse {
  String? status;
  String? message;
  TransactionHistoryData? transactionHistoryData;

  TransactionHistoryResponse({this.status, this.message, this.transactionHistoryData});

  TransactionHistoryResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    transactionHistoryData = json['result'] != null ? TransactionHistoryData.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (transactionHistoryData != null) {
      data['result'] = transactionHistoryData!.toJson();
    }
    return data;
  }
}

class TransactionHistoryData {
  int? currentPage;
  List<DataResponse>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  TransactionHistoryData(
      {this.currentPage,
      this.data,
      this.firstPageUrl,
      this.from,
      this.lastPage,
      this.lastPageUrl,
      this.links,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to,
      this.total});

  TransactionHistoryData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <DataResponse>[];
      json['data'].forEach((v) {
        data!.add(DataResponse.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = firstPageUrl;
    data['from'] = from;
    data['last_page'] = lastPage;
    data['last_page_url'] = lastPageUrl;
    if (links != null) {
      data['links'] = links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = nextPageUrl;
    data['path'] = path;
    data['per_page'] = perPage;
    data['prev_page_url'] = prevPageUrl;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}

class DataResponse {
  int? id;
  int? btcWalletId;
  int? nairaWalletId;
  int? userId;
  String? reference;
  String? amount;
  String? charges;
  String? walletSource;
  String? prevBalance;
  String? newBalance;
  String? status;
  String? type;
  String? transactionType;
  String? narration;
  String? createdAt;

  DataResponse({
    this.id,
    this.btcWalletId,
    this.nairaWalletId,
    this.userId,
    this.reference,
    this.amount,
    this.charges,
    this.walletSource,
    this.prevBalance,
    this.newBalance,
    this.status,
    this.type,
    this.transactionType,
    this.narration,
    this.createdAt,
  });

  DataResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    btcWalletId = json['btc_wallet_id'];
    nairaWalletId = json['naira_wallet_id'];
    userId = json['user_id'];
    reference = json['reference'];
    amount = json['amount'];
    charges = json['charges'].toString();
    walletSource = json['wallet_source'];
    prevBalance = json['prev_balance'];
    newBalance = json['new_balance'];
    status = json['status'];
    type = json['type'];
    transactionType = json['transaction_type'];
    narration = json['narration'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['btc_wallet_id'] = btcWalletId;
    data['naira_wallet_id'] = nairaWalletId;
    data['user_id'] = userId;
    data['reference'] = reference;
    data['amount'] = amount;
    data['charges'] = charges;
    data['wallet_source'] = walletSource;
    data['prev_balance'] = prevBalance;
    data['new_balance'] = newBalance;
    data['status'] = status;
    data['type'] = type;
    data['transaction_type'] = transactionType;
    data['narration'] = narration;
    data['created_at'] = createdAt;
    return data;
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['label'] = label;
    data['active'] = active;
    return data;
  }
}
