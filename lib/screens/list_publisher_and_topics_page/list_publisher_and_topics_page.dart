import 'package:flutter/material.dart';
import './list_publisher_and_topics_page_view.dart';

class ListPublisherAndTopicsPage extends StatefulWidget {
  final String from;
  final String name;
  final String image;
  final String topicName;
  final IconData iconData;

  const ListPublisherAndTopicsPage({
    Key key,
    this.from,
    this.name,
    this.image,
    this.iconData,
    this.topicName,
  }) : super(key: key);
  @override
  ListPublisherAndTopicsPageView createState() =>
      new ListPublisherAndTopicsPageView();
}
