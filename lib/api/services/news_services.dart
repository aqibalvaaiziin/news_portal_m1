import 'dart:convert';

import 'package:news/api/interceptor/remote_interceptor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewsServices extends Api {
  Future getAllNews() async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    var response;
    String bookmarkData = sp.getString("bookmark");
    Map data = {
      "bookmark": bookmarkData == "" ? [] : jsonDecode(bookmarkData),
    };
    response = await wrapApi(
      () => dio.post<dynamic>('/news', data: data),
    );

    return response;
  }

  Future getNewsByTopic(String topic) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String bookmarkData = sp.getString("bookmark");
    Map data = {
      "bookmark": bookmarkData == "" ? [] : jsonDecode(bookmarkData),
    };
    var response;

    response = await wrapApi(
      () => dio.post<dynamic>('/news/topic/$topic', data: data),
    );

    return response;
  }

  Future getNewsByPublisher(String publisherName) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var response;

    String bookmarkData = sp.getString("bookmark");
    Map data = {
      "bookmark": bookmarkData == "" ? [] : jsonDecode(bookmarkData),
    };
    response = await wrapApi(
      () => dio.post<dynamic>('/news/publisher/$publisherName', data: data),
    );

    return response;
  }

  Future getDetailNews(String id) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String bookmarkData = sp.getString("bookmark");
    Map data = {
      "bookmark": bookmarkData == "" ? [] : jsonDecode(bookmarkData),
    };
    var response;

    response = await wrapApi(
      () => dio.post<dynamic>('/news/$id', data: data),
    );

    return response;
  }

  Future getNewsSearchTitle(String search) async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    String bookmarkData = sp.getString("bookmark");
    Map data = {
      "bookmark": bookmarkData == "" ? [] : jsonDecode(bookmarkData),
    };
    var response;

    response = await wrapApi(
      () => dio.post<dynamic>('/news/title/$search', data: data),
    );

    return response;
  }

  Future getPublisher() async {
    final response = await wrapApi(
      () => dio.get<dynamic>(
        '/publisher',
      ),
    );

    return response;
  }
}
