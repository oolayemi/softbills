
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['narration'] = narration;
    data['short_name'] = shortName;
    data['image'] = image;
    return data;
  }
}