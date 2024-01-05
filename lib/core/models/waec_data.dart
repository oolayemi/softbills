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
        billers!.add(WaecBillers.fromJson(v));
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

class WaecBillers {
  int? price;
  int? availableCount;

  WaecBillers({this.price, this.availableCount});

  WaecBillers.fromJson(Map<String, dynamic> json) {
    price = json['price'];
    availableCount = json['available_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['price'] = price;
    data['available_count'] = availableCount;
    return data;
  }
}