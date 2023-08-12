
import 'package:flutter/services.dart';

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
  String? status;
  String? message;
  List<Plans>? plans;

  PlanResponse({this.status, this.message, this.plans});

  PlanResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['plans'] != null) {
      plans = <Plans>[];
      json['plans'].forEach((v) {
        plans!.add(new Plans.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (plans != null) {
      data['plans'] = plans!.map((v) => v.toJson()).toList();
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

  Plans(
      {this.id,
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

