
class CableTvData {
  String? status;
  List<CableBillers>? billers;

  CableTvData({this.status, this.billers});

  CableTvData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['billers'] != null) {
      billers = <CableBillers>[];
      json['billers'].forEach((v) {
        billers!.add(CableBillers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (billers != null) {
      data['billers'] = billers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CableBillers {
  int? id;
  String? name;
  String? type;
  String? image;

  CableBillers({this.id, this.name, this.type, this.image});

  CableBillers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['type'] = type;
    data['image'] = image;
    return data;
  }
}

class PlansData {
  String? status;
  List<CableTvPackage>? billers;

  PlansData({this.status, this.billers});

  PlansData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['billers'] != null) {
      billers = <CableTvPackage>[];
      json['billers'].forEach((v) {
        billers!.add(CableTvPackage.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (billers != null) {
      data['billers'] = billers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CableTvPackage {
  String? name;
  String? type;
  String? code;
  String? price;
  String? amount;

  CableTvPackage({this.name, this.type, this.code, this.price, this.amount});

  CableTvPackage.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    type = json['type'];
    code = json['code'];
    price = json['price'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['type'] = type;
    data['code'] = code;
    data['price'] = price;
    data['amount'] = amount;
    return data;
  }
}

