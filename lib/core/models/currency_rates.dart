class RatesResponse {
  String? status;
  String? message;
  List<Rates>? rates;

  RatesResponse({this.status, this.message, this.rates});

  RatesResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['rates'] != null) {
      rates = <Rates>[];
      json['rates'].forEach((v) {
        rates!.add(Rates.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (rates != null) {
      data['rates'] = rates!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Rates {
  int? id;
  String? currencyFrom;
  String? currencyTo;
  double? rate;
  String? createdAt;
  String? updatedAt;

  Rates(
      {this.id,
        this.currencyFrom,
        this.currencyTo,
        this.rate,
        this.createdAt,
        this.updatedAt});

  Rates.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    currencyFrom = json['currency_from'];
    currencyTo = json['currency_to'];
    rate = double.parse(json['rate'].toString());
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['currency_from'] = currencyFrom;
    data['currency_to'] = currencyTo;
    data['rate'] = rate;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
