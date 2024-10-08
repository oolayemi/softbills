class Announcement {
  String? status;
  String? message;
  List<AnnouncementData>? announcementData;

  Announcement({this.status, this.message, this.announcementData});

  Announcement.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      announcementData = <AnnouncementData>[];
      json['data'].forEach((v) {
        announcementData!.add(AnnouncementData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['announcementData'] = announcementData;
    return data;
  }
}

class AnnouncementData {
  int? id;
  String? title;
  String? body;
  String? type;
  String? imageUrl;

  AnnouncementData({this.id, this.title, this.body, this.type, this.imageUrl});

  AnnouncementData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
    type = json['type'];
    imageUrl = json['image_url'];
  }
}
