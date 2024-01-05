class JambData {
  bool? success;
  String? status;
  String? message;
  List<JambBillers>? billers;

  JambData({this.success, this.status, this.message, this.billers});

  JambData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    status = json['status'];
    message = json['message'];
    if (json['billers'] != null) {
      billers = <JambBillers>[];
      json['billers'].forEach((v) {
        billers!.add(JambBillers.fromJson(v));
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

class JambBillers {
  String? type;
  int? price;

  JambBillers({this.type, this.price});

  JambBillers.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['price'] = price;
    return data;
  }
}