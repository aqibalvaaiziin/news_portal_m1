import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:news/screens/bookmark_page/bookmark_page.dart';
import 'package:news/screens/home_page/home_page.dart';
import 'package:news/screens/search_page/search_page.dart';
import 'package:news/screens/topic_list_page/topic_list_page.dart';
import 'package:news/widgets/bottom_bar.dart';
import 'package:news/widgets/custom_widet.dart';
import './navigator_page_view_model.dart';

class NavigatorPageView extends NavigatorPageViewModel {
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return CustomScaffold(
      body: DoubleBackToCloseApp(
        snackBar: const SnackBar(
          content: Text('Tekan lagi untuk keluar'),
        ),
        child: PageView(
          controller: pageController,
          onPageChanged: onPageChangedAction,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            HomePage(),
            SearchPage(),
            BookmarkPage(isFromRegister: widget.isFromRegister),
            TopicListPage(),
          ],
        ),
      ),
      bottomNavigationBar: customNavigationBar(
        width,
        height,
        currentIndex,
        navigationTapped,
      ),
    );
  }
}
