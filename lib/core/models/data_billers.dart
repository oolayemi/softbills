
import 'airtime_data_model.dart';

class DataBillersData {
  bool? success;
  String? status;
  String? message;
  List<DataBillers>? data;

  DataBillersData({this.success, this.status, this.message, this.data});

  DataBillersData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <DataBillers>[];
      json['data'].forEach((v) {
        data!.add(DataBillers.fromJson(v));
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

class DataBillers {
  String? type;
  int? id;
  String? name;
  String? narration;
  String? image;
  List<Plans>? plans;

  DataBillers({this.type, this.id, this.name, this.narration, this.image, this.plans});

  DataBillers.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    id = json['id'];
    name = json['name'];
    narration = json['narration'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['id'] = id;
    data['name'] = name;
    data['narration'] = narration;
    data['image'] = image;
    data['image'] = image;
    return data;
  }
}

class SMEDataBillersData {
  bool? success;
  String? status;
  String? message;
  List<SMEDataBillers>? billers;


  SMEDataBillersData({this.success, this.status, this.message, this.billers});

  SMEDataBillersData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    status = json['status'];
    message = json['message'];
    if (json['billers'] != null) {
      billers = <SMEDataBillers>[];
      json['billers'].forEach((v) {
        billers!.add(SMEDataBillers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['status'] = status;
    data['message'] = message;
    if (billers != null) {
      data['billers'] = billers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SMEDataBillers {
  String? description;
  String? code;
  String? price;

  SMEDataBillers({this.description, this.code});

  SMEDataBillers.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    code = json['code'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description'] = description;
    data['code'] = code;
    data['price'] = price;
    return data;
  }
}