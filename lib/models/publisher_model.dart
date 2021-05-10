class PublisherResponse {
  bool success;
  int statusCode;
  List<PublisherModel> data;

  PublisherResponse({this.success, this.statusCode, this.data});

  PublisherResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    if (json['data'] != null) {
      // ignore: deprecated_member_use
      data = new List<PublisherModel>();
      json['data'].forEach((v) {
        data.add(new PublisherModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['statusCode'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PublisherModel {
  String sId;
  String name;
  String image;

  PublisherModel({this.sId, this.name, this.image});

  PublisherModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }
}
