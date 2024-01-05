class BettingData {
  String? status;
  String? message;
  List<String>? data;

  BettingData({this.status, this.message, this.data});

  BettingData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['data'] = this.data;
    return data;
  }
}

class BettingListData {
  List<String>? data;
  String? bet;

  BettingListData(this.bet);

  BettingListData.fromJson(Map<String, dynamic> json) {
    bet = json['id'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[''] = bet;

    return data;
  }

}