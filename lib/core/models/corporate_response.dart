class CorporateBillersData {
  bool? success;
  String? status;
  String? message;
  List<CorporateBillers>? billers;


  CorporateBillersData({this.success, this.status, this.message, this.billers});

  CorporateBillersData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    status = json['status'];
    message = json['message'];
    if (json['billers'] != null) {
      billers = <CorporateBillers>[];
      json['billers'].forEach((v) {
        billers!.add(CorporateBillers.fromJson(v));
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

class CorporateBillers {
  String? description;
  String? code;
  String? price;

  CorporateBillers({this.description, this.code});

  CorporateBillers.fromJson(Map<String, dynamic> json) {
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