import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:news/api/services/news_services.dart';
import 'package:news/models/all_news_model.dart';
import 'package:news/models/publisher_model.dart';
import 'package:news/redux/actions/news_state_action.dart';
import 'package:news/redux/models/app_state_model.dart';
import 'package:redux/redux.dart';
import './search_page.dart';

abstract class SearchPageViewModel extends State<SearchPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  double width;
  double height;
  TextEditingController searchController = TextEditingController();
  NewsServices newsServices = NewsServices();
  // ignore: deprecated_member_use
  List<AllNews> allNews = List<AllNews>();
  // ignore: deprecated_member_use
  List<AllNews> tempAllNews = List<AllNews>();
  // ignore: deprecated_member_use
  List<PublisherModel> publisherList = List<PublisherModel>();
  Timer _debounce;
  String filter;
  bool isLoading = false;
  bool firstLoading = true;
  Store<AppState> store;

  getNews(String text) {
    newsServices.getNewsSearchTitle(text).then((value) {
      var jsonObject = AllNewsList.fromJson(value.data);
      if (jsonObject.statusCode == 200) {
        setState(() {
          print(jsonObject.data.length);
          store.dispatch(SetSearchNewsList(allNews));
          store.dispatch(SetSearchNewsList(List.from(jsonObject.data)));
          isLoading = false;
        });
      }
    });
  }

  void searchStoreData(String text) async {
    if (_debounce?.isActive ?? false) _debounce.cancel();
    setState(() {
      isLoading = true;
    });
    _debounce = Timer(const Duration(milliseconds: 500), () {
      setState(() {
        filter = text;
        store.dispatch(SearchText(text));
        if (filter != "") {
          getNews(filter);
        } else {
          isLoading = false;
  // ignore: deprecated_member_use
          allNews = List<AllNews>();
        }
      });
    });
  }

  getListPublisher() {
    newsServices.getPublisher().then((value) {
      var jsonObject = PublisherResponse.fromJson(value.data);
      if (jsonObject.statusCode == 200) {
        setState(() {
          publisherList.addAll(jsonObject.data);
          firstLoading = false;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      store = StoreProvider.of<AppState>(context);
      getListPublisher();
    });
  }

  @override
  void dispose() {
    searchController.clear();
    searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }
}
