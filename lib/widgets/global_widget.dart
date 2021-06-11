import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:news/api/services/news_services.dart';
import 'package:news/api/services/user_service.dart';
import 'package:news/helpers/global.dart';
import 'package:news/models/all_news_model.dart';
import 'package:news/redux/actions/news_state_action.dart';
import 'package:news/redux/models/app_state_model.dart';
import 'package:news/screens/read_news_page/read_news_page.dart';
import 'package:news/widgets/reoute_navigator.dart';
import 'package:news/widgets/shimmer/search_shimmer.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'custom_widet.dart';

class BuildCardList extends StatefulWidget {
  final List<AllNews> list;
  final bool isLoading;
  final String listFrom;
  final String name;

  const BuildCardList({
    Key key,
    this.list,
    this.isLoading,
    this.listFrom,
    this.name = "",
  }) : super(key: key);

  @override
  _BuildCardListState createState() => _BuildCardListState();
}

class _BuildCardListState extends State<BuildCardList> {
  double width;
  double height;
  bool isHaveToken = false;
  bool isLoading = false;
  UserServices userServices = UserServices();
  Store<AppState> store;
  // ignore: deprecated_member_use
  List<AllNews> defaultList = List<AllNews>();
  NewsServices newsServices = NewsServices();

  checkToken() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      isHaveToken = sp.getString("token") == null ? false : true;
      print(sp.getString("token"));
      print(isHaveToken);
    });
  }

  getDataBookMark() {
    userServices.getBookmark().then((value) {
      var jsonObject = AllNewsList.fromJson(value.data);
      setState(() {
        store.dispatch(SetBookmarkList(defaultList));
        store.dispatch(SetBookmarkList(List.from(jsonObject.data)));
        isLoading = false;
      });
    });
  }

  getSearchNews(String text) {
    newsServices.getNewsSearchTitle(text).then((value) {
      var jsonObject = AllNewsList.fromJson(value.data);
      if (jsonObject.statusCode == 200) {
        setState(() {
          print(jsonObject.data.length);
          store.dispatch(SetSearchNewsList(defaultList));
          store.dispatch(SetSearchNewsList(List.from(jsonObject.data)));
        });
      }
    });
  }

  getNewsHome() {
    newsServices.getAllNews().then((value) {
      var jsonObject = AllNewsList.fromJson(value.data);
      if (jsonObject.statusCode == 200) {
        setState(() {
          store.dispatch(SetHomeAllsList(defaultList));
          store.dispatch(SetHomeAllsList(List.from(jsonObject.data)));
        });
      }
    });
  }

  getListTopic() {
    newsServices.getNewsByTopic(widget.name).then((value) {
      var jsonObject = AllNewsList.fromJson(value.data);
      setState(() {
        store.dispatch(SetTopicPublisherList(defaultList));
        store.dispatch(SetTopicPublisherList(List.from(jsonObject.data)));
        isLoading = false;
      });
    });
  }

  getListPublisher() {
    newsServices.getNewsByPublisher(widget.name).then((value) {
      var jsonObject = AllNewsList.fromJson(value.data);
      setState(() {
        store.dispatch(SetTopicPublisherList(defaultList));
        store.dispatch(SetTopicPublisherList(List.from(jsonObject.data)));
        isLoading = false;
      });
    });
  }

  bookmarkSearch(String idNews, {bool isAdd = true}) {
    String dataFilter = store.state.newsState.searchText;
    setState(() {
      store.dispatch(SetSearchNewsBookmark(idNews));
    });
    if (isAdd) {
      userServices.addBookmark(idNews).then((value) {
        getSearchNews(dataFilter);
      });
    } else {
      userServices.removeBookmark(idNews).then((value) {
        getSearchNews(dataFilter);
      });
    }
  }

  bookmarkHome(String idNews, {bool isAdd = true}) {
    setState(() {
      store.dispatch(SetHomeAllNewsBookmark(idNews));
    });
    if (isAdd) {
      userServices.addBookmark(idNews).then((value) {
        getNewsHome();
      });
    } else {
      userServices.removeBookmark(idNews).then((value) {
        getNewsHome();
      });
    }
  }

  bookmarkFromBookmark(String idNews, {bool isAdd = true}) {
    setState(() {
      store.dispatch(SetBookmarkPageBookmark(idNews));
    });
    if (isAdd) {
      userServices.addBookmark(idNews).then((value) {
        getDataBookMark();
      });
    } else {
      userServices.removeBookmark(idNews).then((value) {
        getDataBookMark();
      });
    }
  }

  bookmarkFromTopic(String idNews, {bool isAdd = true}) {
    setState(() {
      store.dispatch(SetTopicPublisherPageBookmark(idNews));
    });
    if (isAdd) {
      userServices.addBookmark(idNews).then((value) {
        getListTopic();
      });
    } else {
      userServices.removeBookmark(idNews).then((value) {
        getListTopic();
      });
    }
  }

  bookmarkFromPublisher(String idNews, {bool isAdd = true}) {
    setState(() {
      store.dispatch(SetTopicPublisherPageBookmark(idNews));
    });
    if (isAdd) {
      userServices.addBookmark(idNews).then((value) {
        getListPublisher();
      });
    } else {
      userServices.removeBookmark(idNews).then((value) {
        getListPublisher();
      });
    }
  }

  addToBookMark(idNews) {
    if (widget.listFrom == "search") {
      bookmarkSearch(idNews);
    } else if (widget.listFrom == "home") {
      bookmarkHome(idNews);
    } else if (widget.listFrom == "bookmark") {
      bookmarkFromBookmark(idNews);
    } else if (widget.listFrom == "topic") {
      bookmarkFromTopic(idNews);
    } else if (widget.listFrom == "publisher") {
      bookmarkFromPublisher(idNews);
    }
  }

  removeFromBookMark(idNews) {
    if (widget.listFrom == "search") {
      bookmarkSearch(idNews, isAdd: false);
    } else if (widget.listFrom == "home") {
      bookmarkHome(idNews, isAdd: false);
    } else if (widget.listFrom == "bookmark") {
      bookmarkFromBookmark(idNews, isAdd: false);
    } else if (widget.listFrom == "topic") {
      bookmarkFromTopic(idNews, isAdd: false);
    } else if (widget.listFrom == "publisher") {
      bookmarkFromPublisher(idNews, isAdd: false);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      store = StoreProvider.of<AppState>(context);
      print("length:${widget.list.length}");
      checkToken();
    });
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return buildListCard();
  }

  Widget buildListCard() {
    return widget.isLoading
        ? SearchShimmer()
        : Stack(
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: widget.list.length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, i) {
                  return itemNews(widget.list[i]);
                },
              ),
              widget.listFrom == "bookmark" && isLoading
                  ? isLoadAction(width, height, isBlank: true)
                  : SizedBox()
            ],
          );
  }

  Widget itemNews(AllNews data) {
    return Container(
      width: width,
      margin: EdgeInsets.only(top: height * 0.02),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(width * 0.03),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[300],
              offset: Offset(1, 1),
              spreadRadius: 1,
              blurRadius: 1,
            ),
          ]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(width * 0.03),
        child: MaterialButton(
          padding: EdgeInsets.all(width * 0.04),
          onPressed: () {
            nextPage(
              context,
              ReadNewsPage(
                idNews: data.sId,
                from: widget.listFrom,
              ),
            );
          },
          child: Row(
            children: [
              data.image == " " || data.image == null
                  ? buildNoImage(
                      width * 0.23,
                      height * 0.23,
                      width * 0.035,
                      radius: width * 0.02,
                    )
                  : buildNetworkImage(
                      width * 0.23,
                      width * 0.23,
                      data.image,
                      radius: width * 0.02,
                      fit: BoxFit.cover,
                    ),
              SizedBox(width: width * 0.03),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: width * 0.5,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        data.title,
                        style: TextStyle(
                          fontSize: width * 0.035,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(height: height * 0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        sarabunText(
                          width * 0.025,
                          data.date,
                          fw: FontWeight.w500,
                        ),
                        InkWell(
                          borderRadius: BorderRadius.circular(width * 0.011),
                          child: Padding(
                            padding: EdgeInsets.all(width * 0.01),
                            child: Icon(
                              Icons.bookmark,
                              size: width * 0.05,
                              color: data.isBookmark
                                  ? ClassColors.maincolor
                                  : Colors.grey,
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              isLoading = true;
                            });
                            if (data.isBookmark) {
                              flushBar(
                                context,
                                "Bookmark",
                                "Bookmark Berhasil Dihapus",
                                Icons.check_circle,
                                color: Colors.green,
                              );
                              removeFromBookMark(data.sId.toString());
                            } else {
                              flushBar(
                                context,
                                "Bookmark",
                                "Berita Berhasil Ditambahkan ke Bookmark",
                                Icons.check_circle,
                                color: Colors.green,
                              );
                              addToBookMark(data.sId.toString());
                            }
                          },
                        )
                      ],
                    ),
                    sarabunText(
                      width * 0.03,
                      data.publisher,
                      fw: FontWeight.bold,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
