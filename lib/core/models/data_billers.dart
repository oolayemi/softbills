
import 'airtime_data_model.dart';

class DataBillersData {
  String? status;
  String? message;
  List<DataBillers>? billers;

  DataBillersData({this.status, this.message, this.billers});

  DataBillersData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['billers'] != null) {
      billers = <DataBillers>[];
      json['billers'].forEach((v) {
        billers!.add(DataBillers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (billers != null) {
      data['billers'] = billers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataBillers {
  int? id;
  String? name;
  String? type;
  String? narration;
  String? image;
  List<Plans>? plans;

  DataBillers({this.id, this.name, this.type, this.narration, this.image, this.plans});

  DataBillers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    narration = json['narration'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['type'] = type;
    data['narration'] = narration;
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