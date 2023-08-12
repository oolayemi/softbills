
class ElectricityData {
  String? status;
  String? message;
  List<ElectricityBillers>? billers;

  ElectricityData({this.status, this.message, this.billers});

  ElectricityData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['billers'] != null) {
      billers = <ElectricityBillers>[];
      json['billers'].forEach((v) {
        billers!.add(new ElectricityBillers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.billers != null) {
      data['billers'] = this.billers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ElectricityBillers {
  String? type;
  String? narration;
  String? shortName;
  String? image;

  ElectricityBillers({this.type, this.narration, this.shortName, this.image});

  ElectricityBillers.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    narration = json['narration'];
    shortName = json['short_name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['narration'] = this.narration;
    data['short_name'] = this.shortName;
    data['image'] = this.image;
    return data;
  }
}