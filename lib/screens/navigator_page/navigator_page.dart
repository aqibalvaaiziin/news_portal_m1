import 'package:flutter/material.dart';
import './navigator_page_view.dart';

class NavigatorPage extends StatefulWidget {
  final int currentPage;
  final bool isFromRegister;

  const NavigatorPage({Key key, this.currentPage, this.isFromRegister = false})
      : super(key: key);

  @override
  NavigatorPageView createState() => new NavigatorPageView();
}
