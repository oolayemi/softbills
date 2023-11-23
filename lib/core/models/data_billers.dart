
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
  String? serviceID;
  String? name;
  String? minimiumAmount;
  String? maximumAmount;
  String? convinienceFee;
  String? productType;
  String? image;
  List<Plans>? plans;

  DataBillers(
      {this.serviceID,
        this.name,
        this.minimiumAmount,
        this.maximumAmount,
        this.convinienceFee,
        this.productType,
        this.image,
        this.plans
      });

  DataBillers.fromJson(Map<String, dynamic> json) {
    serviceID = json['serviceID'];
    name = json['name'];
    minimiumAmount = json['minimium_amount'];
    maximumAmount = json['maximum_amount'];
    convinienceFee = json['convinience_fee'];
    productType = json['product_type'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['serviceID'] = serviceID;
    data['name'] = name;
    data['minimium_amount'] = minimiumAmount;
    data['maximum_amount'] = maximumAmount;
    data['convinience_fee'] = convinienceFee;
    data['product_type'] = productType;
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