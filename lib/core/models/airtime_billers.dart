class AirtimeBillersData {
  bool? success;
  String? status;
  String? message;
  List<AirtimeBillers>? data;

  AirtimeBillersData({this.success, this.status, this.message, this.data});

  AirtimeBillersData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <AirtimeBillers>[];
      json['data'].forEach((v) {
        data!.add(AirtimeBillers.fromJson(v));
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

class AirtimeBillers {
  String? serviceID;
  String? name;
  String? minimiumAmount;
  String? maximumAmount;
  String? convinienceFee;
  String? productType;
  String? image;
  List<AirtimePlans>? plans;

  AirtimeBillers(
      {this.serviceID,
        this.name,
        this.minimiumAmount,
        this.maximumAmount,
        this.convinienceFee,
        this.productType,
        this.image,
        this.plans});

  AirtimeBillers.fromJson(Map<String, dynamic> json) {
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

class AirtimePlans {
  int? id;
  String? type;
  String? code;
  String? description;
  String? amount;
  String? price;
  String? value;
  String? duration;

  AirtimePlans(
      {this.id,
        this.type,
        this.code,
        this.description,
        this.amount,
        this.price,
        this.value,
        this.duration});

  AirtimePlans.fromJson(Map<String, dynamic> json) {
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