import 'package:flutter/material.dart';
import 'package:news/helpers/global.dart';
import 'package:news/screens/navigator_page/navigator_page.dart';
import 'package:news/screens/on_boarding_page/on_boarding_page.dart';
import 'package:news/screens/topic_list_page/topic_list_page.dart';
import 'package:news/widgets/custom_widet.dart';
import 'package:news/widgets/reoute_navigator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreenPage> {
  autologin() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    bool isLoggedIn = sp.getBool("isLoggedIn") ?? false;
    bool isHasTopic = sp.getBool("isHasTopic") ?? false;
    bool isAlreadyOpenOnboarding =
        sp.getBool("isAlreadyOpenOnboarding") ?? false;
    Future.delayed(const Duration(seconds: 3), () {
      if (isLoggedIn) {
        if (isHasTopic) {
          nextPageRemove(
            context,
            NavigatorPage(),
          );
        } else {
          nextPageRemove(
            context,
            TopicListPage(),
          );
        }
      } else if (isAlreadyOpenOnboarding) {
        nextPageRemove(
          context,
          NavigatorPage(),
        );
      } else {
        nextPageRemove(context, OnBoardingPage());
      }
    });
  }

  @override
  void initState() {
    super.initState();
    autologin();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              ImageBoarding.splash,
              width: width * 0.6,
              height: width * 0.6,
            ),
            montserratText(width * 0.08, "Panen.id",
                fw: FontWeight.w800, color: Colors.white)
          ],
        ),
      ),
    );
  }
}
