import 'package:flutter/material.dart';
import './bookmark_page_view.dart';

class BookmarkPage extends StatefulWidget {
  final bool isFromRegister;

  const BookmarkPage({Key key, this.isFromRegister=false}) : super(key: key);
  
  @override
  BookmarkPageView createState() => new BookmarkPageView();
}
  
