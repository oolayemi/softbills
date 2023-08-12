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
        billers!.add(new JambBillers.fromJson(v));
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

class JambBillers {
  String? type;
  int? price;

  JambBillers({this.type, this.price});

  JambBillers.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['price'] = this.price;
    return data;
  }
}