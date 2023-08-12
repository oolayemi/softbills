class PlanList {
  String? status;
  List<PlanData>? data;

  PlanList({this.status, this.data});

  PlanList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <PlanData>[];
      json['data'].forEach((v) {
        data!.add(new PlanData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PlanData {
  int? id;
  String? rank;
  String? slug;
  Null description;
  int? fee;

  PlanData({this.id, this.rank, this.slug, this.description, this.fee});

  PlanData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rank = json['rank'];
    slug = json['slug'];
    description = json['description'];
    fee = json['fee'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['rank'] = this.rank;
    data['slug'] = this.slug;
    data['description'] = this.description;
    data['fee'] = this.fee;
    return data;
  }
}