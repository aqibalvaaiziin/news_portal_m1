import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:news/api/services/user_service.dart';
import 'package:news/helpers/preferences/preferences_data.dart';
import 'package:news/models/all_news_model.dart';
import 'package:news/redux/actions/news_state_action.dart';
import 'package:news/redux/models/app_state_model.dart';
import 'package:news/screens/navigator_page/navigator_page.dart';
import 'package:news/screens/topic_list_page/topic_list_page.dart';
import 'package:news/widgets/custom_widet.dart';
import 'package:news/widgets/reoute_navigator.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './bookmark_page.dart';

abstract class BookmarkPageViewModel extends State<BookmarkPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  double width;
  double height;
  bool isVisible = true;
  UserServices userServices = UserServices();
  PreferencesData preferencesData = PreferencesData();
  bool isLoggedIn = true;
  bool isLoading = true;
  bool isLoginLoading = false;
  bool isHaveToken = true;
  // ignore: deprecated_member_use
  List<AllNews> bookmarkList = List<AllNews>();
  Store<AppState> store;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  String dataNews = "";
  String dataTopic = "";

  // checkToken() async {
  //   SharedPreferences sp = await SharedPreferences.getInstance();
  //   setState(() {
  //     // isHaveToken = sp.getString("token") == null ? false : true;
  //     if (isHaveToken) {
  //       getDataBookMark();
  //     }
  //   });
  // }

  getDataBookmarkPref() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    // sp.clear();
    setState(() {
      dataNews = sp.getString("bookmark");
      dataTopic = sp.getString("topic");
      isLoading = false;
    });
  }

  getDataBookMark() {
    userServices.getBookmark().then((value) {
      var jsonObject = AllNewsList.fromJson(value.data);
      setState(() {
        store.dispatch(SetBookmarkList(bookmarkList));
        store.dispatch(SetBookmarkList(List.from(jsonObject.data)));
        isLoading = false;
      });
    });
  }

  loginAction() async {
    bool condition = email.text.isNotEmpty && password.text.isNotEmpty;
    if (condition) {
      setState(() {
        isLoginLoading = true;
      });
      userServices.login(email.text, password.text).then((value) {
        var rawData = value.data;
        if (rawData['statusCode'] == 200) {
          setState(() {
            preferencesData.setUserToken(rawData['data']['token']);
            preferencesData.setUserData(
                rawData['data']['name'], rawData['data']['email']);
            preferencesData.setIsLoggedIn(true);
            isLoggedIn = true;
          });
          if (rawData['data']['topic'].length == 0) {
            nextPageRemove(context, TopicListPage());
          } else {
            preferencesData.setIsUserHasTopic(true);
            nextPageRemove(context, NavigatorPage(currentPage: 0));
          }
        } else {
          setState(() {
            isLoginLoading = false;
          });
          flushBar(
            context,
            "Login Gagal",
            rawData['message'],
            Icons.close,
            color: Colors.red,
          );
        }
      });
    } else {
      setState(() {
        isLoginLoading = false;
      });
      flushBar(
        context,
        "Login Gagal",
        "Lengkapi email dan password terlebih dahulu",
        Icons.close,
      );
    }
  }

  successRegister() {
    flushBar(
      context,
      "Register",
      "Register Berhasil",
      Icons.check_circle,
      color: Colors.green,
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      store = StoreProvider.of<AppState>(context);
      // checkToken();
      getDataBookMark();
      // getDataBookmarkPref();

      if (widget.isFromRegister) {
        successRegister();
      }
    });
  }
}
