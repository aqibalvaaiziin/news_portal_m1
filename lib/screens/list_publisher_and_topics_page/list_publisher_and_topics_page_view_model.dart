import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:news/api/services/news_services.dart';
import 'package:news/models/all_news_model.dart';
import 'package:news/redux/actions/news_state_action.dart';
import 'package:news/redux/models/app_state_model.dart';
import 'package:redux/redux.dart';
import './list_publisher_and_topics_page.dart';

abstract class ListPublisherAndTopicsPageViewModel
    extends State<ListPublisherAndTopicsPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  double width;
  double height;
  bool isLoading = true;
  NewsServices newsServices = NewsServices();
  Store<AppState> store;
  // ignore: deprecated_member_use
  List<AllNews> defaultValue = List<AllNews>();

  getListTopic() {
    newsServices.getNewsByTopic(widget.topicName).then((value) {
      var jsonObject = AllNewsList.fromJson(value.data);
      setState(() {
        store.dispatch(SetTopicPublisherList(defaultValue));
        store.dispatch(SetTopicPublisherList(List.from(jsonObject.data)));
        isLoading = false;
      });
    });
  }

  getListPublisher() {
    newsServices.getNewsByPublisher(widget.name).then((value) {
      var jsonObject = AllNewsList.fromJson(value.data);
      setState(() {
        store.dispatch(SetTopicPublisherList(defaultValue));
        store.dispatch(SetTopicPublisherList(List.from(jsonObject.data)));
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      store = StoreProvider.of<AppState>(context);
      if (widget.from == "topic") {
        getListTopic();
      } else {
        getListPublisher();
      }
    });
  }
}
