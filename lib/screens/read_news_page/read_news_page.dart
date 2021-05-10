import 'package:flutter/material.dart';
import './read_news_page_view.dart';

class ReadNewsPage extends StatefulWidget {
  final String idNews;
  final String from;
  final bool isFromBookmark;
  final bool isRemove;

  const ReadNewsPage({
    Key key,
    this.idNews,
    this.from,
    this.isFromBookmark = false, this.isRemove,
  }) : super(key: key);

  @override
  ReadNewsPageView createState() => new ReadNewsPageView();
}
