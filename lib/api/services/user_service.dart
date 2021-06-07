import 'package:news/api/interceptor/remote_interceptor.dart';
import 'package:news/helpers/preferences/preferences_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserServices extends Api {
  Future login(
    String email,
    String password,
  ) async {
    Map<String, dynamic> dataMap = {
      "email": email,
      "password": password,
    };
    print("email : $email");

    final response = await wrapApi(
      () => dio.post<dynamic>(
        '/user/loginAndroid',
        data: dataMap,
      ),
    );
    print("response:$response");
    return response;
  }

  Future register(
    String username,
    String email,
    String password,
  ) async {
    Map<String, dynamic> dataMap = {
      "name": username,
      "email": email,
      "password": password,
    };
    print("email : $email");

    final response = await wrapApi(
      () => dio.post<dynamic>(
        '/user',
        data: dataMap,
      ),
    );
    print("response:$response");
    return response;
  }

  Future getUserProfile() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String token = sp.getString("token");
    print("token :$token");
    dio.options.headers['Authorization'] = "bearer $token";
    final response = await wrapApi(
      () => dio.get<dynamic>(
        '/usertopic',
      ),
    );
    print("response:$response");
    return response;
  }

  Future addBookmark(String news) async {
    PreferencesData preferencesData = PreferencesData();
    SharedPreferences sp = await SharedPreferences.getInstance();
    String oldData = sp.getString("bookmark");
    String notANewsData = oldData == "" ? "$news" : "$oldData";
    String newData = oldData == "" ? "$news" : "$notANewsData,  $news";
    preferencesData.setBookmark(newData);
    // String token = sp.getString("token");
    // print("token :$token");
    // dio.options.headers['Authorization'] = "bearer $token";
    // Map<String, dynamic> dataMap = {
    //   "news": idNews,
    // };
    // final response = await wrapApi(
    //   () => dio.post<dynamic>(
    //     '/bookmark',
    //     data: dataMap,
    //   ),
    // );
    // print("response:$response");
    // return response;
  }

  Future removeBookmark(String idNews) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String token = sp.getString("token");
    print("token :$token");
    dio.options.headers['Authorization'] = "bearer $token";
    Map<String, dynamic> dataMap = {
      "news": idNews,
    };
    final response = await wrapApi(
      () => dio.delete<dynamic>(
        '/bookmark',
        data: dataMap,
      ),
    );
    print("response:$response");
    return response;
  }

  Future getBookmark() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String token = sp.getString("token");
    print("token :$token");
    dio.options.headers['Authorization'] = "bearer $token";

    final response = await wrapApi(
      () => dio.get<dynamic>(
        '/bookmark/my',
      ),
    );
    print("response:$response");
    return response;
  }

  Future addTopic(String idTopic) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String token = sp.getString("token");
    print("token :$token");
    dio.options.headers['Authorization'] = "bearer $token";
    Map<String, dynamic> dataMap = {"topic": idTopic};
    final response = await wrapApi(
      () => dio.post<dynamic>('/usertopic', data: dataMap),
    );
    print("response:$response");
    return response;
  }

  Future removeTopic(String idTopic) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String token = sp.getString("token");
    print("token :$token");
    dio.options.headers['Authorization'] = "bearer $token";
    Map<String, dynamic> dataMap = {"topic": idTopic};
    final response = await wrapApi(
      () => dio.delete<dynamic>('/usertopic', data: dataMap),
    );
    print("response:$response");
    return response;
  }

  Future getListTopic() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String token = sp.getString("token");
    print("token :$token");
    dio.options.headers['Authorization'] = "bearer $token";
    final response = await wrapApi(
      () => dio.get<dynamic>('/topic'),
    );
    print("response:$response");
    return response;
  }
}
