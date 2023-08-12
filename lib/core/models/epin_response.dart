class EPinResponse {
  String? status;
  String? message;
  List<EPinData>? billers;

  EPinResponse({this.status, this.message, this.billers});

  EPinResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      billers = <EPinData>[];
      json['data'].forEach((v) {
        billers!.add(new EPinData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.billers != null) {
      data['data'] = this.billers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EPinData {
  int? amount;
  String? pin;
  String? serialNumber;
  String? instruction;

  EPinData({this.amount, this.pin, this.serialNumber, this.instruction});

  EPinData.fromJson(Map<String, dynamic> json) {
    amount = json['Amount'];
    pin = json['pin'];
    serialNumber = json['serial_number'];
    instruction = json['instruction'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Amount'] = this.amount;
    data['pin'] = this.pin;
    data['serial_number'] = this.serialNumber;
    data['instruction'] = this.instruction;
    return data;
  }
}