class ScheduleAirtimeResponse {
  String? status;
  String? message;
  ScheduleAirtime? result;

  ScheduleAirtimeResponse({this.status, this.message, this.result});

  ScheduleAirtimeResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    result = json['data'] != null ? ScheduleAirtime.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (result != null) {
      data['data'] = result!.toJson();
    }
    return data;
  }
}

class ScheduleAirtime {
  int? currentPage;
  List<AirtimeList>? data;
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

  ScheduleAirtime(
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

  ScheduleAirtime.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <AirtimeList>[];
      json['data'].forEach((v) {
        data!.add(AirtimeList.fromJson(v));
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

class AirtimeList {
  int? id;
  int? userId;
  String? amount;
  String? serviceNumber;
  String? serviceProvider;
  String? frequency;
  int? frequencyValue;
  bool? isProcessed;
  bool? isEnabled;
  String? createdAt;
  String? updatedAt;

  AirtimeList(
      {this.id,
        this.userId,
        this.amount,
        this.serviceNumber,
        this.serviceProvider,
        this.frequency,
        this.frequencyValue,
        this.isProcessed,
        this.isEnabled,
        this.createdAt,
        this.updatedAt});

  AirtimeList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    amount = json['amount'];
    serviceNumber = json['service_number'];
    serviceProvider = json['service_provider'];
    frequency = json['frequency'];
    frequencyValue = json['frequency_value'];
    isProcessed = json['is_processed'];
    isEnabled = json['is_enabled'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['amount'] = amount;
    data['service_number'] = serviceNumber;
    data['service_provider'] = serviceProvider;
    data['frequency'] = frequency;
    data['frequency_value'] = frequencyValue;
    data['is_processed'] = isProcessed;
    data['is_enabled'] = isEnabled;
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