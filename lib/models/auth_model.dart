class UserAuthResponse {
  bool success;
  int statusCode;
  AuthResponse data;

  UserAuthResponse({this.success, this.statusCode, this.data});

  UserAuthResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    data =
        json['data'] != null ? new AuthResponse.fromJson(json['data']) : null;
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

class AuthResponse {
  String name;
  String email;
  String foto;
  List<String> topic;
  String token;

  AuthResponse({this.name, this.email, this.foto, this.topic, this.token});

  AuthResponse.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    foto = json['foto'];
    topic = json['topic'].cast<String>();
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['foto'] = this.foto;
    data['topic'] = this.topic;
    data['token'] = this.token;
    return data;
  }
}
