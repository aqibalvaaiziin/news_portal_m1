import 'package:flutter/material.dart';
import 'package:news/api/services/user_service.dart';
import 'package:news/helpers/preferences/preferences_data.dart';
import 'package:news/screens/navigator_page/navigator_page.dart';
import 'package:news/screens/topic_list_page/topic_list_page.dart';
import 'package:news/widgets/custom_widet.dart';
import 'package:news/widgets/reoute_navigator.dart';
import './register_page.dart';

abstract class RegisterPageViewModel extends State<RegisterPage> {
  double width;
  double height;
  bool isVisible = true;
  bool isLoading = false;
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController reTypePassword = TextEditingController();
  UserServices userServices = UserServices();
  PreferencesData preferencesData = PreferencesData();

  registerAction() {
    bool conditionAllFill = username.text.isNotEmpty &&
        email.text.isNotEmpty &&
        password.text.isNotEmpty &&
        reTypePassword.text.isNotEmpty;
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email.text);
    bool conditionPassword = password.text == reTypePassword.text;
    setState(() {
      isLoading = true;
    });

    if (conditionAllFill) {
      if (emailValid) {
        if (conditionPassword) {
          userServices
              .register(
            username.text,
            email.text,
            password.text,
          )
              .then((value) {
            var jsonObject = value.data;
            if (jsonObject['statusCode'] == 200) {
              loginAction();
            }
          });
        } else {
          setState(() {
            isLoading = false;
          });

          flushBar(
            context,
            "Input Register",
            "Password tidak sesuai",
            Icons.close,
            color: Colors.red,
          );
        }
      } else {
        setState(() {
          isLoading = false;
        });
        flushBar(
          context,
          "Input Register",
          "Format email tidak sesuai",
          Icons.close,
          color: Colors.red,
        );
      }
    } else {
      setState(() {
        isLoading = false;
      });
      flushBar(
        context,
        "Input Register",
        "Lenkapi data terlebih dahulu",
        Icons.close,
        color: Colors.red,
      );
    }
  }

  loginAction() async {
    userServices.login(email.text, password.text).then((value) {
      var rawData = value.data;
      if (rawData['statusCode'] == 200) {
        setState(() {
          preferencesData.setUserToken(rawData['data']['token']);
          preferencesData.setUserData(
              rawData['data']['name'], rawData['data']['email']);
          preferencesData.setIsLoggedIn(true);
        });
        if (rawData['data']['topic'].length == 0) {
          nextPageRemove(context, TopicListPage());
        } else {
          preferencesData.setIsUserHasTopic(true);
          nextPageRemove(context, NavigatorPage(currentPage: 0));
        }
      } else {
        flushBar(
          context,
          "Login Gagal",
          rawData['message'],
          Icons.close,
          color: Colors.red,
        );
      }
    });
  }
}
