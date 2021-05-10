class TopicListResponse {
  bool success;
  int statusCode;
  List<TopicModel> data;

  TopicListResponse({this.success, this.statusCode, this.data});

  TopicListResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    if (json['data'] != null) {
      // ignore: deprecated_member_use
      data = new List<TopicModel>();
      json['data'].forEach((v) {
        data.add(new TopicModel.fromJson(v));
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

class TopicModel {
  String sId;
  String name;
  bool isSelected;

  TopicModel({this.sId, this.name,this.isSelected});

  TopicModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    isSelected = json['isSelected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['isSelected'] = this.isSelected;
    return data;
  }
}
