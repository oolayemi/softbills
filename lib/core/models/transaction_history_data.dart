class TransactionHistoryResponse {
  bool? success;
  String? status;
  String? message;
  TransactionHistoryData? data;

  TransactionHistoryResponse(
      {this.success, this.status, this.message, this.data});

  TransactionHistoryResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? TransactionHistoryData.fromJson(json['data']) : null;
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
  String? id;
  String? walletId;
  String? userId;
  String? reference;
  String? amount;
  int? charges;
  String? prevBalance;
  String? newBalance;
  String? serviceType;
  String? transactionType;
  String? status;
  String? channel;
  bool? isCommission;
  String? narration;
  String? createdAt;
  String? updatedAt;

  DataResponse(
      {this.id,
        this.walletId,
        this.userId,
        this.reference,
        this.amount,
        this.charges,
        this.prevBalance,
        this.newBalance,
        this.serviceType,
        this.transactionType,
        this.status,
        this.channel,
        this.isCommission,
        this.narration,
        this.createdAt,
        this.updatedAt});

  DataResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    walletId = json['wallet_id'];
    userId = json['user_id'];
    reference = json['reference'];
    amount = json['amount'];
    charges = json['charges'];
    prevBalance = json['prev_balance'];
    newBalance = json['new_balance'];
    serviceType = json['service_type'];
    transactionType = json['transaction_type'];
    status = json['status'];
    channel = json['channel'];
    isCommission = json['is_commission'];
    narration = json['narration'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['wallet_id'] = walletId;
    data['user_id'] = userId;
    data['reference'] = reference;
    data['amount'] = amount;
    data['charges'] = charges;
    data['prev_balance'] = prevBalance;
    data['new_balance'] = newBalance;
    data['service_type'] = serviceType;
    data['transaction_type'] = transactionType;
    data['status'] = status;
    data['channel'] = channel;
    data['is_commission'] = isCommission;
    data['narration'] = narration;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
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
