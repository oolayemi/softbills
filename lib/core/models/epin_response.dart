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
        billers!.add(EPinData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (billers != null) {
      data['data'] = billers!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Amount'] = amount;
    data['pin'] = pin;
    data['serial_number'] = serialNumber;
    data['instruction'] = instruction;
    return data;
  }
}