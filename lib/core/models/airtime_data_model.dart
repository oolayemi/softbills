
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
  String? variationCode;
  String? name;
  String? variationAmount;
  String? fixedPrice;

  Plans({this.variationCode, this.name, this.variationAmount, this.fixedPrice});

  Plans.fromJson(Map<String, dynamic> json) {
    variationCode = json['variation_code'];
    name = json['name'];
    variationAmount = json['variation_amount'];
    fixedPrice = json['fixedPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['variation_code'] = variationCode;
    data['name'] = name;
    data['variation_amount'] = variationAmount;
    data['fixedPrice'] = fixedPrice;
    return data;
  }
}


