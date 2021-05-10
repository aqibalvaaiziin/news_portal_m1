import 'package:flutter/material.dart';
import './navigator_page.dart';

abstract class NavigatorPageViewModel extends State<NavigatorPage> {
  double width;
  double height;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  int currentIndex;
  PageController pageController;

  void onPageChangedAction(int page) {
    setState(() {
      currentIndex = page;
    });
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  @override
  void initState() {
    super.initState();
    currentIndex = this.widget.currentPage ?? 0;
    pageController = PageController(initialPage: currentIndex);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
