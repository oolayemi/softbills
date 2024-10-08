
class SMEDataModel {
  String? name;
  String? path;
  List<SMEPlans>? plans;

  SMEDataModel({this.name, this.path, this.plans});

  static List<SMEDataModel> data = [
    SMEDataModel(name: 'MTN', path: 'assets/images/billers/mtn.webp'),
    SMEDataModel(name: 'GLO', path: 'assets/images/billers/glo.webp'),
    SMEDataModel(name: 'AIRTEL', path: 'assets/images/billers/airtel.webp'),
    SMEDataModel(name: '9MOBILE', path: 'assets/images/billers/9mobile.webp'),
  ];
}

class PlanResponse {
  bool? success;
  String? status;
  String? message;
  List<SMEPlans>? plans;

  PlanResponse({this.success, this.status, this.message, this.plans});

  PlanResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    status = json['status'];
    message = json['message'];
    if (json['billers'] != null) {
      plans = <SMEPlans>[];
      json['billers'].forEach((v) {
        plans!.add(SMEPlans.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['status'] = status;
    data['message'] = message;
    if (plans != null) {
      data['billers'] = plans!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SMEPlans {
  String? description;
  String? code;

  SMEPlans({this.description, this.code});

  SMEPlans.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description'] = description;
    data['code'] = code;
    return data;
  }
}