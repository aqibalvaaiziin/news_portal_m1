import 'package:flutter/material.dart';
import 'topic_page_view.dart';

class TopicPage extends StatefulWidget {
  final bool isFromRegister;

  const TopicPage({Key key, this.isFromRegister=false}) : super(key: key);

  @override
  TopicPageView createState() => new TopicPageView();
}
