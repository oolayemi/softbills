

class AirTimeDataModel {
  String? name;
  String? path;
  List<Plans>? plans;

  AirTimeDataModel({this.name, this.path, this.plans});

  static List<AirTimeDataModel> data = [
    AirTimeDataModel(name: 'MTN', path: 'assets/images/billers/mtn.webp'),
    AirTimeDataModel(name: 'GLO', path: 'assets/images/billers/glo.webp'),
    AirTimeDataModel(name: '9MOBILE', path: 'assets/images/billers/9mobile.webp'),
    AirTimeDataModel(name: 'AIRTEL', path: 'assets/images/billers/airtel.webp'),
  ];
}

class PlanResponse {
  bool? success;
  String? status;
  String? message;
  List<Plans>? data;

  PlanResponse({this.success, this.status, this.message, this.data});

  PlanResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Plans>[];
      json['data'].forEach((v) {
        data!.add(Plans.fromJson(v));
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

class Plans {
  int? id;
  String? type;
  String? code;
  String? description;
  String? amount;
  String? price;
  String? value;
  String? duration;

  Plans({this.id,
    this.type,
    this.code,
    this.description,
    this.amount,
    this.price,
    this.value,
    this.duration});

  Plans.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    code = json['code'];
    description = json['description'];
    amount =  json['amount'];
    price = json['price'];
    value = json['value'];
    duration = json['duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['code'] = code;
    data['description'] = description;
    data['amount'] = amount;
    data['price'] = price;
    data['value'] = value;
    data['duration'] = duration;
    return data;
  }
}


