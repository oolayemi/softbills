class WaecData {
  bool? success;
  String? status;
  String? message;
  List<WaecBillers>? billers;

  WaecData({this.success, this.status, this.message, this.billers});

  WaecData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    status = json['status'];
    message = json['message'];
    if (json['billers'] != null) {
      billers = <WaecBillers>[];
      json['billers'].forEach((v) {
        billers!.add(new WaecBillers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.billers != null) {
      data['billers'] = this.billers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WaecBillers {
  int? price;
  int? availableCount;

  WaecBillers({this.price, this.availableCount});

  WaecBillers.fromJson(Map<String, dynamic> json) {
    price = json['price'];
    availableCount = json['available_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['price'] = this.price;
    data['available_count'] = this.availableCount;
    return data;
  }
}