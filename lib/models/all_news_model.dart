class AllNewsList {
  bool success;
  int statusCode;
  List<AllNews> data;

  AllNewsList({this.success, this.statusCode, this.data});

  AllNewsList.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    if (json['data'] != null) {
      // ignore: deprecated_member_use
      data = new List<AllNews>();
      json['data'].forEach((v) {
        data.add(new AllNews.fromJson(v));
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

class AllNews {
  String sId;
  String link;
  String title;
  String image;
  String topic;
  String publisher;
  String date;
  bool isBookmark;

  AllNews(
      {this.sId,
      this.link,
      this.title,
      this.image,
      this.topic,
      this.publisher,
      this.isBookmark,
      this.date});

  AllNews.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    link = json['link'];
    title = json['title'];
    image = json['image'];
    topic = json['topic'];
    publisher = json['publisher'];
    date = json['date'];
    isBookmark = json['isBookmark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['link'] = this.link;
    data['title'] = this.title;
    data['image'] = this.image;
    data['topic'] = this.topic;
    data['publisher'] = this.publisher;
    data['date'] = this.date;
    data['isBookmark'] = this.isBookmark;
    return data;
  }
}

class DetailNewsResponse {
  bool success;
  int statusCode;
  DetailNews data;

  DetailNewsResponse({this.success, this.statusCode, this.data});

  DetailNewsResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    data = json['data'] != null ? new DetailNews.fromJson(json['data']) : null;
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

class DetailNews {
  String sId;
  String link;
  String title;
  String image;
  String topic;
  String publisher;
  String date;
  String news;
  String createdAt;
  String updatedAt;
  int iV;
  bool isBookmark;
  int views;

  DetailNews(
      {this.sId,
      this.link,
      this.title,
      this.image,
      this.topic,
      this.publisher,
      this.date,
      this.news,
      this.createdAt,
      this.updatedAt,
      this.isBookmark,
      this.views,
      this.iV});

  DetailNews.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    link = json['link'];
    title = json['title'];
    image = json['image'];
    topic = json['topic'];
    publisher = json['publisher'];
    date = json['date'];
    news = json['news'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    isBookmark = json['isBookmark'];
    views = json['views'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['link'] = this.link;
    data['title'] = this.title;
    data['image'] = this.image;
    data['topic'] = this.topic;
    data['publisher'] = this.publisher;
    data['date'] = this.date;
    data['news'] = this.news;
    data['createdAt'] = this.createdAt;
    data['isBookmark'] = this.isBookmark;
    data['views'] = this.views;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
