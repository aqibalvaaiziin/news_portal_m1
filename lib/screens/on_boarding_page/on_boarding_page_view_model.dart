import 'package:flutter/material.dart';
import 'package:news/helpers/global.dart';
import 'package:news/helpers/preferences/preferences_data.dart';
import './on_boarding_page.dart';

abstract class OnBoardingPageViewModel extends State<OnBoardingPage> {
  double width;
  double height;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  PageController pageController = PageController();
  PreferencesData preferencesData = PreferencesData();

  startOnboarding() {
    setState(() {
      pageController.animateToPage(1,
          duration: Duration(milliseconds: 600), curve: Curves.ease);
    });
  }

  List listOnboarding = [
    {
      "headerText": "Baca Berita Lewat Smartphone Anda",
      "footerText": "Cari berita berdasarkan minat anda",
      "image": ImageBoarding.board1,
    },
    {
      "headerText": "Keluasan Membaca Berita",
      "footerText": "Anda dapat membaca berita kapan saja dan dimana saja",
      "image": ImageBoarding.board2,
    },
    {
      "headerText": "Topic Berita",
      "footerText":
          "Anda dapat menambahkan daftar topic berita yang anda sukai sebagai rekomendasi berita anda",
      "image": ImageBoarding.board3,
    },
    {
      "headerText": "Kenyamanan",
      "footerText":
          "Anda dapat membaca berita sepuasnya tanpa takut terganggu dengan iklan",
      "image": ImageBoarding.board4,
    },
  ];
}
