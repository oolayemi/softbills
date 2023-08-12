class BankData {
  String? status;
  List<Banks>? banks;

  BankData({this.status, this.banks});

  BankData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['banks'] != null) {
      banks = <Banks>[];
      json['banks'].forEach((v) {
        banks!.add(new Banks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.banks != null) {
      data['banks'] = this.banks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Banks {
  String? cbnCode;
  String? bankName;

  Banks({this.cbnCode, this.bankName});

  Banks.fromJson(Map<String, dynamic> json) {
    cbnCode = json['cbn_code'];
    bankName = json['bank_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cbn_code'] = this.cbnCode;
    data['bank_name'] = this.bankName;
    return data;
  }
}
