class ScheduleAirtimeResponse {
  String? status;
  String? message;
  ScheduleAirtime? result;

  ScheduleAirtimeResponse({this.status, this.message, this.result});

  ScheduleAirtimeResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    result = json['data'] != null ? new ScheduleAirtime.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.result != null) {
      data['data'] = this.result!.toJson();
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
  Null nextPageUrl;
  String? path;
  int? perPage;
  Null prevPageUrl;
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
        data!.add(new AirtimeList.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(new Links.fromJson(v));
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    if (this.links != null) {
      data['links'] = this.links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['amount'] = this.amount;
    data['service_number'] = this.serviceNumber;
    data['service_provider'] = this.serviceProvider;
    data['frequency'] = this.frequency;
    data['frequency_value'] = this.frequencyValue;
    data['is_processed'] = this.isProcessed;
    data['is_enabled'] = this.isEnabled;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['label'] = this.label;
    data['active'] = this.active;
    return data;
  }
}