import 'package:flutter/material.dart';
import 'package:news/api/services/user_service.dart';
import 'package:news/helpers/preferences/preferences_data.dart';
import 'package:news/screens/navigator_page/navigator_page.dart';
import 'package:news/screens/on_boarding_page/on_boarding_page.dart';
import 'package:news/screens/topic_list_page/topic_list_page.dart';
import 'package:news/widgets/custom_widet.dart';
import 'package:news/widgets/reoute_navigator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'topic_page.dart';

abstract class TopicPageViewModel extends State<TopicPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  double width;
  double height;
  bool isLoading = true;
  String image = "";
  String name = "";
  String googleId = "";
  String email = "";
  bool isLoggedIn = true;
  bool isVisible = true;
  bool isLoginLoading = false;
  bool haveNews = false;
  bool haveTravel = false;
  bool haveTech = false;
  bool haveSeleb = false;
  bool haveSport = false;
  bool haveHealth = false;
  bool isHaveToken;
  bool topicLoading = false;
  UserServices userServices = UserServices();
  PreferencesData preferencesData = PreferencesData();
  TextEditingController emailInput = TextEditingController();
  TextEditingController password = TextEditingController();
  checkToken() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      image = sp.getString("image");
      name = sp.getString("name");
      email = sp.getString("email");
      isHaveToken = sp.getString("token") == null ? false : true;
      if (isHaveToken) {}
    });
  }

  addTopicAction(String idTopic) {
    setState(() {
      backScreen(context);
      topicLoading = true;
    });
    userServices.addTopic(idTopic).then((value) {
      var jsonObject = value.data;
      if (jsonObject['statusCode'] == 200) {
        nextPageRemove(context, NavigatorPage(currentPage: 3));
      } else {
        setState(() {
          topicLoading = false;
        });
      }
    });
  }

  loginAction() async {
    bool condition = emailInput.text.isNotEmpty && password.text.isNotEmpty;
    if (condition) {
      setState(() {
        isLoginLoading = true;
      });
      userServices.login(emailInput.text, password.text).then((value) {
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

  removeTopicAction(String idTopic) {
    setState(() {
      backScreen(context);
      topicLoading = true;
    });
    userServices.removeTopic(idTopic).then((value) {
      var jsonObject = value.data;
      if (jsonObject['statusCode'] == 200) {
        nextPageRemove(context, NavigatorPage(currentPage: 3));
      } else {
        setState(() {
          topicLoading = false;
        });
      }
    });
  }

  getDataUser() {
    userServices.getUserProfile().then((value) {
      print("value:$value");
      setState(() {
        value.forEach((element) {
          if (element == "News") {
            haveNews = true;
          } else if (element == "Techno") {
            haveTech = true;
          } else if (element == "Seleb") {
            haveSeleb = true;
          } else if (element == "Health") {
            haveHealth = true;
          } else if (element == "Sport") {
            haveSport = true;
          } else if (element == "Travel") {
            haveTravel = true;
          }
        });
        isLoading = false;
      });
    });
  }

  logoutAction() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.clear();
    nextPageRemove(context, OnBoardingPage());
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
    // checkToken();
    getDataUser();

    if (widget.isFromRegister) {
      successRegister();
    }
  }
}
