import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/helpers/global.dart';

Widget customNavigationBar(
  double width,
  double height,
  int currentPage,
  Function(int) navigationTapped,
) {
  double sizeIconNav = width * 0.055;
  return Container(
    height: height * 0.08,
    padding: EdgeInsets.symmetric(vertical: 5),
    child: CupertinoTabBar(
      backgroundColor: Colors.white,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            size: sizeIconNav,
            color:
                (currentPage == 0) ? ClassColors.maincolor : ClassColors.black,
          ),
          // ignore: deprecated_member_use
          title: Text(
            "Home",
            style: TextStyle(
                color: (currentPage == 0)
                    ? ClassColors.maincolor
                    : ClassColors.black,
                fontSize: 12),
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.search,
            size: sizeIconNav,
            color:
                (currentPage == 1) ? ClassColors.maincolor : ClassColors.black,
          ),
          // ignore: deprecated_member_use
          title: Text(
            "Search",
            style: TextStyle(
                color: (currentPage == 1)
                    ? ClassColors.maincolor
                    : ClassColors.black,
                fontSize: 12),
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.bookmark,
            color:
                (currentPage == 2) ? ClassColors.maincolor : ClassColors.black,
            size: sizeIconNav,
          ),
          // ignore: deprecated_member_use
          title: Text(
            "Bookmark",
            style: TextStyle(
                color: (currentPage == 2)
                    ? ClassColors.maincolor
                    : ClassColors.black,
                fontSize: 12),
          ),
        ),
      ],
      currentIndex: currentPage,
      onTap: navigationTapped,
    ),
  );
}
