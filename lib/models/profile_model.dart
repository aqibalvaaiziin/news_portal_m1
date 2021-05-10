class GetProfileResponse {
  bool success;
  int statusCode;
  ProfileModel data;

  GetProfileResponse({this.success, this.statusCode, this.data});

  GetProfileResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    data =
        json['data'] != null ? new ProfileModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['statusCode'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class ProfileModel {
  String sId;
  String name;
  String email;
  String googleId;
  String foto;
  List<String> topic;

  ProfileModel(
      {this.sId, this.name, this.email, this.googleId, this.foto, this.topic});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    googleId = json['googleId'];
    foto = json['foto'];
    topic = json['topic'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['googleId'] = this.googleId;
    data['foto'] = this.foto;
    data['topic'] = this.topic;
    return data;
  }
}
