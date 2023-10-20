class CableTvData {
  bool? success;
  String? status;
  String? message;
  List<CableBillers>? data;

  CableTvData({this.success, this.status, this.message, this.data});

  CableTvData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <CableBillers>[];
      json['data'].forEach((v) {
        data!.add(CableBillers.fromJson(v));
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

class CableBillers {
  String? serviceID;
  String? name;
  String? minimiumAmount;
  String? maximumAmount;
  String? convinienceFee;
  String? productType;
  String? image;

  CableBillers(
      {this.serviceID,
        this.name,
        this.minimiumAmount,
        this.maximumAmount,
        this.convinienceFee,
        this.productType,
        this.image});

  CableBillers.fromJson(Map<String, dynamic> json) {
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

class PlansData {
  bool? success;
  String? status;
  String? message;
  List<CableTvPackage>? data;

  PlansData({this.success, this.status, this.message, this.data});

  PlansData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <CableTvPackage>[];
      json['data'].forEach((v) {
        data!.add(CableTvPackage.fromJson(v));
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

class CableTvPackage {
  String? variationCode;
  String? name;
  String? variationAmount;
  String? fixedPrice;

  CableTvPackage({this.variationCode, this.name, this.variationAmount, this.fixedPrice});

  CableTvPackage.fromJson(Map<String, dynamic> json) {
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

