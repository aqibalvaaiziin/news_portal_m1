import 'package:news/api/interceptor/remote_interceptor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewsServices extends Api {
  Future getAllNews() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String token = sp.getString("token");
    print("token :$token");
    var response;
    if (token == null) {
      response = await wrapApi(
        () => dio.get<dynamic>('/news'),
      );
    } else {
      dio.options.headers['Authorization'] = "bearer $token";
      response = await wrapApi(
        () => dio.get<dynamic>('/loggedin/news'),
      );
    }
    return response;
  }

  Future getNewsByTopic(String topic) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String token = sp.getString("token");
    print("token :$token");
    var response;
    if (token == null) {
      response = await wrapApi(
        () => dio.get<dynamic>('/news/topic/$topic'),
      );
    } else {
      dio.options.headers['Authorization'] = "bearer $token";
      response = await wrapApi(
        () => dio.get<dynamic>('/loggedin/news/topic/$topic'),
      );
    }
    return response;
  }

  Future getNewsByPublisher(String publisherName) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String token = sp.getString("token");
    print("token :$token");
    var response;
    if (token == null) {
      response = await wrapApi(
        () => dio.get<dynamic>('/news/publisher/$publisherName'),
      );
    } else {
      dio.options.headers['Authorization'] = "bearer $token";
      response = await wrapApi(
        () => dio.get<dynamic>('/loggedin/news/publisher/$publisherName'),
      );
    }
    return response;
  }

  Future getDetailNews(String id) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String token = sp.getString("token");
    print("token :$token");
    var response;
    if (token == null) {
      response = await wrapApi(
        () => dio.get<dynamic>('/news/$id'),
      );
    } else {
      dio.options.headers['Authorization'] = "bearer $token";
      response = await wrapApi(
        () => dio.get<dynamic>('/loggedin/news/$id'),
      );
    }
    return response;
  }

  Future getNewsSearchTitle(String search) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String token = sp.getString("token");
    print("token :$token");
    var response;
    if (token == null) {
      response = await wrapApi(
        () => dio.get<dynamic>('/news/title/$search'),
      );
    } else {
      dio.options.headers['Authorization'] = "bearer $token";
      response = await wrapApi(
        () => dio.get<dynamic>(
          '/loggedin/news/title/$search',
        ),
      );
    }
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
