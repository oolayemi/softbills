
class ElectricityData {
  bool? success;
  String? status;
  String? message;
  List<ElectricityBillers>? data;

  ElectricityData({this.success, this.status, this.message, this.data});

  ElectricityData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ElectricityBillers>[];
      json['data'].forEach((v) {
        data!.add(ElectricityBillers.fromJson(v));
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

class ElectricityBillers {
  String? serviceID;
  String? name;
  String? minimiumAmount;
  String? maximumAmount;
  String? convinienceFee;
  String? productType;
  String? image;

  ElectricityBillers(
      {this.serviceID,
        this.name,
        this.minimiumAmount,
        this.maximumAmount,
        this.convinienceFee,
        this.productType,
        this.image});

  ElectricityBillers.fromJson(Map<String, dynamic> json) {
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